//
//  TrianglePuzzleHelper.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/2/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class TrianglePuzzleHelper {
    class func CreateIndexMatrix(layout gridLayout : enGridLayout, edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int>?

        switch gridLayout {
            case enGridLayout.PUZZLE_LALOUT_MATRIX:
                retArray = TrianglePuzzleHelper.CreateMatrixIndexMatrix(edge: nEdge)
            case enGridLayout.PUZZLE_LALOUT_SNAKE:
                retArray = TrianglePuzzleHelper.CreateSnakeIndexMatrix(edge: nEdge)
            case enGridLayout.PUZZLE_LALOUT_SPIRAL:
                retArray = TrianglePuzzleHelper.CreateSpiralIndexMatrix(edge: nEdge)
            //default:
            //    retArray = nil
        }

        return retArray!
    }
   
    
    private static func CreateMatrixIndexMatrix(edge nSize : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()

        var k : Int = 0
        for i in 0 ... (nSize-1) {
            var j : Int = 0
            while j <= i {
                retArray.append(k)
                k += 1
                j += 1
            }
        }

        return retArray;
    }
    
    private static func CreateSnakeIndexMatrix(edge nSize : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
        
        var k : Int = 0
        for i in 0 ... (nSize-1) {
            if i%2 == 0 {
                var j : Int = 0
                while j <= i {
                    retArray.append(k)
                    k += 1
                    j += 1
                }
            }
            else {
                var j : Int = 0
                let n : Int = k+i
                while j <= i {
                    retArray.append(n-j)
                    k += 1
                    j += 1
                }
            }
        }

        return retArray;
    }
    
    private static func CreateSpiralIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()

        var k : Int = 0
        for i in 0 ... (nEdge-1) {
            var j : Int = 0
            while j <= i {
                retArray.append(k)
                k += 1
                j += 1
            }
        }

        let nSize : Int = retArray.count
        var nDirection : Int = 0
        var nStartRow : Int = 0
        var nEndRow : Int = nEdge
        var nLeftOffset : Int = 0
        var nRightOffset : Int = 0
        var nCount : Int = 0

        while nCount < nSize {
            
            if nDirection == 0 {
                if (nStartRow+nLeftOffset) <= (nEndRow-1) {
                    for i in (nStartRow+nLeftOffset) ... (nEndRow-1) { //in's parameters are constants (need use 'let')
                        let nIndex : Int = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row:i) + i - nStartRow
                        retArray[nIndex] = nCount
                        nCount += 1
                    }
                    nRightOffset += 1;
                    nStartRow += 1;
                }
                
            } else if nDirection == 1 {
                if nLeftOffset <= nEndRow-1-nRightOffset {
                    let nStartIndex : Int = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row:(nEndRow-1))
                    for i in stride(from: (nEndRow-1-nRightOffset), through:nLeftOffset, by:-1) { //in's parameters are constants (need use 'let')
                        let nIndex : Int = nStartIndex + i
                        retArray[nIndex] = nCount
                        nCount += 1
                    }
                    nEndRow -= 1
                }
                
            } else if nDirection == 2 {
                if (nStartRow+nLeftOffset) <= (nEndRow-1) {
                    for i in stride(from: nEndRow-1, through:(nStartRow+nLeftOffset), by:-1) { //in's parameters are constants (need use 'let')
                        let nIndex : Int = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row:i) + (nStartRow-1)
                        retArray[nIndex] = nCount
                        nCount += 1
                    }
                    
                    nLeftOffset += 1
                }
            }
            
            nDirection = (nDirection+1)%3
        }
        
        return retArray;
    }
}

extension TrianglePuzzleHelper {
    class func GetGridRow(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        for i in 0...(nEdge-1) {
            let j : Int = i+1
            let v1 : Int = (i+1)*i/2
            let v2 : Int = (j+1)*j/2
            if (v1 <= nIndex && nIndex < v2) {
                nRet = i
                break
            }
        }
        return nRet;
    }

    class func GetGridColumn(index nIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        for i in 0 ... (nEdge-1) {
            let j = i+1;
            let v1 = (i+1)*i/2;
            let v2 = (j+1)*j/2;
            if (v1 <= nIndex && nIndex < v2) {
                nRet = nIndex-v1;
                break;
            }
        }
        return nRet;
    }
    
    class func GetBubbleCountAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1

        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex+1;
        }

        return nRet;
    }

    class func GetFirstIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = (nRowIndex+1)*nRowIndex/2;
        }
        return nRet;
    }

    class func GetLastIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = (nRowIndex+2)*(nRowIndex+1)/2-1;
        }
        return nRet;
    }

    class func GetDiagonal60ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;

        if 0 <= nColIndex && nColIndex < nEdge {
            nRet = nEdge - nColIndex;
        }
        
        return nRet;
    }


    class func GetDiagonal120ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        let nRet : Int = GetDiagonal60ColumnBubbleCount(column: nColIndex, edge: nEdge)
        return nRet;
    }

    class func GetGridDiagonal120Column(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet = -1
        let nRowIndex = GetGridRow(index: nIndex, edge: nEdge)
        nRet = nRowIndex;
        if 0 < nRowIndex {
            nRet = nRowIndex - GetGridColumn(index:nIndex, edge: nEdge)
        }
        
        return nRet
    }
    
    class func GetGridIndexAtDiagonal60Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet : Int = -1;

        if(0 <= nColIndex && nColIndex < nEdge && 0 <= nCellIndex && nCellIndex < nEdge)
        {
            let nTemp = nColIndex + nCellIndex
            if(0 <= nTemp && nTemp < nEdge)
            {
                nRet = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row: nTemp) + nColIndex
            }
        }
        return nRet
    }
    
    class func GetGridIndexAtDiagonal120Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet = -1;
    
        if(0 <= nColIndex && nColIndex < nEdge && 0 <= nCellIndex && nCellIndex < nEdge)
        {
                let nTemp = nColIndex + nCellIndex
                if(0 <= nTemp && nTemp < nEdge)
                {
                    nRet = PuzzleHelper.GetTriangleGridFirstIndexAtRow(row: nTemp) + nCellIndex
                }
            }
            
            return nRet;
    }


}
