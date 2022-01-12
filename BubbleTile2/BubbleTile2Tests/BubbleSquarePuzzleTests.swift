//
//  BubbleSquarePuzzleTests.swift
//  BubblePuzzleTests
//
//  Created by Zhaohui Xing on 1/26/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class BubbleSquarePuzzleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let x : Int = 9
        print (x)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let x : Int = 8
            print (x)
        }
    }
    
    func testSquareMatrixIndex () {
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:5)
        print (sm.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        for i in 0...4 {
            print(sm[5*i], sm[5*i+1], sm[5*i+2], sm[5*i+3], sm[5*i+4])
        }
        for i in 0...4 {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        }
        for i in 0...4 {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        }
        for i in 0...4 {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        }

        for i in 0...4 {
            print(PuzzleHelper.GetGridRow(index: 5*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridRow(index: 5*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridRow(index: 5*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridRow(index: 5*i+3, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridRow(index: 5*i+4, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        }
        for i in 0...4 {
            print(PuzzleHelper.GetGridColumn(index: 5*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridColumn(index: 5*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridColumn(index: 5*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridColumn(index: 5*i+3, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5),
                  PuzzleHelper.GetGridColumn(index: 5*i+4, type: enGridType.PUZZLE_GRID_SQUARE, edge: 5))
        }

        let sm2 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:2)
        print (sm2.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        for i in 0...1 {
            print(sm2[2*i], sm2[2*i+1])
        }
        for i in 0...1 {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        }
        for i in 0...1 {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        }
        for i in 0...1 {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        }

        for i in 0...1 {
            print(PuzzleHelper.GetGridRow(index: 2*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2),
                  PuzzleHelper.GetGridRow(index: 2*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        }
        for i in 0...1 {
            print(PuzzleHelper.GetGridColumn(index: 2*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2),
                  PuzzleHelper.GetGridColumn(index: 2*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 2))
        }

        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:3)
        print (sm3.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        for i in 0...2 {
            print(sm3[3*i], sm3[3*i+1], sm3[3*i+2])
        }
        for i in 0...2 {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        }
        for i in 0...2 {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        }
        for i in 0...2 {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        }
        for i in 0...2 {
            print(PuzzleHelper.GetGridRow(index: 3*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3),
                  PuzzleHelper.GetGridRow(index: 3*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3),
                  PuzzleHelper.GetGridRow(index: 3*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        }
        for i in 0...2 {
            print(PuzzleHelper.GetGridColumn(index: 3*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3),
                  PuzzleHelper.GetGridColumn(index: 3*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3),
                  PuzzleHelper.GetGridColumn(index: 3*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 3))
        }

        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:4)
        print (sm4.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        for i in 0...3 {
            print(sm4[4*i], sm4[4*i+1], sm4[4*i+2], sm4[4*i+3])
        }
        for i in 0...3 {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        }
        for i in 0...3 {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        }
        for i in 0...3 {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        }
        for i in 0...3 {
            print(PuzzleHelper.GetGridRow(index: 4*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridRow(index: 4*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridRow(index: 4*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridRow(index: 4*i+3, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        }
        for i in 0...3 {
            print(PuzzleHelper.GetGridColumn(index: 4*i, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridColumn(index: 4*i+1, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridColumn(index: 4*i+2, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4),
                  PuzzleHelper.GetGridColumn(index: 4*i+3, type: enGridType.PUZZLE_GRID_SQUARE, edge: 4))
        }

        
    }

    func testSnakeMatrixIndex () {
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:5)
        print (sm.count)
        
        for i in 0...4 {
            print(sm[5*i], sm[5*i+1], sm[5*i+2], sm[5*i+3], sm[5*i+4])
        }
        let sm2 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:2)
        print (sm2.count)
        for i in 0...1 {
            print(sm2[2*i], sm2[2*i+1])
        }
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:3)
        print (sm3.count)
        for i in 0...2 {
            print(sm3[3*i], sm3[3*i+1], sm3[3*i+2])
        }

        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:4)
        print (sm4.count)
        for i in 0...3 {
            print(sm4[4*i], sm4[4*i+1], sm4[4*i+2], sm4[4*i+3])
        }
    }

 
    func testSpiralMatrixIndex () {
        //var delta : Int = 0;
        //for i in stride (from: 0, through:(6-delta), by: 1)
        /*for i in 0...(6-delta) //Wrong , for loop in swift not support dynamic range
        {
            print(i)
            delta += 1;
        }
        
        var i : Int = 0
        while i <= (6-i) {
            print(i)
            i += 1
        }*/
        
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:5)
        print (sm.count)
        
        for i in 0...4 {
            print(sm[5*i], sm[5*i+1], sm[5*i+2], sm[5*i+3], sm[5*i+4])
        }
        let sm2 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:2)
        print (sm2.count)
        for i in 0...1 {
            print(sm2[2*i], sm2[2*i+1])
        }
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:3)
        print (sm3.count)
        for i in 0...2 {
            print(sm3[3*i], sm3[3*i+1], sm3[3*i+2])
        }
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_SQUARE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:4)
        print (sm4.count)
        for i in 0...3 {
            print(sm4[4*i], sm4[4*i+1], sm4[4*i+2], sm4[4*i+3])
        }
    }

}
