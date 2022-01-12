//
//  Puzzle.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class Puzzle {
    private var m_PuzzleType : enGridType
    private var m_LayoutType : enGridLayout
    private var m_Edge: Int
    private var m_Chips : ChipList
    
    init() {
        m_PuzzleType = enGridType.PUZZLE_GRID_SQUARE
        m_LayoutType = enGridLayout.PUZZLE_LALOUT_MATRIX
        m_Edge = 3
        m_Chips = ChipList()
    }
    
    func Valid()-> Bool {
        return !m_Chips.isEmpty && self.number == m_Chips.count
    }
    
    func Initialize(_ gridType : enGridType, _ gridLayout : enGridLayout, _ nEdge : Int) {
        m_PuzzleType = gridType
        m_LayoutType = gridLayout
        m_Edge = nEdge
        m_Chips.removeAll()
        let indexArray : Array<Int> = PuzzleHelper.CreateIndexMatrix(type: m_PuzzleType, layout: m_LayoutType, edge: m_Edge)
        
        let count = indexArray.count - 1
        for index in 0 ... count {
            let chip : ChipData = ChipData(index, index, indexArray[index]+1)
            m_Chips.append(chip)
        }
    }
    
    func MatchCheck()-> Bool {
        if m_Chips.isEmpty {
            return false
        }
        let count = m_Chips.count - 1
        for index in 0 ... count {
            if !m_Chips[index].IsMatch() {
                return false
            }
        }
        return true
    }
    
    func GetGridRow(index:Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetGridRow(index:index, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }
    
    func GetGridColumn(index :Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetGridColumn(index:index, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }
    
    func GetGridDiagonal120Column(index :Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetGridDiagonal120Column(index:index, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }
    
    func GetBubbleCountAtRow(rowIndex:Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetBubbleCountAtRow(row:rowIndex, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }

    func GetFirstGridIndexAtRow(rowIndex:Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetFirstIndexAtRow(row:rowIndex, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }
    
    func GetLastGridIndexAtRow(rowIndex:Int)->Int
    {
        let nRet : Int = PuzzleHelper.GetLastIndexAtRow(row:rowIndex, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }

    func GetDiagonal120ColumnBubbleCount(column:Int)->Int {
        let nRet : Int = PuzzleHelper.GetDiagonal120ColumnBubbleCount(column:column, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }

    func GetGridIndexAtDiagonal120Column(column nColIndex:Int, at nIndex:Int)->Int {
        let nRet : Int = PuzzleHelper.GetGridIndexAtDiagonal120Column(column:nColIndex, type: m_PuzzleType, edge: m_Edge, at: nIndex)
        return nRet
    }

    func GetDiagonal60ColumnBubbleCount(column:Int)->Int {
        let nRet : Int = PuzzleHelper.GetDiagonal60ColumnBubbleCount(column:column, type: m_PuzzleType, edge: m_Edge)
        return nRet
    }
    

    func GetGridIndexAtDiagonal60Column(column nColIndex:Int, at nIndex:Int)->Int {
        let nRet : Int = PuzzleHelper.GetGridIndexAtDiagonal60Column(column:nColIndex, type: m_PuzzleType, edge: m_Edge, at: nIndex)
        return nRet
    }
   
    func ShiftBubbleTileChip(step:GamePlayStep) {
        switch m_PuzzleType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            case enGridType.PUZZLE_GRID_SQUARE:
                ShiftBubbleTileChipSquarePuzzle(step)
            case enGridType.PUZZLE_GRID_DIAMOND:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            case enGridType.PUZZLE_GRID_HEXAGON:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            }
    }

    func MakeSnapshot( _ indexlist : inout [Int]) {
        if indexlist.isEmpty == false {
            indexlist.removeAll()
        }
        
        let count = m_Chips.count - 1
        for index in 0 ... count {
            indexlist.append(m_Chips[index].realindex)
        }
    }
    
    func ApplySnapshot(_ indexlist : [Int])->Bool {
        guard indexlist.count == m_Chips.count else {
            return false
        }
        
        let count = m_Chips.count - 1
        for index in 0 ... count {
            m_Chips[index].realindex = indexlist[index]
        }
        return true
    }

    func GetRealIndexByLabelIndex(labelIndex: Int)->Int {
        var index : Int = -1

        let count = m_Chips.count - 1
        for i in 0 ... count {
            if m_Chips[i].labelindex == labelIndex {
                index = m_Chips[i].realindex
                break
            }
        }

        return index
    }

    func GetLabelIndex(realIndex: Int)->Int {
        var index : Int = -1

        let count = m_Chips.count - 1
        for i in 0 ... count {
            if m_Chips[i].realindex == realIndex {
                index = m_Chips[i].labelindex
                break
            }
        }

        return index
    }
}

extension Puzzle {
    var puzzleType : enGridType {
        get {
            return m_PuzzleType
        }
    }

    var layoutType : enGridLayout {
        get {
            return m_LayoutType
        }
    }

    var edge: Int {
        get {
            return m_Edge
        }
    }
    
    var number : Int {
        get {
            return PuzzleHelper.GetPuzzleBubbleCount(type: m_PuzzleType, edge:m_Edge)//m_Chips.count
        }
    }

    var chips : ChipList {
        get {
            return m_Chips
        }
    }
}
