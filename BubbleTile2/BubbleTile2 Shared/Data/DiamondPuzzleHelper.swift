//
//  DiamondPuzzleHelper.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/3/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class DiamondPuzzleHelper {
    class func CreateIndexMatrix(layout gridLayout : enGridLayout, edge nSize : Int)->Array<Int> {
        var retArray : Array<Int>?
        
        switch gridLayout {
        case enGridLayout.PUZZLE_LALOUT_MATRIX:
            retArray = DiamondPuzzleHelper.CreateMatrixIndexMatrix(edge: nSize)
        case enGridLayout.PUZZLE_LALOUT_SNAKE:
            retArray = DiamondPuzzleHelper.CreateSnakeIndexMatrix(edge: nSize)
        case enGridLayout.PUZZLE_LALOUT_SPIRAL:
            retArray = DiamondPuzzleHelper.CreateSpiralIndexMatrix(edge: nSize)
            //default:
            //    retArray = nil
        }
        
        return retArray!
    }
    
    private static func CreateMatrixIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
        let nRow : Int = nEdge*2-1
        var k : Int = 0
        
        for i in 0 ... (nRow-1) {
            if i <= (nEdge-1) {
                for _ in 0 ... i {
                    retArray.append(k)
                    k += 1
                }
            } else {
                for _ in 0 ... (nRow-i-1) {
                    retArray.append(k)
                    k += 1
                }
            }
        }
        return retArray;
    }
    
    private static func CreateSnakeIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
        let nRow : Int = nEdge*2-1
        var k : Int = 0
        
        for i in 0 ... (nRow-1) {
            if i <= (nEdge-1) {
                if i%2 == 0 {
                    for _ in 0 ... i {
                        retArray.append(k)
                        k += 1
                    }
                } else {
                    let n = k+i
                    for j in 0 ... i {
                        retArray.append(n-j)
                        k += 1
                    }
                }
            } else {
                if i%2 == 0 {
                    for _ in 0 ... (nRow-i-1) {
                        retArray.append(k)
                        k += 1
                    }
                } else {
                    let n = k+nRow-i-1
                    for j in 0 ... (nRow-i-1) {
                        retArray.append(n-j)
                        k += 1
                    }
                }
            }
        }
        
        
        return retArray;
    }
    
    private static func CreateSpiralIndexMatrix(edge nEdge : Int)->Array<Int> {
        let nSize : Int = nEdge*nEdge
        var tempArray : Array<Int> = Array<Int>(repeating: 0, count: nSize)
        var retArray : Array<Int> = Array<Int>()
        var nDirection : Int = 0
        var nCount : Int = 0
        var nRound : Int = 0

        while nCount < nSize {
            for i in nRound ... (nEdge-2-nRound) {
                if nDirection == 0 {
                    tempArray[nRound*nEdge+i] = nCount
                }
                else if nDirection == 1 {
                    tempArray[nEdge*i + nEdge-1-nRound] = nCount
                }
                else if nDirection == 2 {
                    tempArray[(nEdge-1-nRound)*nEdge + (nEdge-1 - i)] = nCount
                }
                else if nDirection == 3 {
                    tempArray[(nEdge-1-i)*nEdge + nRound] = nCount
                }
                nCount += 1
            }
            nDirection += 1;
            nDirection = nDirection%4
            if nDirection == 0 {
                nRound += 1;
                if nRound == (nEdge-1-nRound) {
                    tempArray[nRound*nEdge + nRound] = nCount
                    nCount += 1
                    break // last element is the center.
                }
            }
        }
    
        let nRow : Int = nEdge*2-1;
        nCount = 0;
        for i in 0 ... (nRow-1) {
            let nLen : Int = (i < nEdge) ? (i+1) : (nRow - i)
            var x : Int = (i < nEdge) ? 0 : (i-nEdge+1)
            var y : Int = (i < nEdge) ? i : (nEdge-1);
            
            for _ in 0 ... (nLen-1) {
                let nLabel : Int = tempArray[(y*nEdge+x)];
                x += 1
                y -= 1
                retArray.append(nLabel)
            }
        }

        return retArray;
    }
}

extension DiamondPuzzleHelper {
    class func GetGridRow(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        let nCount : Int = PuzzleHelper.GetDiamonGridBubbleCount(nEdge)
        let nRow : Int = nEdge*2-1;
        for i in 0...(nRow-1) {
            if(i <= nEdge-1) {
                let j = i+1;
                let v1 = (i+1)*i/2;
                let v2 = (j+1)*j/2;
                if (v1 <= nIndex && nIndex < v2) {
                    nRet = i;
                    break;
                }
            }
            else {
                let j = nRow-i;
                let k = nRow-(i+1);
                let v1 = nCount - (j+1)*j/2;
                let v2 = nCount - (k+1)*k/2;
                if(v1 <= nIndex && nIndex < v2) {
                    nRet = i;
                    break;
                }
            }
        }
        return nRet;
    }
    
    class func GetGridColumn(index nIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        let nRowIndex = DiamondPuzzleHelper.GetGridRow(index:nIndex, edge: nEdge);
        let nRow = nEdge*2-1;
        let nFirstIndexAtRow = DiamondPuzzleHelper.GetFirstIndexAtRow(row:nRowIndex, edge: nEdge);
        if(0 <= nRowIndex && nRowIndex <= nEdge-1)
        {
            nRet = nIndex - nFirstIndexAtRow;
        }
        else if(nRowIndex < nRow)
        {
            let nStep = nIndex-nFirstIndexAtRow;
            let nTemp = nRowIndex-(nEdge-1);
            nRet = nStep+nTemp;
        }

        return nRet;
    }
    
    class func GetBubbleCountAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        let nRow = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex+1;
        }
        else if(nRowIndex < nRow) {
            nRet = nRow - nRowIndex;
        }
        return nRet;
    }

    class func GetFirstIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        let nRow = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = (nRowIndex+1)*nRowIndex/2;
        }
        else if(nRowIndex < nRow) {
            let rEdge = nRow - nRowIndex;
            let rCount = rEdge*(rEdge+1)/2;
            nRet = PuzzleHelper.GetDiamonGridBubbleCount(nEdge)-rCount;
        }
        
        return nRet;
    }

    class func GetLastIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        let nRow = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nRow-1) {
            nRet = DiamondPuzzleHelper.GetFirstIndexAtRow(row:nRowIndex+1, edge: nEdge)-1;
        }
        else if(nRowIndex == nRow-1)
        {
            nRet = PuzzleHelper.GetDiamonGridBubbleCount(nEdge)-1;
        }
        
        return nRet;
    }

    class func GetDiagonal120ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;

        if 0 <= nColIndex && nColIndex < nEdge {
            nRet = nEdge;
        }
        
        return nRet;
    }

    class func GetDiagonal60ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        let nRet : Int = GetDiagonal120ColumnBubbleCount(column: nColIndex, edge: nEdge)
        return nRet;
    }

    class func GetGridDiagonal120Column(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet = -1
        let nRowIndex = GetGridRow(index: nIndex, edge: nEdge)
        let nRow = nEdge*2-1;
        let nFirstIndexAtRow = GetFirstIndexAtRow(row:nRowIndex,edge:nEdge);
        if (0 <= nRowIndex && nRowIndex <= nEdge-1)
        {
            nRet = nRowIndex - (nIndex - nFirstIndexAtRow);
        }
        else if (nRowIndex < nRow)
        {
            let nStep = nIndex-nFirstIndexAtRow;
            nRet = (nEdge-1) - nStep;
        }

        return nRet
    }

    class func GetGridIndexAtDiagonal60Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet : Int = -1;
        
        let nRow = nEdge*2-1;
        if(0 <= nColIndex && nColIndex < nEdge && 0 <= nCellIndex && nCellIndex < nEdge)
        {
            let nRowIndex = nColIndex + nCellIndex;
            let nFistIndex = GetFirstIndexAtRow(row:nRowIndex, edge:nEdge)
            if(0 <= nRowIndex && nRowIndex <= nEdge-1)
            {
                nRet = nFistIndex + nColIndex;
            }
            else if(nRowIndex < nRow)
            {
                let nNewCellIndex = nEdge - (nCellIndex+1);
                nRet = nFistIndex + nNewCellIndex;
            }
        }
        
        return nRet
    }

    class func GetGridIndexAtDiagonal120Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet = -1;
        
        let nRow = nEdge*2-1
        if(0 <= nColIndex && nColIndex < nEdge && 0 <= nCellIndex && nCellIndex < nEdge)
        {
            let nRowIndex = nColIndex + nCellIndex
            let nFistIndex = GetFirstIndexAtRow(row:nRowIndex, edge:nEdge)
            if(0 <= nRowIndex && nRowIndex <= nEdge-1)
            {
                nRet = nFistIndex + nCellIndex;
            }
            else if(nRowIndex < nRow)
            {
                let nCount = GetBubbleCountAtRow(row:nRowIndex, edge:nEdge)
                let nNewCellIndex = (nCount-1) - (nEdge - (nCellIndex+1));
                nRet = nFistIndex + nNewCellIndex;
            }
        }
        
        return nRet;

    }
}
