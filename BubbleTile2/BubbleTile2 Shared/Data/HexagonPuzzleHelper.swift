//
//  HexagonPuzzleHelper.swift
//  BubbleTile2 iOS
//
//  Created by Zhaohui Xing on 2/4/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class HexagonPuzzleHelper {
    class func CreateIndexMatrix(layout gridLayout : enGridLayout, edge nSize : Int)->Array<Int> {
        var retArray : Array<Int>?
        
        switch gridLayout {
            case enGridLayout.PUZZLE_LALOUT_MATRIX:
                retArray = HexagonPuzzleHelper.CreateMatrixIndexMatrix(edge: nSize)
            case enGridLayout.PUZZLE_LALOUT_SNAKE:
                retArray = HexagonPuzzleHelper.CreateSnakeIndexMatrix(edge: nSize)
            case enGridLayout.PUZZLE_LALOUT_SPIRAL:
                retArray = HexagonPuzzleHelper.CreateSpiralIndexMatrix(edge: nSize)
        }
        
        return retArray!
    }
    
    private static func CreateMatrixIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
       
        let nRow : Int = nEdge*2-1
        var k : Int = 0
        for i in 0 ... (nRow-1) {
            if i <= nEdge-1 {
                for _ in 0 ... (i+nEdge-1) {
                    retArray.append(k)
                    k += 1;
                }
            }
            else
            {
                for _ in 0 ... (nRow-i+nEdge-1-1) {
                    retArray.append(k)
                    k += 1;
                }
            }
        }

        return retArray;
    }
    
    private static func CreateSnakeIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
        
        let nRow : Int = nEdge*2-1;
        var k : Int = 0;
        for i in 0 ... (nRow-1) {
            if i <= (nEdge-1) {
                if(i%2 == 0) {
                    for _ in 0 ... (i+nEdge-1) {
                        retArray.append(k)
                        k += 1;
                    }
                }
                else {
                    let n : Int = (k+i+1+nEdge-1-1);
                    for j in 0 ... (i+nEdge-1) {
                        retArray.append(n-j)
                        k += 1;
                    }
                }
            } else {
                if i%2 == 0 {
                    for _ in 0 ... (nRow-i+nEdge-1-1) {
                        retArray.append(k)
                        k += 1;
                    }
                }
                else
                {
                    let n : Int = k+nRow-i+nEdge-1-1;
                    for j in 0 ... (nRow-i+nEdge-1-1) {
                        retArray.append(n-j)
                        k += 1;
                    }
                }
            }
        }

        return retArray;
    }
    
    private static func CreateSpiralIndexMatrix(edge nEdge : Int)->Array<Int> {
        var retArray : Array<Int> = Array<Int>()
        
        let nExclued : Int = nEdge-1;
        let nLen : Int = nEdge*2-1;
        var tempArray : Array<Int> = Array<Int>(repeating: 0, count: nLen*nLen)
        let nSize : Int = nLen*nLen - nExclued*nEdge;
        var nDirection : Int = 0;
        var nCount : Int = 0;
        var nRound : Int = 0;
        while (nCount < nSize) {
            for  i in (nEdge-1) ... (nLen-1-nRound-1) {
                if (nDirection == 0) {
                    tempArray[nRound*nLen + i] = nCount;
                }
                else if (nDirection == 1)
                {
                    tempArray[(nRound + i - (nEdge-1))*nLen + nLen-1-nRound] = nCount;
                }
                else if (nDirection == 2)
                {
                    tempArray[i*nLen + nLen-1-i+(nEdge-1)-nRound] = nCount;
                }
                else if (nDirection == 3)
                {
                    tempArray[(nLen-1-nRound)*nLen + nEdge-1 - (i - (nEdge-1))] = nCount;
                }
                else if (nDirection == 4)
                {
                    tempArray[(nLen-1-nRound-(i-(nEdge-1)))*nLen + nRound] = nCount;
                }
                else if (nDirection == 5)
                {
                    tempArray[(nEdge-1-(i-(nEdge-1)))*nLen + nRound+(i-(nEdge-1))] = nCount;
                }
                nCount += 1;
            }
            nDirection += 1
            nDirection = nDirection%6;
            if (nDirection == 0) {
                nRound += 1;
                if (nRound == nEdge-1) {
                    tempArray[(nEdge-1)*nLen + nEdge-1] = nCount;
                    nCount += 1
                    break;
                }
            }
        }
        
        for i in 0 ... (nLen-1) {
            let nTriLen : Int = (i < nEdge) ? (i+nEdge) : (nLen + (nEdge-1)-i);
            var x : Int = (i < nEdge) ? nEdge-1-i: 0;
            
            for _ in 0 ... (nTriLen-1) {
                let nLabel : Int = tempArray[i*nLen+x];
                x += 1;
                retArray.append(nLabel)
            }
        }

        return retArray;
    }
}

extension HexagonPuzzleHelper {
    class func GetBubbleCountAtRow(row nRowIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        let nRow : Int = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex+nEdge;
        } else if(nRowIndex < nRow) {
            nRet = nRow - nRowIndex+(nEdge-1);
        }
        return nRet;
    }
    
    class func GetFirstIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        let nRow : Int = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex*(nRowIndex+1)/2+nRowIndex*(nEdge-1);
        }
        else if (nRowIndex < nRow) {
            let rEdge : Int = nRow - nRowIndex;
            let rCount : Int = rEdge*(rEdge+1)/2+rEdge*(nEdge-1);
            nRet = PuzzleHelper.GetHexagonGridBubbleCount(nEdge)-rCount;
        }
        
        return nRet;
    }

    class func GetLastIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        
        let nRow : Int = nEdge*2-1;
        
        if(0 <= nRowIndex && nRowIndex < nRow) {
            nRet = HexagonPuzzleHelper.GetFirstIndexAtRow(row:nRowIndex, edge: nEdge)
                + HexagonPuzzleHelper.GetBubbleCountAtRow(row:nRowIndex, edge: nEdge)-1;
        }
        
        return nRet;
    }
}

extension HexagonPuzzleHelper {
    class func GetGridRow(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1
        
        let nRow : Int = nEdge*2-1;
        for i in 0...(nRow-1) {
            let nFirst = HexagonPuzzleHelper.GetFirstIndexAtRow(row:i, edge:nEdge)
            let nLast = HexagonPuzzleHelper.GetLastIndexAtRow(row:i, edge:nEdge)
            if (nFirst <= nIndex && nIndex <= nLast) {
                nRet = i;
                return nRet;
            }
        }
        
        return nRet;
    }

    class func GetGridColumn(index nIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        let nRow = nEdge*2-1;
        let nRowIndex = HexagonPuzzleHelper.GetGridRow(index:nIndex, edge: nEdge);
        if(0 <= nRowIndex && nRowIndex < nEdge)
        {
            let nFirst = HexagonPuzzleHelper.GetFirstIndexAtRow(row:nRowIndex, edge:nEdge);
            nRet = nIndex-nFirst;
        }
        else if(nRowIndex < nRow)
        {
            let nTempFirst = nRowIndex-nEdge+1;
            let nFirst = HexagonPuzzleHelper.GetFirstIndexAtRow(row:nRowIndex, edge:nEdge);
            nRet = nIndex-nFirst+nTempFirst;
        }

        return nRet;
    }
    
    class func GetDiagonal60ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        let nRet : Int = GetBubbleCountAtRow(row:nColIndex, edge: nEdge)
        return nRet;
    }

    class func GetDiagonal120ColumnBubbleCount(column nColIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
        nRet = GetBubbleCountAtRow(row:nColIndex, edge: nEdge)
        return nRet;
    }
    
    class func GetGridDiagonal120Column(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet = -1
        let nRowIndex = GetGridRow(index: nIndex, edge: nEdge)
        let nRow = nEdge*2-1
        let nLastIndexAtRow = GetLastIndexAtRow(row:nRowIndex, edge:nEdge)
        if (0 <= nRowIndex && nRowIndex <= nEdge-1)
        {
            nRet = nLastIndexAtRow - nIndex;
        }
        else if (nRowIndex < nRow)
        {
            let nFirstIndex = GetFirstIndexAtRow(row:nRowIndex, edge:nEdge)
            let nStep = nIndex-nFirstIndex;
            nRet = (nRow-1) - nStep;
        }

        return nRet
    }

    class func GetGridIndexAtDiagonal60Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet : Int = -1;
        
        let nRow = nEdge*2-1;
        let nCount = GetDiagonal60ColumnBubbleCount(column:nColIndex, edge: nEdge)
        if(0 <= nColIndex && nColIndex < nEdge)
        {
            if(0 <= nCellIndex && nCellIndex < nEdge)
            {
                let nFirst = GetFirstIndexAtRow(row:nCellIndex, edge:nEdge)
                nRet = nFirst + nColIndex;
            }
            else if(nEdge <= nCellIndex && nCellIndex < nRow)
            {
                let nTemp = nCount-(nCellIndex+1);
                nRet = GetFirstIndexAtRow(row:nCellIndex, edge:nEdge)+nTemp
            }
        }
        else if(nEdge <= nColIndex && nColIndex < nRow)
        {
            let nTempRow = (nColIndex-nEdge+1)+nCellIndex;
            if(0 <= nTempRow && nTempRow <= nEdge-1)
            {
                let nLast = GetLastIndexAtRow(row:nTempRow, edge:nEdge)
                nRet = nLast - nCellIndex;
            }
            else if(nEdge <= nTempRow && nTempRow < nRow)
            {
                let nTemp = nTempRow - nEdge + 1;
                let nLast = GetLastIndexAtRow(row:nTempRow, edge:nEdge)
                nRet = nLast + nTemp - nCellIndex;
            }
        }
        
        return nRet
    }

    class func GetGridIndexAtDiagonal120Column(column nColIndex:Int, edge nEdge : Int, at nCellIndex: Int)->Int {
        var nRet = -1;
    
        let nRow = nEdge*2-1;
        let nCount = GetDiagonal120ColumnBubbleCount(column:nColIndex, edge: nEdge)
    
        if(0 <= nColIndex && nColIndex < nEdge)
        {
            if(0 <= nCellIndex && nCellIndex < nEdge)
            {
                let nLast = GetLastIndexAtRow(row:nCellIndex, edge:nEdge)
                nRet = nLast - nColIndex
            }
            else if(nEdge <= nCellIndex && nCellIndex < nRow)
            {
                let nTemp = nCount-(nCellIndex+1);
                nRet = GetLastIndexAtRow(row:nCellIndex, edge:nEdge)-nTemp;
            }
        }
        else if(nEdge <= nColIndex && nColIndex < nRow)
        {
            let nTempRow = (nColIndex-nEdge+1)+nCellIndex;
            if(0 <= nTempRow && nTempRow <= nEdge-1)
            {
                let nFirst = GetFirstIndexAtRow(row:nTempRow, edge:nEdge)
                nRet = nFirst + nCellIndex
            }
            else if(nEdge <= nTempRow && nTempRow < nRow)
            {
                let nTemp = nTempRow - nEdge + 1;
                let nFirst = GetFirstIndexAtRow(row:nTempRow, edge:nEdge)
                nRet = nFirst + nCellIndex - nTemp;
            }
        }
        return nRet;
    }
}
