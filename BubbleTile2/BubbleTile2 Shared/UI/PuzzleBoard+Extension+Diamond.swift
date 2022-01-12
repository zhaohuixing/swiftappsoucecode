///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension+Diamond.swift

Created by: Zhaohui Xing on 2/28/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleBoard {
    func initializeDiamondPuzzle(layout layOut: enGridLayout, edge nEdge: Int, imageSet: Int) {
        let chipList = self.puzzle.chips
        let fInnerWidth : CGFloat = m_fBubbleSize*CGFloat(nEdge-1)
        let fInnerHeight : CGFloat = fInnerWidth*GameLayout.SQURT_3
        let ptCenter : CGPoint = GameLayout.GetGridCenter()
        let startX : CGFloat = ptCenter.x
        let startY : CGFloat = ptCenter.y + fInnerHeight*0.5
        let deltaX : CGFloat = m_fBubbleSize*0.5
        let deltaY : CGFloat = deltaX*GameLayout.SQURT_3
        
        let nRows : Int = nEdge*2-1;
        var index : Int = 0
        for i in 0 ..< nRows {
            if i <= nEdge-1 {
                for j in 0 ... i {
                    let y : CGFloat = startY - deltaY*CGFloat(i)
                    var x : CGFloat = startX
                    let k : Int = i%2
                    let l : CGFloat = CGFloat(i)/2.0
                    if k == 0 {
                        x += (CGFloat(j)-l)*deltaX*2.0;
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
            else {
                for j in 0 ..< (nRows-i) {
                    let y : CGFloat = startY - deltaY*CGFloat(i);
                    var x : CGFloat = startX
                    let k : Int = i%2
                    let l : CGFloat = (CGFloat(nRows-i-1))/2.0
                    if k == 0 {
                        x += (CGFloat(j)-l)*deltaX*2.0;
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
    
    func MoveChipDiagonal60Forward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleDiagonal60MovingPath(nGridIndexStart, nGridIndexEnd, true)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChipDiagonal60Backward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleDiagonal60MovingPath(nGridIndexStart, nGridIndexEnd, false)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func MoveChipDiagonal120Forward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleDiagonal120MovingPath(nGridIndexStart, nGridIndexEnd, true)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }
    
    func MoveChipDiagonal120Backward(chip puzzlechip:PuzzleChip, from nGridIndexStart : Int, to nGridIndexEnd : Int) {
        let path : [CGPoint] = CreatePuzzleDiagonal120MovingPath(nGridIndexStart, nGridIndexEnd, false)
        puzzlechip.realindex = nGridIndexEnd
        puzzlechip.MovePath(path: path, totalTime: GameLayout.GetPathAnimationTime())
    }

    func CreatePuzzleDiagonal60MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint]
        
        switch self.type {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                path = CreatePuzzleTriangleDiagonal60MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            case enGridType.PUZZLE_GRID_DIAMOND:
                path = CreatePuzzleDiamondDiagonal60MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            case enGridType.PUZZLE_GRID_HEXAGON:
                path = CreatePuzzleHexagonDiagonal60MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            default:
                path = [CGPoint]()
            }

        return path
    }

    func CreatePuzzleDiagonal120MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint]
        
        switch self.type {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                path = CreatePuzzleTriangleDiagonal120MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            case enGridType.PUZZLE_GRID_DIAMOND:
                path = CreatePuzzleDiamondDiagonal120MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            case enGridType.PUZZLE_GRID_HEXAGON:
                path = CreatePuzzleHexagonDiagonal120MovingPath(nGridIndexStart, nGridIndexEnd, bForward)
            default:
                path = [CGPoint]()
            }

        return path
    }

    func ArrangePuzzle() {
        for i in 0 ... (self.children.count-1) {
            let chip = self.children[i] as! PuzzleChip
            chip.position = m_ChipCenters[chip.realindex]
            chip.CheckMatch()
        }
    }
}
