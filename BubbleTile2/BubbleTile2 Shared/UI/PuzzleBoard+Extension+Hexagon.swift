///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension+Hexagon.swift

Created by: Zhaohui Xing on 2/28/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleBoard {
    func initializeHexagonPuzzle(layout layOut: enGridLayout, edge nEdge: Int, imageSet: Int) {
        let chipList = self.puzzle.chips
        let fInnerWidth : CGFloat = m_fBubbleSize*CGFloat(nEdge-1)
        let fInnerHeight : CGFloat = fInnerWidth*GameLayout.SQURT_3
        let ptCenter : CGPoint = GameLayout.GetGridCenter()
        let startX : CGFloat = ptCenter.x-fInnerWidth*0.5;
        let startY : CGFloat = ptCenter.y + fInnerHeight*0.5
        let deltaX : CGFloat = m_fBubbleSize*0.5
        let deltaY : CGFloat = deltaX*GameLayout.SQURT_3
        
        let nRows : Int = nEdge*2-1;
        var index : Int = 0
        for i in 0 ..< nRows {
            if i <= (nEdge-1)
            {
                for j in 0 ... (i+nEdge-1) {
                    let y : CGFloat = startY - deltaY*CGFloat(i)
                    var x : CGFloat = startX
                    let k : Int = i%2
                    let l : CGFloat = CGFloat(i)/2.0
                    if k == 0 {
                        x += (CGFloat(j)-l)*deltaX*2.0
                    } else {
                        x += (CGFloat(j)-l)*m_fBubbleSize;
                    }
                    let chip : PuzzleChip = PuzzleChip.CreatePuzzleChip(size: CGSize(width: m_fBubbleSize, height: m_fBubbleSize), imageset: imageSet, chipDat: chipList[index])
                    self.addChild(chip)
                    chip.position = CGPoint(x: x, y: y);
                    chip.alpha = 0.0
                    chip.run(SKAction.sequence([SKAction.scale(by: 0.5, duration: 0.01),
                                                SKAction.fadeIn(withDuration: GameLayout.GetGameStartAnimationTime()),
                                                SKAction.scale(by: 2.0, duration: GameLayout.GetGameStartAnimationTime())]))
                    m_ChipCenters.append(CGPoint(x: x, y: y))
                    index += 1
                }
            }
            else
            {
                for j in 0 ..< (nRows-i+nEdge-1) {
                    let y : CGFloat = startY - deltaY*CGFloat(i)
                    var x : CGFloat = startX
                    let k : Int = i%2
                    let l : CGFloat = CGFloat(nRows-i-1)/2.0
                    if k == 0 {
                        x += (CGFloat(j)-l)*deltaX*2.0
                    } else {
                        x += (CGFloat(j)-l)*m_fBubbleSize;
                    }
                    let chip : PuzzleChip = PuzzleChip.CreatePuzzleChip(size: CGSize(width: m_fBubbleSize, height: m_fBubbleSize), imageset: imageSet, chipDat: chipList[index])
                    self.addChild(chip)
                    chip.position = CGPoint(x: x, y: y);
                    chip.alpha = 0.0
                    chip.run(SKAction.sequence([SKAction.scale(by: 0.5, duration: 0.01),
                                                SKAction.fadeIn(withDuration: GameLayout.GetGameStartAnimationTime()),
                                                SKAction.scale(by: 2.0, duration: GameLayout.GetGameStartAnimationTime())]))
                    m_ChipCenters.append(CGPoint(x: x, y: y))
                    index += 1
                }
            }
        }
    }
    
    func ShiftBubbleTileChipDiagonalPuzzle(_ step: GamePlayStep) {
        switch step.motion {
            case enBubbleMotion.BUBBLE_MOTION_HORIZONTAL:
                let nRowIndex = self.puzzle.GetGridRow(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipHorizontalForward(row: nRowIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipHorizontalBackward(row: nRowIndex)
                    default:
                        return
                }
            case enBubbleMotion.BUBBLE_MOTION_60DIAGONAL:
                let nColIndex = self.puzzle.GetGridColumn(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipDiagonal60Forward(column: nColIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipDiagonal60Backward(column: nColIndex)
                    default:
                        return
                }
            case enBubbleMotion.BUBBLE_MOTION_120DIAGONAL:
                let nColIndex = self.puzzle.GetGridDiagonal120Column(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipDiagonal120Forward(column: nColIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipDiagonal120Backward(column: nColIndex)
                    default:
                        return
                }
            default:
                return
        }
    }
    

    func ShiftBubbleTileChipDiagonal60Forward(column: Int) {
        let nCount : Int = self.puzzle.GetDiagonal60ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            NotifyParentInvalidPlayStep()
            return
        }
        startAnimation()

        var chiplist : [PuzzleChip] = [PuzzleChip]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = self.puzzle.GetGridIndexAtDiagonal60Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        MoveNeigbhorDiagonal60Chips(column:column)
        
        MoveChipDiagonal60Forward(chip:chiplist[0], from: indexlist[0], to: indexlist[nCount-1])
        for i in 1 ... (nCount-1) {
            MoveChip(chip:chiplist[i], to: indexlist[i-1])
        }
    }
    
    func ShiftBubbleTileChipDiagonal60Backward(column: Int) {
        let nCount : Int = self.puzzle.GetDiagonal60ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            NotifyParentInvalidPlayStep()
            return
        }
        startAnimation()

        var chiplist : [PuzzleChip] = [PuzzleChip]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = self.puzzle.GetGridIndexAtDiagonal60Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        MoveNeigbhorDiagonal60Chips(column:column)
        
        MoveChipDiagonal60Backward(chip:chiplist[nCount-1], from: indexlist[nCount-1], to: indexlist[0])
        for i in 0 ... (nCount-2) {
            MoveChip(chip:chiplist[i], to: indexlist[i+1])
        }
    }

    func ShiftBubbleTileChipDiagonal120Forward(column: Int) {
        let nCount : Int = self.puzzle.GetDiagonal120ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            NotifyParentInvalidPlayStep()
            return
        }
        startAnimation()

        var chiplist : [PuzzleChip] = [PuzzleChip]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = self.puzzle.GetGridIndexAtDiagonal120Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        MoveNeigbhorDiagonal120Chips(column:column)
        
        MoveChipDiagonal120Forward(chip:chiplist[0], from: indexlist[0], to: indexlist[nCount-1])
        for i in 1 ... (nCount-1) {
            MoveChip(chip:chiplist[i], to: indexlist[i-1])
        }
    }
    
    func ShiftBubbleTileChipDiagonal120Backward(column: Int) {
        let nCount : Int = self.puzzle.GetDiagonal120ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            NotifyParentInvalidPlayStep()
            return
        }
        startAnimation()

        var chiplist : [PuzzleChip] = [PuzzleChip]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = self.puzzle.GetGridIndexAtDiagonal120Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        MoveNeigbhorDiagonal120Chips(column:column)
        
        MoveChipDiagonal120Backward(chip:chiplist[nCount-1], from: indexlist[nCount-1], to: indexlist[0])
        for i in 0 ... (nCount-2) {
            MoveChip(chip:chiplist[i], to: indexlist[i+1])
        }
    }
    
    func MoveNeigbhorDiagonal60Chips(column:Int) {
        let fXOffset = GameLayout.GetChipXOffset()*m_fBubbleSize
        let fStepTime = GameLayout.GetStepAnimationTime()*0.5
        for i in 0 ... self.puzzle.number {
            let nColIndex = self.puzzle.GetGridColumn(index:i)
            var nMotion : CGFloat = 0.0
            if nColIndex < column {
                nMotion = -1.0
            }
            else if column < nColIndex {
                nMotion = 1.0
            }
            if nMotion != 0.0 {
                let chip = self.GetChipByGridIndex(gridIndex: i)
                if chip != nil {
                    chip!.BounceX(x: fXOffset*nMotion, timeInterval: fStepTime)
                }
            }
        }
    }

    func MoveNeigbhorDiagonal120Chips(column:Int) {
        let fXOffset = GameLayout.GetChipXOffset()*m_fBubbleSize
        let fStepTime = GameLayout.GetStepAnimationTime()*0.5
        for i in 0 ... self.puzzle.number {
            let nColIndex = self.puzzle.GetGridDiagonal120Column(index:i)
            var nMotion : CGFloat = 0.0
            if nColIndex < column {
                nMotion = 1.0
            }
            else if column < nColIndex {
                nMotion = -1.0
            }
            if nMotion != 0.0 {
                let chip = self.GetChipByGridIndex(gridIndex: i)
                if chip != nil {
                    chip!.BounceX(x: fXOffset*nMotion, timeInterval: fStepTime)
                }
            }
        }
    }
}
