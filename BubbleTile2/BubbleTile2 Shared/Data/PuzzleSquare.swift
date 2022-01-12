//
//  PuzzleSquare.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

extension Puzzle {
    func ShiftBubbleTileChipSquarePuzzle(_ step: GamePlayStep) {
        switch step.motion {
            case enBubbleMotion.BUBBLE_MOTION_HORIZONTAL:
                let nRowIndex = GetGridRow(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipHorizontalForward(row: nRowIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipHorizontalBackward(row: nRowIndex)
                    default:
                        return
                }
            case enBubbleMotion.BUBBLE_MOTION_VERTICAL:
                let nColIndex = GetGridColumn(index:step.index)
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

    func GetChipByGridIndex(gridIndex: Int)->ChipData? {
        guard 0 < self.chips.count && 0 <= gridIndex && gridIndex < self.chips.count else {
            //fatalError("Grid index is not valid for querying puzzle chip by grid index")
            return nil
        }

        for i in 0 ..< self.chips.count {
            let childNode = self.chips[i]
            if childNode.realindex == gridIndex {
                return childNode
            }
        }
        
        return nil
    }

    func ShiftBubbleTileChipHorizontalForward(row: Int) {
        let nCount : Int = GetBubbleCountAtRow(rowIndex: row)
           
        if nCount <= 1 {
            return
        }
           
        let nStartIndex : Int = GetFirstGridIndexAtRow(rowIndex: row)
           let nEndIndex : Int = (nStartIndex + nCount - 1)

        var chiplist : [ChipData] = [ChipData]()
        for i in nStartIndex ... nEndIndex {
            chiplist.append(GetChipByGridIndex(gridIndex:i)!)
        }

        chiplist[nCount-1].realindex = nStartIndex
        for i in nStartIndex ... (nEndIndex-1) {
            chiplist[i-nStartIndex].realindex = i+1
        }
    }
       
    func ShiftBubbleTileChipHorizontalBackward(row: Int) {
        let nCount : Int = GetBubbleCountAtRow(rowIndex: row)
           
        if nCount <= 1 {
            return
        }
           
        let nStartIndex : Int = GetFirstGridIndexAtRow(rowIndex: row)
        let nEndIndex : Int = (nStartIndex + nCount - 1)
    
        var chiplist : [ChipData] = [ChipData]()
        for i in nStartIndex ... nEndIndex {
            chiplist.append(GetChipByGridIndex(gridIndex:i)!)
        }
        chiplist[0].realindex = nEndIndex
        for i in (nStartIndex+1) ... nEndIndex {
            chiplist[i-nStartIndex].realindex = i-1
        }
    }

    func ShiftBubbleTileChipSquarePuzzleVerticalForward(column: Int) {
        //let nStartIndex = column
        let nEndIndex = (self.edge-1)*self.edge+column
        
        var chiplist : [ChipData] = [ChipData]()
        for i in 0 ... (self.edge-1) {
            let k = i*self.edge + column
            chiplist.append(GetChipByGridIndex(gridIndex:k)!)
        }
        
        chiplist[0].realindex = nEndIndex
        for i in 1 ... (self.edge-1) {
            let k = i*self.edge + column - self.edge
            chiplist[i].realindex = k
        }
    }
       
    func ShiftBubbleTileChipSquarePuzzleVerticalBackward(column: Int) {
        let nStartIndex = column
        //let nEndIndex = (self.edge-1)*self.edge+column
           
        var chiplist : [ChipData] = [ChipData]()
        for i in 0 ... (self.edge-1) {
            let k = i*self.edge + column
            chiplist.append(GetChipByGridIndex(gridIndex:k)!)
        }
           
        chiplist[self.edge-1].realindex = nStartIndex
           for i in 0 ... (self.edge-2) {
            let k = (i+1)*self.edge + column
            chiplist[i].realindex = k
        }
    }

}
