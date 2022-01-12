//
//  BubbleDiamondPuzzleTests.swift
//  BubblePuzzleTests
//
//  Created by Zhaohui Xing on 2/3/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class BubbleDiamondPuzzleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDiamondMatrixIndex() {
        var nEdge : Int = 3
        let eType = enGridType.PUZZLE_GRID_DIAMOND
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:3)
        print (sm3.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_DIAMOND, edge: nEdge))
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        print (sm3[6], sm3[7])
        print (sm3[8])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge))

        nEdge = 4
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:4)
        print (sm4.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_DIAMOND, edge: nEdge))
        print (sm4[0])
        print (sm4[1],  sm4[2])
        print (sm4[3],  sm4[4],  sm4[5])
        print (sm4[6],  sm4[7],  sm4[8],  sm4[9])
        print (sm4[10], sm4[11], sm4[12])
        print (sm4[13], sm4[14])
        print (sm4[15])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 9, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 12, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 15, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 9, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 12, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 15, type: eType, edge: nEdge))

        nEdge = 5
        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:5)
        print (sm5.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_DIAMOND, edge: nEdge))
        print (sm5[0])
        print (sm5[1],  sm5[2])
        print (sm5[3],  sm5[4],  sm5[5])
        print (sm5[6],  sm5[7],  sm5[8],  sm5[9])
        print (sm5[10], sm5[11], sm5[12], sm5[13], sm5[14])
        print (sm5[15], sm5[16], sm5[17], sm5[18])
        print (sm5[19], sm5[20], sm5[21])
        print (sm5[22], sm5[23])
        print (sm5[24])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 9, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 21, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 23, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 24, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 9, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 21, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 23, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 24, type: eType, edge: nEdge))

    }

    func testDiamondSnakeIndex() {
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:3)
        print (sm3.count)
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        print (sm3[6], sm3[7])
        print (sm3[8])

        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:4)
        print (sm4.count)
        print (sm4[0])
        print (sm4[1],  sm4[2])
        print (sm4[3],  sm4[4],  sm4[5])
        print (sm4[6],  sm4[7],  sm4[8],  sm4[9])
        print (sm4[10], sm4[11], sm4[12])
        print (sm4[13], sm4[14])
        print (sm4[15])

        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:5)
        print (sm5.count)
        print (sm5[0])
        print (sm5[1],  sm5[2])
        print (sm5[3],  sm5[4],  sm5[5])
        print (sm5[6],  sm5[7],  sm5[8],  sm5[9])
        print (sm5[10], sm5[11], sm5[12], sm5[13], sm5[14])
        print (sm5[15], sm5[16], sm5[17], sm5[18])
        print (sm5[19], sm5[20], sm5[21])
        print (sm5[22], sm5[23])
        print (sm5[24])
    }

    func testDiamondSpiralIndex() {
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:3)
        print (sm3.count)
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        print (sm3[6], sm3[7])
        print (sm3[8])
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:4)
        print (sm4.count)
        print (sm4[0])
        print (sm4[1],  sm4[2])
        print (sm4[3],  sm4[4],  sm4[5])
        print (sm4[6],  sm4[7],  sm4[8],  sm4[9])
        print (sm4[10], sm4[11], sm4[12])
        print (sm4[13], sm4[14])
        print (sm4[15])
        
        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_DIAMOND, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:5)
        print (sm5.count)
        print (sm5[0])
        print (sm5[1],  sm5[2])
        print (sm5[3],  sm5[4],  sm5[5])
        print (sm5[6],  sm5[7],  sm5[8],  sm5[9])
        print (sm5[10], sm5[11], sm5[12], sm5[13], sm5[14])
        print (sm5[15], sm5[16], sm5[17], sm5[18])
        print (sm5[19], sm5[20], sm5[21])
        print (sm5[22], sm5[23])
        print (sm5[24])
    }

}
