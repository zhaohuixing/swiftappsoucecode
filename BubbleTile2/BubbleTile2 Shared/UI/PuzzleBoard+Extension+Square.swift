///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension+Square.swift

Created by: Zhaohui Xing on 2/28/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleBoard {
    func initializeSquarePuzzle(layout layOut: enGridLayout, edge nEdge: Int, imageSet: Int) {
        let ptCenter : CGPoint = GameLayout.GetGridCenter()
        let fGridSize : CGFloat = m_fBubbleSize*CGFloat(nEdge-1)
        let startX : CGFloat = ptCenter.x - fGridSize*0.5
        let startY : CGFloat = ptCenter.y + fGridSize*0.5
        let chipList = self.puzzle.chips
        for i in 0 ..< nEdge {
            for j in 0 ..< nEdge {
                let x : CGFloat = startX + m_fBubbleSize*CGFloat(j)
                let y : CGFloat = startY - m_fBubbleSize*CGFloat(i);
                let index = nEdge*i+j
                let chip : PuzzleChip = PuzzleChip.CreatePuzzleChip(size: CGSize(width: m_fBubbleSize, height: m_fBubbleSize), imageset: imageSet, chipDat: chipList[index])
                self.addChild(chip)
                chip.position = CGPoint(x: x, y: y);
                chip.alpha = 0.0
                chip.run(SKAction.sequence([SKAction.scale(by: 0.5, duration: 0.01),
                                            SKAction.fadeIn(withDuration: GameLayout.GetGameStartAnimationTime()),
                                            SKAction.scale(by: 2.0, duration: GameLayout.GetGameStartAnimationTime())]))
                m_ChipCenters.append(CGPoint(x: x, y: y))
            }
        }
    }
    
    func ShiftBubbleTileChipSquarePuzzle(_ step: GamePlayStep) {
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
            case enBubbleMotion.BUBBLE_MOTION_VERTICAL:
                let nColIndex = self.puzzle.GetGridColumn(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipSquarePuzzleVerticalForward(column: nColIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipSquarePuzzleVerticalBackward(column: nColIndex)
                    default:
                        return
                }
            default:
                return
        }
    }

    func ShiftBubbleTileChipHorizontalForward(row: Int) {
        let nCount : Int = self.puzzle.GetBubbleCountAtRow(rowIndex: row)
        
        if nCount <= 1 {
            NotifyParentInvalidPlayStep()
            return
        }
        
        let nStartIndex : Int = self.puzzle.GetFirstGridIndexAtRow(rowIndex: row)
        let nEndIndex : Int = (nStartIndex + nCount - 1)
        startAnimation()

        var chiplist : [PuzzleChip] = [PuzzleChip]()
        for i in nStartIndex ... nEndIndex {
            chiplist.append(GetChipByGridIndex(gridIndex:i)!)
        }
        MoveNeigbhorRowChips(row:row)

        MoveChipHorizontalForward(chip:chiplist[nCount-1], from: nEndIndex, to: nStartIndex)
        for i in nStartIndex ... (nEndIndex-1) {
            MoveChip(chip:chiplist[i-nStartIndex], to: i+1)
        }
    }
    
    func ShiftBubbleTileChipHorizontalBackward(row: Int) {
        let nCount : Int = self.puzzle.GetBubbleCountAtRow(rowIndex: row)
        
        if nCount <= 1 {
            NotifyParentInvalidPlayStep()
            return
        }
        
        let nStartIndex : Int = self.puzzle.GetFirstGridIndexAtRow(rowIndex: row)
        let nEndIndex : Int = (nStartIndex + nCount - 1)
        startAnimation()
 
        var chiplist : [PuzzleChip] = [PuzzleChip]()
        for i in nStartIndex ... nEndIndex {
            chiplist.append(GetChipByGridIndex(gridIndex:i)!)
        }
        MoveNeigbhorRowChips(row:row)

        MoveChipHorizontalBackward(chip:chiplist[0], from: nStartIndex, to: nEndIndex)
        for i in (nStartIndex+1) ... nEndIndex {
            MoveChip(chip:chiplist[i-nStartIndex], to: i-1)
       }
    }

    func ShiftBubbleTileChipSquarePuzzleVerticalForward(column: Int) {
        let nStartIndex = column
        let nEndIndex = (self.edge-1)*self.edge+column
        startAnimation()
        
        var chiplist : [PuzzleChip] = [PuzzleChip]()
        for i in 0 ... (self.edge-1) {
            let k = i*self.edge + column
            chiplist.append(GetChipByGridIndex(gridIndex:k)!)
        }
        
        MoveChipVecticalForward(chip:chiplist[0], from: nStartIndex, to: nEndIndex)
        for i in 1 ... (self.edge-1) {
            let k = i*self.edge + column - self.edge
            MoveChip(chip:chiplist[i], to: k)
        }
    }
    
    func ShiftBubbleTileChipSquarePuzzleVerticalBackward(column: Int) {
        let nStartIndex = column
        let nEndIndex = (self.edge-1)*self.edge+column
        startAnimation()
        
        var chiplist : [PuzzleChip] = [PuzzleChip]()
        for i in 0 ... (self.edge-1) {
            let k = i*self.edge + column
            chiplist.append(GetChipByGridIndex(gridIndex:k)!)
        }
        
        MoveChipVecticalBackward(chip:chiplist[self.edge-1], from: nEndIndex, to: nStartIndex)
        for i in 0 ... (self.edge-2) {
            let k = (i+1)*self.edge + column
            MoveChip(chip:chiplist[i], to: k)
        }
    }
    
    func CreatePuzzleRegularMovingPath(_ nGridIndexStart : Int, _ nGridIndexEnd : Int, _ bHoriz : Bool, _ bForward: Bool)->[CGPoint] {
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5
        var path : [CGPoint] = [CGPoint]()
        let ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd = self.GetChipCenter(index:nGridIndexEnd)
        if bHoriz {
            if bForward {
                path.append(CGPoint(x:deltaLen, y:ptStart.y))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:ptEnd.y))
            } else {
                path.append(CGPoint(x:-deltaLen, y:ptStart.y))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:ptEnd.y))
            }
        } else {
            if bForward {
                path.append(CGPoint(x:ptStart.x, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
            } else {
                path.append(CGPoint(x:ptStart.x, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:deltaLen))
            }
        }
        path.append(ptEnd)

        return path
    }
    
    func MoveChipHorizontalForward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleRegularMovingPath(nGridIndexStart, nGridIndexEnd, true, true)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChipHorizontalBackward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleRegularMovingPath(nGridIndexStart, nGridIndexEnd, true, false)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChipVecticalForward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleRegularMovingPath(nGridIndexStart, nGridIndexEnd, false, true)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChipVecticalBackward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleRegularMovingPath(nGridIndexStart, nGridIndexEnd, false, false)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChip(chip puzzlechip:PuzzleChip, to nGridIndexEnd : Int) {
        let ptEnd = self.GetChipCenter(index:nGridIndexEnd)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MoveTo(ptEnd, GameLayout.GetStepAnimationTime())
    }
    
    func MoveNeigbhorRowChips(row:Int) {
        if self.type == enGridType.PUZZLE_GRID_SQUARE {
            return
        }
        
        BounceUpRowsBefore(row:row)
        BounceDownRowsBefore(row:row)
    }

    func BounceUpRowsBefore(row:Int) {
        if row-1 < 0 {
            return
        }
        
        let nLastChip = self.puzzle.GetLastGridIndexAtRow(rowIndex: row-1)
        
        //if nLastChip <= 0 {
        if nLastChip < 0 {
            return
        }
        let fYOffset = GameLayout.GetChipYOffset()*self.m_fBubbleSize
        let fStepTime = GameLayout.GetStepAnimationTime()*0.5
        for i in 0 ... nLastChip {
            let chip = self.GetChipByGridIndex(gridIndex: i)
            if chip != nil {
                chip!.BounceY(y: fYOffset, timeInterval: fStepTime)
            }
        }
    }
    
    func BounceDownRowsBefore(row:Int) {
        let nFirstChip = self.puzzle.GetFirstGridIndexAtRow(rowIndex: row+1)
        
        if nFirstChip < 0 {
            return
        }
        
        let nLastChip = self.puzzle.number-1
        if nLastChip < 0 {
            return
        }
        let fYOffset = GameLayout.GetChipYOffset()*m_fBubbleSize
        let fStepTime = GameLayout.GetStepAnimationTime()*0.5
        for i in nFirstChip ... nLastChip {
            let chip = self.GetChipByGridIndex(gridIndex: i)
            if chip != nil {
                chip!.BounceY(y: -fYOffset, timeInterval: fStepTime)
            }
        }
    }
}
