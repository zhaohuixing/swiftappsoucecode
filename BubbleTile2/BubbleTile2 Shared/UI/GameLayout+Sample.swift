///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		Gamelayout+Sample.swift

Created by: Zhaohui Xing on 2/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

//For draw sampling
extension GameLayout {
    static func GetSampleDrawChipSize(type gridType : enGridType, edge nEdge : Int, drawLength:CGFloat)->CGFloat {
        let chipNumber : CGFloat = GetPuzzleMaxDemension(type: gridType, edge: nEdge)
        let fSize : CGFloat = drawLength/chipNumber
        return fSize
    }
    
    static func BuildSamplePuzzleLayout(type:enGridType, edge: Int, size: CGFloat)->[CGPoint] {
        switch type {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                return BuildSampleTrianglePuzzleLayout(edge: edge, size: size)
            case enGridType.PUZZLE_GRID_SQUARE:
                return BuildSampleSquarePuzzleLayout(edge: edge, size: size)
            case enGridType.PUZZLE_GRID_DIAMOND:
                return BuildSampleDiamondPuzzleLayout(edge: edge, size: size)
            case enGridType.PUZZLE_GRID_HEXAGON:
                return BuildSampleHexagonPuzzleLayout(edge: edge, size: size)
        }
    }

    static func BuildSampleDiamondPuzzleLayout(edge nEdge: Int, size drawLength: CGFloat)->[CGPoint] {
        let fBubbleSize : CGFloat = GameLayout.GetSampleDrawChipSize(type:enGridType.PUZZLE_GRID_DIAMOND, edge:nEdge, drawLength:drawLength)
        let ptCenter : CGPoint = CGPoint(x: drawLength*0.5, y:drawLength*0.5)
        let centers = BuildDiamondPuzzleLayoutCenters(edge: nEdge,center: ptCenter, bubbleSize: fBubbleSize)

        return centers
    }

    static func BuildDiamondPuzzleLayoutCenters(edge nEdge: Int, center ptCenter: CGPoint, bubbleSize fBubbleSize: CGFloat)->[CGPoint] {
        var centers : [CGPoint] = [CGPoint]()
        let fInnerWidth : CGFloat = fBubbleSize*CGFloat(nEdge-1)
        let fInnerHeight : CGFloat = fInnerWidth*GameLayout.SQURT_3
        let startX : CGFloat = ptCenter.x
        let startY : CGFloat = ptCenter.y + fInnerHeight*0.5
        let deltaX : CGFloat = fBubbleSize*0.5
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
                        x += (CGFloat(j)-l)*fBubbleSize;
                    }
                    centers.append(CGPoint(x: x, y: y))
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
                        x += (CGFloat(j)-l)*fBubbleSize;
                    }
                    centers.append(CGPoint(x: x, y: y))
                    index += 1
                }
            }
        }
        
        return centers
    }
    static func BuildSampleHexagonPuzzleLayout(edge nEdge: Int, size drawLength: CGFloat)->[CGPoint] {
        let fBubbleSize : CGFloat = GameLayout.GetSampleDrawChipSize(type:enGridType.PUZZLE_GRID_HEXAGON, edge:nEdge, drawLength:drawLength)
        let ptCenter : CGPoint = CGPoint(x: drawLength*0.5, y:drawLength*0.5)
        let centers = BuildHexagonPuzzleLayoutCenters(edge: nEdge,center: ptCenter, bubbleSize: fBubbleSize)

        return centers
    }
    
    static func BuildHexagonPuzzleLayoutCenters(edge nEdge: Int, center ptCenter: CGPoint, bubbleSize fBubbleSize: CGFloat)->[CGPoint] {
        var centers : [CGPoint] = [CGPoint]()
        let fInnerWidth : CGFloat = fBubbleSize*CGFloat(nEdge-1)
        let fInnerHeight : CGFloat = fInnerWidth*GameLayout.SQURT_3
        let startX : CGFloat = ptCenter.x-fInnerWidth*0.5;
        let startY : CGFloat = ptCenter.y + fInnerHeight*0.5
        let deltaX : CGFloat = fBubbleSize*0.5
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
                        x += (CGFloat(j)-l)*fBubbleSize;
                    }
                    centers.append(CGPoint(x: x, y: y))
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
                        x += (CGFloat(j)-l)*fBubbleSize;
                    }
                    centers.append(CGPoint(x: x, y: y))
                    index += 1
                }
            }
        }
        return centers
    }
    
    static func BuildSampleTrianglePuzzleLayout(edge nEdge: Int, size drawLength: CGFloat)->[CGPoint] {
        let fBubbleSize : CGFloat = GameLayout.GetSampleDrawChipSize(type:enGridType.PUZZLE_GRID_TRIANGLE, edge:nEdge, drawLength:drawLength)
        let ptCenter : CGPoint = CGPoint(x: drawLength*0.5, y:drawLength*0.5)
        let centers = BuildTrianglePuzzleLayoutCenters(edge: nEdge,center: ptCenter, bubbleSize: fBubbleSize)

        return centers
    }
    
    static func BuildTrianglePuzzleLayoutCenters(edge nEdge: Int, center ptCenter: CGPoint, bubbleSize fBubbleSize: CGFloat)->[CGPoint] {
        var centers : [CGPoint] = [CGPoint]()
        let fGridSize : CGFloat = fBubbleSize*CGFloat(nEdge-1)
        let startX : CGFloat = ptCenter.x
        let startY : CGFloat = ptCenter.y + GameLayout.SQURT_3*fGridSize*0.25;
        let deltaX : CGFloat = fBubbleSize*0.5
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
                    x += (CGFloat(j)-m)*fBubbleSize
                }
                
                centers.append(CGPoint(x: x, y: y))
                index += 1
            }
        }
        return centers
    }

    static func BuildSampleSquarePuzzleLayout(edge nEdge: Int, size drawLength: CGFloat)->[CGPoint] {
        let fBubbleSize : CGFloat = GameLayout.GetSampleDrawChipSize(type:enGridType.PUZZLE_GRID_SQUARE, edge:nEdge, drawLength:drawLength)
        let ptCenter : CGPoint = CGPoint(x: drawLength*0.5, y:drawLength*0.5)
        let centers = BuildSquarePuzzleLayoutCenters(edge: nEdge,center: ptCenter, bubbleSize: fBubbleSize)

        return centers
    }
    

    static func BuildSquarePuzzleLayoutCenters(edge nEdge: Int, center ptCenter: CGPoint, bubbleSize fBubbleSize: CGFloat)->[CGPoint] {
        var centers : [CGPoint] = [CGPoint]()
        let fGridSize : CGFloat = fBubbleSize*CGFloat(nEdge-1)
        let startX : CGFloat = ptCenter.x - fGridSize*0.5
        let startY : CGFloat = ptCenter.y + fGridSize*0.5
        for i in 0 ..< nEdge {
            for j in 0 ..< nEdge {
                let x : CGFloat = startX + fBubbleSize*CGFloat(j)
                let y : CGFloat = startY - fBubbleSize*CGFloat(i);
                centers.append(CGPoint(x: x, y: y))
            }
        }
        return centers
    }

    

}
