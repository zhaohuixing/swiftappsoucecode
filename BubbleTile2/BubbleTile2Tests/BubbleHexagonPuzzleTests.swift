//
//  BubbleHexagonPuzzleTests.swift
//  BubblePuzzleTests
//
//  Created by Zhaohui Xing on 2/4/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class BubbleHexagonPuzzleTests: XCTestCase {

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

    func testHexagonMatrixIndex() {
        var nEdge : Int = 3
        let eType = enGridType.PUZZLE_GRID_HEXAGON
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:3)
        print (sm3.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_HEXAGON, edge: nEdge))
        print (sm3[0],  sm3[1],  sm3[2])
        print (sm3[3],  sm3[4],  sm3[5],  sm3[6])
        print (sm3[7],  sm3[8],  sm3[9],  sm3[10], sm3[11])
        print (sm3[12], sm3[13],  sm3[14],  sm3[15])
        print (sm3[16], sm3[17],  sm3[18])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 11, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 14, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 15, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 11, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 14, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 15, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge))

        nEdge = 4
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:4)
        print (sm4.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_HEXAGON, edge: nEdge))
        print (sm4[0],  sm4[1],  sm4[2],  sm4[3])
        print (sm4[4],  sm4[5],  sm4[6],  sm4[7],  sm4[8])
        print (sm4[9],  sm4[10], sm4[11], sm4[12], sm4[13], sm4[14])
        print (sm4[15], sm4[16], sm4[17], sm4[18], sm4[19], sm4[20], sm4[21])
        print (sm4[22], sm4[23], sm4[24], sm4[25], sm4[26], sm4[27])
        print (sm4[28], sm4[29], sm4[30], sm4[31], sm4[32])
        print (sm4[33], sm4[34], sm4[35], sm4[36])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 21, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 25, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 27, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 28, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 29, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 30, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 31, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 32, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 33, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 34, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 35, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 36, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 10, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 14, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 17, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 21, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 25, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 27, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 28, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 29, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 30, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 31, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 32, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 33, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 34, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 35, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 36, type: eType, edge: nEdge))

        nEdge = 5
        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge:5)
        print (sm5.count)
        print (PuzzleHelper.GetPuzzleBubbleNumber(type: enGridType.PUZZLE_GRID_HEXAGON, edge: nEdge))
        print (sm5[0],  sm5[1],  sm5[2],  sm5[3],  sm5[4])
        print (sm5[5],  sm5[6],  sm5[7],  sm5[8],  sm5[9], sm5[10])
        print (sm5[11], sm5[12], sm5[13], sm5[14], sm5[15], sm5[16], sm5[17])
        print (sm5[18], sm5[19], sm5[20], sm5[21], sm5[22], sm5[23], sm5[24], sm5[25])
        print (sm5[26], sm5[27], sm5[28], sm5[29], sm5[30], sm5[31], sm5[32], sm5[33], sm5[34])
        print (sm5[35], sm5[36], sm5[37], sm5[38], sm5[39], sm5[40], sm5[41], sm5[42])
        print (sm5[43], sm5[44], sm5[45], sm5[46], sm5[47], sm5[48], sm5[49])
        print (sm5[50], sm5[51], sm5[52], sm5[53], sm5[54], sm5[55])
        print (sm5[56], sm5[57], sm5[58], sm5[59], sm5[60])
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetBubbleNumberAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetFirstIndexAtRow(row: i, type: eType, edge: nEdge))
        }
        for i in 0...(nEdge*2-2) {
            print(PuzzleHelper.GetLastIndexAtRow(row: i, type: eType, edge: nEdge))
        }

        print (PuzzleHelper.GetGridRow(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 2, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 4, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 10, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 14, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 17, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 21, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 25, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 27, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 28, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 29, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 30, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 31, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 32, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 33, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 34, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 35, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 36, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 37, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 38, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 39, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 40, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 41, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 42, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 43, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 44, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 45, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 46, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 47, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 48, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 49, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 50, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 51, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 52, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 53, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 54, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 55, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridRow(index: 56, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 57, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 58, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 59, type: eType, edge: nEdge),
               PuzzleHelper.GetGridRow(index: 60, type: eType, edge: nEdge))

        print (PuzzleHelper.GetGridColumn(index: 0, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 1, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 2, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 3, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 4, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 5, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 6, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 7, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 8, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 9, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 10, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 11, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 12, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 13, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 14, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 15, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 16, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 17, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 18, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 19, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 20, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 21, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 22, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 23, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 24, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 25, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 26, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 27, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 28, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 29, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 30, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 31, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 32, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 33, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 34, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 35, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 36, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 37, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 38, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 39, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 40, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 41, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 42, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 43, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 44, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 45, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 46, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 47, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 48, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 49, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 50, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 51, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 52, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 53, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 54, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 55, type: eType, edge: nEdge))
        print (PuzzleHelper.GetGridColumn(index: 56, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 57, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 58, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 59, type: eType, edge: nEdge),
               PuzzleHelper.GetGridColumn(index: 60, type: eType, edge: nEdge))
    }
    
    func testHexagonSnakeIndex() {
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:3)
        print (sm3.count)
        print (sm3[0],  sm3[1],  sm3[2])
        print (sm3[3],  sm3[4],  sm3[5],  sm3[6])
        print (sm3[7],  sm3[8],  sm3[9],  sm3[10], sm3[11])
        print (sm3[12], sm3[13],  sm3[14],  sm3[15])
        print (sm3[16], sm3[17],  sm3[18])
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:4)
        print (sm4.count)
        print (sm4[0],  sm4[1],  sm4[2],  sm4[3])
        print (sm4[4],  sm4[5],  sm4[6],  sm4[7],  sm4[8])
        print (sm4[9],  sm4[10], sm4[11], sm4[12], sm4[13], sm4[14])
        print (sm4[15], sm4[16], sm4[17], sm4[18], sm4[19], sm4[20], sm4[21])
        print (sm4[22], sm4[23], sm4[24], sm4[25], sm4[26], sm4[27])
        print (sm4[28], sm4[29], sm4[30], sm4[31], sm4[32])
        print (sm4[33], sm4[34], sm4[35], sm4[36])
        
        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge:5)
        print (sm5.count)
        print (sm5[0],  sm5[1],  sm5[2],  sm5[3],  sm5[4])
        print (sm5[5],  sm5[6],  sm5[7],  sm5[8],  sm5[9], sm5[10])
        print (sm5[11], sm5[12], sm5[13], sm5[14], sm5[15], sm5[16], sm5[17])
        print (sm5[18], sm5[19], sm5[20], sm5[21], sm5[22], sm5[23], sm5[24], sm5[25])
        print (sm5[26], sm5[27], sm5[28], sm5[29], sm5[30], sm5[31], sm5[32], sm5[33], sm5[34])
        print (sm5[35], sm5[36], sm5[37], sm5[38], sm5[39], sm5[40], sm5[41], sm5[42])
        print (sm5[43], sm5[44], sm5[45], sm5[46], sm5[47], sm5[48], sm5[49])
        print (sm5[50], sm5[51], sm5[52], sm5[53], sm5[54], sm5[55])
        print (sm5[56], sm5[57], sm5[58], sm5[59], sm5[60])
    }
    
    func testHexagonSpiralIndex() {
        let sm3 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:3)
        print (sm3.count)
        print (sm3[0],  sm3[1],  sm3[2])
        print (sm3[3],  sm3[4],  sm3[5],  sm3[6])
        print (sm3[7],  sm3[8],  sm3[9],  sm3[10], sm3[11])
        print (sm3[12], sm3[13],  sm3[14],  sm3[15])
        print (sm3[16], sm3[17],  sm3[18])
        
        let sm4 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:4)
        print (sm4.count)
        print (sm4[0],  sm4[1],  sm4[2],  sm4[3])
        print (sm4[4],  sm4[5],  sm4[6],  sm4[7],  sm4[8])
        print (sm4[9],  sm4[10], sm4[11], sm4[12], sm4[13], sm4[14])
        print (sm4[15], sm4[16], sm4[17], sm4[18], sm4[19], sm4[20], sm4[21])
        print (sm4[22], sm4[23], sm4[24], sm4[25], sm4[26], sm4[27])
        print (sm4[28], sm4[29], sm4[30], sm4[31], sm4[32])
        print (sm4[33], sm4[34], sm4[35], sm4[36])
        
        let sm5 : Array<Int> = PuzzleHelper.CreateIndexMatrix(type:enGridType.PUZZLE_GRID_HEXAGON, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge:5)
        print (sm5.count)
        print (sm5[0],  sm5[1],  sm5[2],  sm5[3],  sm5[4])
        print (sm5[5],  sm5[6],  sm5[7],  sm5[8],  sm5[9], sm5[10])
        print (sm5[11], sm5[12], sm5[13], sm5[14], sm5[15], sm5[16], sm5[17])
        print (sm5[18], sm5[19], sm5[20], sm5[21], sm5[22], sm5[23], sm5[24], sm5[25])
        print (sm5[26], sm5[27], sm5[28], sm5[29], sm5[30], sm5[31], sm5[32], sm5[33], sm5[34])
        print (sm5[35], sm5[36], sm5[37], sm5[38], sm5[39], sm5[40], sm5[41], sm5[42])
        print (sm5[43], sm5[44], sm5[45], sm5[46], sm5[47], sm5[48], sm5[49])
        print (sm5[50], sm5[51], sm5[52], sm5[53], sm5[54], sm5[55])
        print (sm5[56], sm5[57], sm5[58], sm5[59], sm5[60])
    }
}
