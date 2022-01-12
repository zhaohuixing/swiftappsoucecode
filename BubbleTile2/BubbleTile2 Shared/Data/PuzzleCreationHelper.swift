//
//  PuzzleCreationHelper.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 1/30/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class PuzzleCreationHelper {
    
    //Static function
    class func CreatePuzzle(type gridType : enGridType, layout gridLayout : enGridLayout, edge nEdge : Int)->IPuzzle {
        let puzzle : IPuzzle = CreateEmptyPuzzle(type:gridType)
        puzzle.Initialize(gridLayout, nEdge)
        return puzzle
    }

    class func CreateEmptyPuzzle(type gridType : enGridType)->IPuzzle {
        var puzzle : IPuzzle
        
        switch gridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                puzzle = TrianglePuzzle()
            case enGridType.PUZZLE_GRID_SQUARE:
                puzzle = SquarePuzzle()
            case enGridType.PUZZLE_GRID_DIAMOND:
                puzzle = DiamondPuzzle()
            case enGridType.PUZZLE_GRID_HEXAGON:
                puzzle = HexagonPuzzle()
        }
        return puzzle
    }
}
