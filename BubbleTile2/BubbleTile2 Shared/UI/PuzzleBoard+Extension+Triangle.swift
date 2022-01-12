///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension+Triangle.swift

Created by: Zhaohui Xing on 2/28/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleBoard {
    func initializeTrianglePuzzle(layout layOut: enGridLayout, edge nEdge: Int, imageSet: Int) {
        let ptCenter : CGPoint = GameLayout.GetGridCenter()
        let fGridSize : CGFloat = m_fBubbleSize*CGFloat(nEdge-1)
        let startX : CGFloat = ptCenter.x
        let startY : CGFloat = ptCenter.y + GameLayout.SQURT_3*fGridSize*0.25;
        let chipList = self.puzzle.chips
        let deltaX : CGFloat = m_fBubbleSize*0.5
        let deltaY : CGFloat = deltaX*GameLayout.SQURT_3;

        var index : Int = 0
        for i in 0 ..< nEdge {
            for j in 0 ... i {
                var x : CGFloat = startX
                let y : CGFloat = startY - deltaY*CGFloat(i);
                let k = i%2
                if k == 0 {
                    let l : Int = Int(CGFloat(i)/2.0)
                    x += CGFloat(j-l)*deltaX*2.0
                } else {
                    let m : CGFloat = CGFloat(i)/2.0
                    x += (CGFloat(j)-m)*m_fBubbleSize
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
    
    func CreatePuzzleTriangleDiagonal60MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        if bForward {
            ptStart.x = ptStart.x + m_fBubbleSize*0.5
            ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:ptStart.x, y:deltaLen))
            path.append(CGPoint(x:-deltaLen, y:deltaLen))
            path.append(CGPoint(x:-deltaLen, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
        }
        else {
            path.append(CGPoint(x:ptStart.x, y:-deltaLen))
            path.append(CGPoint(x:deltaLen, y:-deltaLen))
            path.append(CGPoint(x:deltaLen, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
            path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        path.append(ptEnd)

        return path
    }
    
    func CreatePuzzleDiamondDiagonal60MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        if bForward {
            ptStart.x = ptStart.x + m_fBubbleSize*0.5
            ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:deltaLen, y:ptStart.y))
            path.append(CGPoint(x:deltaLen, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        else {
            ptStart.x = ptStart.x - m_fBubbleSize*0.5
            ptStart.y = ptStart.y - m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:-deltaLen, y:ptStart.y))
            path.append(CGPoint(x:-deltaLen, y:deltaLen))
            path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:deltaLen))
            path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        path.append(ptEnd)

        return path
    }

    func CreatePuzzleHexagonDiagonal60MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        let column = self.puzzle.GetGridColumn(index:nGridIndexStart)
        if 0 <= column && column < self.edge-1 {
            if bForward {
                path.append(CGPoint(x:ptStart.x, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
                path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
            }
            else {
                ptStart.x = ptStart.x - m_fBubbleSize*0.5
                ptStart.y = ptStart.y - m_fBubbleSize*GameLayout.SQURT_3*0.5
                path.append(ptStart)
                path.append(CGPoint(x:-deltaLen, y:ptStart.y))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:deltaLen))
            }
        }
        else if column == self.edge-1 {
            if bForward {
                path.append(CGPoint(x:ptStart.x, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
            }
            else {
                path.append(CGPoint(x:ptStart.x, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:deltaLen))
            }
        }
        else {
            if bForward {
                ptStart.x = ptStart.x + m_fBubbleSize*0.5
                ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
                path.append(ptStart)
                path.append(CGPoint(x:deltaLen, y:ptStart.y))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
            }
            else {
                path.append(CGPoint(x:ptStart.x, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
                path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
            }
        }
        path.append(ptEnd)

        return path
    }

    func CreatePuzzleTriangleDiagonal120MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        if bForward {
            ptStart.x = ptStart.x - m_fBubbleSize*0.5
            ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:-deltaLen, y:ptStart.y))
            path.append(CGPoint(x:-deltaLen, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
        }
        else {
            path.append(CGPoint(x:ptStart.x, y:-deltaLen))
            path.append(CGPoint(x:deltaLen, y:-deltaLen))
            path.append(CGPoint(x:deltaLen, y:deltaLen))
            path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:deltaLen))
            path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        path.append(ptEnd)

        return path
    }
    
    func CreatePuzzleDiamondDiagonal120MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        if bForward {
            ptStart.x = ptStart.x - m_fBubbleSize*0.5
            ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:-deltaLen, y:ptStart.y))
            path.append(CGPoint(x:-deltaLen, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:-deltaLen))
            path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        else {
            ptStart.x = ptStart.x + m_fBubbleSize*0.5
            ptStart.y = ptStart.y - m_fBubbleSize*GameLayout.SQURT_3*0.5
            path.append(ptStart)
            path.append(CGPoint(x:ptStart.x, y:-deltaLen))
            path.append(CGPoint(x:-deltaLen, y:-deltaLen))
            path.append(CGPoint(x:-deltaLen, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
            path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
        }
        path.append(ptEnd)
        return path
    }
    
    func CreatePuzzleHexagonDiagonal120MovingPath(_ nGridIndexStart:Int, _ nGridIndexEnd:Int, _ bForward: Bool)->[CGPoint] {
        var path : [CGPoint] = [CGPoint]()
        let fgridSize = GameLayout.GetPuzzleNonFrameLength()
        let deltaLen = (fgridSize-self.m_fBubbleSize)*0.5

        var ptStart : CGPoint = self.GetChipCenter(index:nGridIndexStart)
        let ptEnd : CGPoint = self.GetChipCenter(index:nGridIndexEnd)

        let column = self.puzzle.GetGridDiagonal120Column(index:nGridIndexStart)
        if 0 <= column && column < self.edge-1 {
            if bForward {
                path.append(CGPoint(x:ptStart.x, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
                path.append(CGPoint(x:ptEnd.x+m_fBubbleSize*0.5, y:ptEnd.y-m_fBubbleSize*GameLayout.SQURT_3*0.5))
            }
            else {
                ptStart.x = ptStart.x + m_fBubbleSize*0.5
                ptStart.y = ptStart.y - m_fBubbleSize*GameLayout.SQURT_3*0.5
                path.append(ptStart)
                path.append(CGPoint(x:deltaLen, y:ptStart.y))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:deltaLen))
            }
        }
        else if column == self.edge-1 {
            if bForward {
                path.append(CGPoint(x:ptStart.x, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
            }
            else {
                path.append(CGPoint(x:ptStart.x, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:deltaLen))
            }
        }
        else {
            if bForward {
                ptStart.x = ptStart.x - m_fBubbleSize*0.5
                ptStart.y = ptStart.y + m_fBubbleSize*GameLayout.SQURT_3*0.5
                path.append(ptStart)
                path.append(CGPoint(x:-deltaLen, y:ptStart.y))
                path.append(CGPoint(x:-deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:deltaLen))
                path.append(CGPoint(x:deltaLen, y:-deltaLen))
                path.append(CGPoint(x:ptEnd.x, y:-deltaLen))
            }
            else {
                path.append(CGPoint(x:ptStart.x, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:-deltaLen))
                path.append(CGPoint(x:-deltaLen, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
                path.append(CGPoint(x:ptEnd.x-m_fBubbleSize*0.5, y:ptEnd.y + m_fBubbleSize*GameLayout.SQURT_3*0.5))
            }
        }
        path.append(ptEnd)

        return path
    }

    
}
