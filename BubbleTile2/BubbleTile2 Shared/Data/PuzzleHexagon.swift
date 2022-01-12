//
//  PuzzleHexagon.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

extension Puzzle {
    func ShiftBubbleTileChipDiagonal60Forward(column: Int) {
        let nCount : Int = GetDiagonal60ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            return
        }

        var chiplist : [ChipData] = [ChipData]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = GetGridIndexAtDiagonal60Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        
        chiplist[0].realindex = indexlist[nCount-1];
        for i in 1 ... (nCount-1) {
            chiplist[i].realindex = indexlist[i-1]
        }
    }
    
    func ShiftBubbleTileChipDiagonal60Backward(column: Int) {
        let nCount : Int = GetDiagonal60ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            return
        }

        var chiplist : [ChipData] = [ChipData]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = GetGridIndexAtDiagonal60Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        
        chiplist[nCount-1].realindex = indexlist[0]
        for i in 0 ... (nCount-2) {
            chiplist[i].realindex = indexlist[i+1]
        }
    }

    func ShiftBubbleTileChipDiagonal120Forward(column: Int) {
        let nCount : Int = GetDiagonal120ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            return
        }

        var chiplist : [ChipData] = [ChipData]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = GetGridIndexAtDiagonal120Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        
        chiplist[0].realindex = indexlist[nCount-1]
        for i in 1 ... (nCount-1) {
            chiplist[i].realindex = indexlist[i-1]
        }
    }
    
    func ShiftBubbleTileChipDiagonal120Backward(column: Int) {
        let nCount : Int = GetDiagonal120ColumnBubbleCount(column: column)
        
        if (nCount <= 1) {
            return
        }

        var chiplist : [ChipData] = [ChipData]()
        var indexlist : [Int] = [Int]()
        for i in 0 ... (nCount-1) {
            let gridIndex = GetGridIndexAtDiagonal120Column(column: column, at: i)
            chiplist.append(GetChipByGridIndex(gridIndex:gridIndex)!)
            indexlist.append(gridIndex)
        }
        
        chiplist[nCount-1].realindex = indexlist[0]
        for i in 0 ... (nCount-2) {
            chiplist[i].realindex = indexlist[i+1]
        }
    }

}
