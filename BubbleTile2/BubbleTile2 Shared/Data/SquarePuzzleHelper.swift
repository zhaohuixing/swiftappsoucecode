//
//  SquarePuzzleHelper.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 1/31/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class SquarePuzzleHelper {
   
    class func CreateIndexMatrix(layout gridLayout : enGridLayout, edge nSize : Int)->Array<Int> {
        var retArray : Array<Int>?
        
        switch gridLayout {
            case enGridLayout.PUZZLE_LALOUT_MATRIX:
                retArray = SquarePuzzleHelper.CreateMatrixIndexMatrix(edge: nSize)
            case enGridLayout.PUZZLE_LALOUT_SNAKE:
                retArray = SquarePuzzleHelper.CreateSnakeIndexMatrix(edge: nSize)
            case enGridLayout.PUZZLE_LALOUT_SPIRAL:
                retArray = SquarePuzzleHelper.CreateSpiralIndexMatrix(edge: nSize)
            //default:
            //    retArray = nil
        }
        
        return retArray!
    }
    
    private static func CreateMatrixIndexMatrix(edge nSize : Int)->Array<Int> {
        let nCount : Int = nSize*nSize
        var retArray : Array<Int> = Array<Int>(repeating: 0, count: nCount)
        
        for index in 0 ... nCount-1 {
            retArray[index] = index
        }
        
        return retArray;
    }

    private static func CreateSnakeIndexMatrix(edge nSize : Int)->Array<Int> {
        let nCount : Int = nSize*nSize
        var retArray : Array<Int> = Array<Int>(repeating: 0, count: nCount)
        
        var index : Int = 0
        for i in 0 ... nSize-1 {
            if i%2 == 0 {
                for _ in 0 ... nSize-1 {
                    retArray[index] = index
                    index += 1
                }
            }
            else {
                let n = index + nSize-1
                for j in 0 ... nSize-1 {
                    retArray[index] = n-j
                    index += 1
                }
            }
        }
        
        return retArray;
    }

    private static func CreateSpiralIndexMatrix(edge nSize : Int)->Array<Int> {
        let nCount : Int = nSize*nSize
        var retArray : Array<Int> = Array<Int>(repeating: 0, count: nCount)
        
        var index : Int = 0
        var n : Int = 0
        let nThreshed : Int = nSize-1
        var i : Int = 0

        while i <= (nThreshed-i) {
            //upper bound of circle
            for j in i ... (nThreshed-i) {
                index = i*nSize + j
                retArray[index] = n
                n += 1;
            }

            // Swift for loop has no condition check in C/C++ for loop
            // So (i+1) can overflow (nThreshed-i) in the Swift for loop
            // range
            if (i+1) <= (nThreshed-i) {
                //right bound of circle
                for k in i+1 ... (nThreshed-i) {
                    index = k*nSize + (nThreshed-i);
                    retArray[index] = n
                    n += 1;
                }
            }

            //lower bound of circle
            for l in stride (from:nThreshed-i-1, through:i, by:-1) {
                index = (nThreshed-i)*nSize + l;
                retArray[index] = n
                n += 1;
            }

            // Swift for loop has no condition check in C/C++ for loop
            // So (i+1) can overflow (nThreshed-i) in the Swift for loop
            // range
            if (i+1) <= (nThreshed-i) {
                //left bound of circle
                for m in stride (from:nThreshed-i-1, through:(i+1), by:-1) {
                    index = m*nSize + i;
                    retArray[index] = n
                    n += 1;
                }
            }
            
            i += 1
        }

        return retArray;
    }
    
}

extension SquarePuzzleHelper {
    class func GetGridRow(index nIndex:Int, edge nEdge : Int)->Int {
        var nRet : Int = -1;
         
         if (0 <= nIndex && nIndex < nEdge*nEdge) {
            nRet = nIndex/nEdge;
         }
         return nRet;
    }
    
    class func GetGridColumn(index nIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = 0
        
        if(0 <= nIndex && nIndex < nEdge*nEdge)
        {
            nRet = nIndex%nEdge;
        }
        return nRet;
    }
    
    class func GetBubbleCountAtRow(row nIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1
        
        if(0 <= nIndex && nIndex < nEdge) {
            nRet = nEdge;
        }
        return nRet;
    }
    
    class func GetFirstIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex*nEdge;
        }
        return nRet;
    }
    
    class func GetLastIndexAtRow(row nRowIndex:Int, edge nEdge : Int)->Int
    {
        var nRet : Int = -1;
        
        if(0 <= nRowIndex && nRowIndex < nEdge) {
            nRet = nRowIndex*nEdge + (nEdge-1);
        }
        return nRet;
    }
}
