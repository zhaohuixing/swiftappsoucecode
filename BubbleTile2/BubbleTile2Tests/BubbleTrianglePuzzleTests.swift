//
//  BubbleTrianglePuzzleTests.swift
//  BubblePuzzle
//
//  Created by Zhaohui Xing on 2/2/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class BubbleTrianglePuzzleTests: XCTestCase {

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

    func testTriangleMatrixIndex() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let eType = enGridType.PUZZLE_GRID_TRIANGLE
        var nEdge = 5
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:5)
        print (sm.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_TRIANGLE, edge: nEdge))
        print (sm[0])
        print (sm[1], sm[2])
        print (sm[3], sm[4], sm[5])
        print (sm[6], sm[7], sm[8], sm[9])
        print (sm[10], sm[11], sm[12], sm[13], sm[14])
        
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
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

        nEdge = 4
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:4)
        print (sm4.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_TRIANGLE, edge: nEdge))
        print (sm4[0])
        print (sm4[1], sm4[2])
        print (sm4[3], sm4[4], sm4[5])
        print (sm4[6], sm4[7], sm4[8], sm4[9])
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
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

        
        nEdge = 3
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:3)
        print (sm3.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_TRIANGLE, edge: nEdge))
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge))

        nEdge = 6
        let sm6 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:6)
        print (sm6.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_TRIANGLE, edge: nEdge))
        print (sm6[0])
        print (sm6[1], sm6[2])
        print (sm6[3], sm6[4], sm6[5])
        print (sm6[6], sm6[7], sm6[8], sm6[9])
        print (sm6[10], sm6[11], sm6[12], sm6[13], sm6[14])
        print (sm6[15], sm6[16], sm6[17], sm6[18], sm6[19], sm6[20])
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
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
               PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 20, type: eType, edge: nEdge))

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
               PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 20, type: eType, edge: nEdge))

        nEdge = 7
        let sm7 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:7)
        print (sm7.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_TRIANGLE, edge: nEdge))
        print (sm7[0])
        print (sm7[1], sm7[2])
        print (sm7[3], sm7[4], sm7[5])
        print (sm7[6], sm7[7], sm7[8], sm7[9])
        print (sm7[10], sm7[11], sm7[12], sm7[13], sm7[14])
        print (sm7[15], sm7[16], sm7[17], sm7[18], sm7[19], sm7[20])
        print (sm7[21], sm7[22], sm7[23], sm7[24], sm7[25], sm7[26], sm7[27])
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge-1) {
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
               PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 20, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 21, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 25, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 27, type: eType, edge: nEdge))

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
               PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 20, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 21, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 25, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 27, type: eType, edge: nEdge))

    }
    
    func testTriangleSnakeIndex() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:5)
        print (sm.count)
        print (sm[0])
        print (sm[1], sm[2])
        print (sm[3], sm[4], sm[5])
        print (sm[6], sm[7], sm[8], sm[9])
        print (sm[10], sm[11], sm[12], sm[13], sm[14])
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:4)
        print (sm4.count)
        print (sm4[0])
        print (sm4[1], sm4[2])
        print (sm4[3], sm4[4], sm4[5])
        print (sm4[6], sm4[7], sm4[8], sm4[9])
        
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:3)
        print (sm3.count)
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        
        let sm6 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:6)
        print (sm6.count)
        print (sm6[0])
        print (sm6[1], sm6[2])
        print (sm6[3], sm6[4], sm6[5])
        print (sm6[6], sm6[7], sm6[8], sm6[9])
        print (sm6[10], sm6[11], sm6[12], sm6[13], sm6[14])
        print (sm6[15], sm6[16], sm6[17], sm6[18], sm6[19], sm6[20])
        
        let sm7 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:7)
        print (sm7.count)
        print (sm7[0])
        print (sm7[1], sm7[2])
        print (sm7[3], sm7[4], sm7[5])
        print (sm7[6], sm7[7], sm7[8], sm7[9])
        print (sm7[10], sm7[11], sm7[12], sm7[13], sm7[14])
        print (sm7[15], sm7[16], sm7[17], sm7[18], sm7[19], sm7[20])
        print (sm7[21], sm7[22], sm7[23], sm7[24], sm7[25], sm7[26], sm7[27])
    }

    func testTriangleSpiralIndex() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sm : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:5)
        print (sm.count)
        print (sm[0])
        print (sm[1], sm[2])
        print (sm[3], sm[4], sm[5])
        print (sm[6], sm[7], sm[8], sm[9])
        print (sm[10], sm[11], sm[12], sm[13], sm[14])
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:4)
        print (sm4.count)
        print (sm4[0])
        print (sm4[1], sm4[2])
        print (sm4[3], sm4[4], sm4[5])
        print (sm4[6], sm4[7], sm4[8], sm4[9])
        
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:3)
        print (sm3.count)
        print (sm3[0])
        print (sm3[1], sm3[2])
        print (sm3[3], sm3[4], sm3[5])
        
        let sm6 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:6)
        print (sm6.count)
        print (sm6[0])
        print (sm6[1], sm6[2])
        print (sm6[3], sm6[4], sm6[5])
        print (sm6[6], sm6[7], sm6[8], sm6[9])
        print (sm6[10], sm6[11], sm6[12], sm6[13], sm6[14])
        print (sm6[15], sm6[16], sm6[17], sm6[18], sm6[19], sm6[20])
        
        let sm7 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_TRIANGLE, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:7)
        print (sm7.count)
        print (sm7[0])
        print (sm7[1], sm7[2])
        print (sm7[3], sm7[4], sm7[5])
        print (sm7[6], sm7[7], sm7[8], sm7[9])
        print (sm7[10], sm7[11], sm7[12], sm7[13], sm7[14])
        print (sm7[15], sm7[16], sm7[17], sm7[18], sm7[19], sm7[20])
        print (sm7[21], sm7[22], sm7[23], sm7[24], sm7[25], sm7[26], sm7[27])
    }

}
