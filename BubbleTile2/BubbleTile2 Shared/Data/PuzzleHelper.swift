//
//  PuzzleHelper.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 1/30/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class PuzzleHelper {
    static let g_FREE_TRIANGLE_MIN : Int = 3
    static let g_FREE_TRIANGLE_MAX : Int = 4
    static let g_FREE_SQUARE_MIN : Int = 3
    static let g_FREE_SQUARE_MAX : Int = 4
    static let g_FREE_DIAMOND_MIN : Int = 3
    static let g_FREE_DIAMOND_MAX : Int = 4
    static let g_FREE_HEXAGON_MIN : Int = 2
    static let g_FREE_HEXAGON_MAX : Int = 3

    class func GetPuzzleEdgeRange(type gridType : enGridType)->(minedges: Int, maxedges: Int) {
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                return (g_FREE_TRIANGLE_MIN, g_FREE_TRIANGLE_MAX)
            case enGridType.PUZZLE_GRID_SQUARE:
                return (g_FREE_SQUARE_MIN, g_FREE_SQUARE_MAX)
            case enGridType.PUZZLE_GRID_DIAMOND:
                return (g_FREE_DIAMOND_MIN, g_FREE_DIAMOND_MAX)
            case enGridType.PUZZLE_GRID_HEXAGON:
                return (g_FREE_HEXAGON_MIN, g_FREE_HEXAGON_MAX)
        }
    }

    class func GetPuzzleEdgeIndex(type: enGridType, edge:Int)->Int {
        var index : Int = 0
        let edgeRange = GetPuzzleEdgeRange(type: type)
        for i in edgeRange.minedges ... edgeRange.maxedges {
            if i == edge {
                return index
            }
            index = index + 1
        }
        
        return -1
    }

    class func GetPuzzleEdge(type: enGridType, index:Int)->Int {
        var count : Int = 0
        let edgeRange = GetPuzzleEdgeRange(type: type)
        for i in edgeRange.minedges ... edgeRange.maxedges {
            if count == index {
                return i
            }
            count = count + 1
        }
        
        return -1
    }

    //Static function
    class func CreateIndexMatrix(type gridType : enGridType, layout gridLayout : enGridLayout, edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int>? = nil

        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                retArray = TrianglePuzzleHelper.CreateIndexMatrix(layout: gridLayout, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                retArray = SquarePuzzleHelper.CreateIndexMatrix(layout: gridLayout, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                retArray = DiamondPuzzleHelper.CreateIndexMatrix(layout: gridLayout, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                retArray = HexagonPuzzleHelper.CreateIndexMatrix(layout: gridLayout, edge: nEdge)
            //default:
            //    retArray = nil
        }
        
        return retArray!
    }

    class func GetGridRow(index nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = 0
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetGridRow(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = SquarePuzzleHelper.GetGridRow(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetGridRow(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetGridRow(index: nIndex, edge: nEdge)
        }
        
        return nRet
    }
    
    class func GetGridColumn(index nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = 0
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetGridColumn(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = SquarePuzzleHelper.GetGridColumn(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetGridColumn(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetGridColumn(index: nIndex, edge: nEdge)
        }
        
        return nRet
    }
    
    class func GetGridDiagonal120Column(index nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = 0
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetGridDiagonal120Column(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = (nEdge-1)-SquarePuzzleHelper.GetGridColumn(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetGridDiagonal120Column(index: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetGridDiagonal120Column(index: nIndex, edge: nEdge)
        }
        
        return nRet
    }
    
    class func GetBubbleCountAtRow(row nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetBubbleCountAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = SquarePuzzleHelper.GetBubbleCountAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetBubbleCountAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetBubbleCountAtRow(row: nIndex, edge: nEdge)
        }
        
        return nRet
    }

    class func GetFirstIndexAtRow(row nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetFirstIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = SquarePuzzleHelper.GetFirstIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetFirstIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetFirstIndexAtRow(row: nIndex, edge: nEdge)
        }
        
        return nRet;
    }
    
    class func GetLastIndexAtRow(row nIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetLastIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_SQUARE:
                nRet = SquarePuzzleHelper.GetLastIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetLastIndexAtRow(row: nIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetLastIndexAtRow(row: nIndex, edge: nEdge)
        }
        
        return nRet;
    }
    
    class func GetDiagonal120ColumnBubbleCount(column nColIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetDiagonal120ColumnBubbleCount(column: nColIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetDiagonal120ColumnBubbleCount(column: nColIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetDiagonal120ColumnBubbleCount(column: nColIndex, edge: nEdge)
            default:
                nRet = nEdge
        }
        
        return nRet;
    }
    
    class func GetGridIndexAtDiagonal120Column(column nColIndex:Int, type gridType : enGridType, edge nEdge : Int, at nCountIndex: Int)->Int {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetGridIndexAtDiagonal120Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetGridIndexAtDiagonal120Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetGridIndexAtDiagonal120Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            default:
                nRet = nCountIndex*nEdge + nColIndex
        }
        
        return nRet;
    }

    class func GetDiagonal60ColumnBubbleCount(column nColIndex:Int, type gridType : enGridType, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetDiagonal60ColumnBubbleCount(column: nColIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetDiagonal60ColumnBubbleCount(column: nColIndex, edge: nEdge)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetDiagonal60ColumnBubbleCount(column: nColIndex, edge: nEdge)
            default:
                nRet = nEdge
        }
        
        return nRet;
    }
    
    class func GetGridIndexAtDiagonal60Column(column nColIndex:Int, type gridType : enGridType, edge nEdge : Int, at nCountIndex: Int)->Int {
        var nRet : Int = -1;
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nRet = TrianglePuzzleHelper.GetGridIndexAtDiagonal60Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            case enGridType.PUZZLE_GRID_DIAMOND:
                nRet = DiamondPuzzleHelper.GetGridIndexAtDiagonal60Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            case enGridType.PUZZLE_GRID_HEXAGON:
                nRet = HexagonPuzzleHelper.GetGridIndexAtDiagonal60Column(column: nColIndex, edge: nEdge, at: nCountIndex)
            default:
                nRet = nCountIndex*nEdge + nColIndex
        }
        
        return nRet;
    }
}

extension PuzzleHelper {
    class func GetPuzzleBubbleCount(type gridType : enGridType, edge nEdge : Int)->Int {
        var nRet : Int = -1
        
        switch gridType {
        case enGridType.PUZZLE_GRID_TRIANGLE:
            nRet = PuzzleHelper.GetTriangleGridBubbleCount(nEdge)
        case enGridType.PUZZLE_GRID_SQUARE:
            nRet = PuzzleHelper.GetSqureGridBubbleCount(nEdge)
        case enGridType.PUZZLE_GRID_DIAMOND:
            nRet = PuzzleHelper.GetDiamonGridBubbleCount(nEdge)
        case enGridType.PUZZLE_GRID_HEXAGON:
            nRet = PuzzleHelper.GetHexagonGridBubbleCount(nEdge)
        }
        
        return nRet
    }
    
    class func GetSqureGridBubbleCount(_ nEdge : Int)->Int {
        let nRet : Int = nEdge*nEdge
        return nRet
    }
    
    class func GetTriangleGridBubbleCount(_ nEdge : Int)->Int {
        let nRet : Int = (nEdge+1)*nEdge/2
        return nRet
    }
    
    class func GetDiamonGridBubbleCount(_ nEdge : Int)->Int {
        let nRet : Int = nEdge*nEdge
        return nRet
    }
    
    class func GetHexagonGridBubbleCount(_ nEdge : Int)->Int {
        var nRet : Int = -1;
        if(0 < nEdge)
        {
            nRet = nEdge*nEdge + nEdge*(nEdge-1) + (nEdge-1)*(nEdge-1);
        }
        return nRet;
    }
    
    class func GetTriangleGridFirstIndexAtRow(row nRow: Int)->Int {
        let nRet : Int = (Int)((nRow+1)*nRow/2)
        return nRet
    }
    
    class func GetTriangleGridLastIndexAtRow(row nRow: Int)->Int {
        let nRet : Int = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row:(nRow+1))-1
        return nRet
    }
    
    class func CheckTouchMotion(startX: Double, startY: Double, endX: Double, endY: Double)->enTouchMotion {
        var enDirect : enTouchMotion = enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE
        
        if startX == endX && startY == endY {
            return enTouchMotion.TOUCH_MOTION_NONE
        }
        else if startX == endX && startY != endY {
            if startY < endY {
                enDirect = enTouchMotion.TOUCH_MOTION_VERTICAL_UP
            }
            else  {
                enDirect = enTouchMotion.TOUCH_MOTION_VERTICAL_DOWN
            }
        }
        else if startX != endX && startY == endY {
            if startX < endX {
                enDirect = enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE
            }
            else  {
                enDirect = enTouchMotion.TOUCH_MOTION_HORIZONTAL_NEGATIVE
            }
        }
        else {
            let ratio = (endY - startY)/(endX - startX)
            if 0.0 < ratio {
                if startY < endY && startX < endX {
                    if ratio <= 1.0 {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL30_POSITIVE
                    }
                    else {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL60_POSITIVE
                    }
                }
                else {
                    if ratio <= 1.0 {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL30_NEGATIVE
                    }
                    else {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL60_NEGATIVE
                    }
                }
            }
            else {
                if startY < endY && endX < startX {
                    if abs(ratio) <= 1.0 {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL150_POSITIVE
                    }
                    else {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL120_POSITIVE
                    }
                }
                else {
                    if abs(ratio) <= 1.0 {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL150_NEGATIVE
                    }
                    else {
                        enDirect = enTouchMotion.TOUCH_MOTION_DIAGNOL120_NEGATIVE
                    }
                }
            }
        }

        return enDirect
    }
}
