//
//  TrianglePuzzleShaffleTests.swift
//  BubblePuzzle
//
//  Created by Zhaohui Xing on 2/12/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class TrianglePuzzleShaffleTests: XCTestCase {

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

    func testTriangleMatrixShaffle5() {
        let sm7 : Puzzle = Puzzle()
        sm7.Initialize(enGridType.PUZZLE_GRID_TRIANGLE, enGridLayout.PUZZLE_LALOUT_MATRIX, 7)
        
        print (sm7.number)
        
        let dl7 : ChipList = sm7.chips
        print (dl7.count)

        XCTAssert (sm7.number == dl7.count)
        
        print (dl7[0].GetData())
        print (dl7[1].GetData(), dl7[2].GetData())
        print (dl7[3].GetData(), dl7[4].GetData(), dl7[5].GetData())
        print (dl7[6].GetData(), dl7[7].GetData(), dl7[8].GetData(), dl7[9].GetData())
        print (dl7[10].GetData(), dl7[11].GetData(), dl7[12].GetData(), dl7[13].GetData(), dl7[14].GetData())
        print (dl7[15].GetData(), dl7[16].GetData(), dl7[17].GetData(), dl7[18].GetData(), dl7[19].GetData(), dl7[20].GetData())
        print (dl7[21].GetData(), dl7[22].GetData(), dl7[23].GetData(), dl7[24].GetData(), dl7[25].GetData(), dl7[26].GetData(), dl7[27].GetData())

        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm7.edge)
        print(shaffler.Steps())
        
        while !shaffler.Empty() {
            let step : GamePlayStep? = shaffler.GetStep()
            print(step!.index, step!.direction, step!.motion)
        }
        
        print(shaffler.Steps())

        while shaffler.HasUndoStep() {
            let undostep : GamePlayStep? = shaffler.PeekUndoStep()
            print(undostep!.index, undostep!.direction, undostep!.motion)
        }
    }
    
    func testTriangleSnakeShaffle5() {
        let sm7 : Puzzle = Puzzle()
        sm7.Initialize(enGridType.PUZZLE_GRID_TRIANGLE, enGridLayout.PUZZLE_LALOUT_SNAKE, 7)
        print (sm7.number)
        
        let dl7 : ChipList = sm7.chips
        print (dl7.count)

        XCTAssert (sm7.number == dl7.count)
        
        print (dl7[0].GetData())
        print (dl7[1].GetData(), dl7[2].GetData())
        print (dl7[3].GetData(), dl7[4].GetData(), dl7[5].GetData())
        print (dl7[6].GetData(), dl7[7].GetData(), dl7[8].GetData(), dl7[9].GetData())
        print (dl7[10].GetData(), dl7[11].GetData(), dl7[12].GetData(), dl7[13].GetData(), dl7[14].GetData())
        print (dl7[15].GetData(), dl7[16].GetData(), dl7[17].GetData(), dl7[18].GetData(), dl7[19].GetData(), dl7[20].GetData())
        print (dl7[21].GetData(), dl7[22].GetData(), dl7[23].GetData(), dl7[24].GetData(), dl7[25].GetData(), dl7[26].GetData(), dl7[27].GetData())

        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm7.edge)
        print(shaffler.Steps())
        
        while !shaffler.Empty() {
            let step : GamePlayStep? = shaffler.GetStep()
            print(step!.index, step!.direction, step!.motion)
        }
        
        print(shaffler.Steps())

        while shaffler.HasUndoStep() {
            let undostep : GamePlayStep? = shaffler.PeekUndoStep()
            print(undostep!.index, undostep!.direction, undostep!.motion)
        }
    }
    
    func testTriangleSpiralShaffle5() {
        let sm7 : Puzzle = Puzzle()
        sm7.Initialize(enGridType.PUZZLE_GRID_TRIANGLE, enGridLayout.PUZZLE_LALOUT_SPIRAL, 7)
        print (sm7.number)
        
        let dl7 : ChipList = sm7.chips
        print (dl7.count)

        XCTAssert (sm7.number == dl7.count)
        
        print (dl7[0].GetData())
        print (dl7[1].GetData(), dl7[2].GetData())
        print (dl7[3].GetData(), dl7[4].GetData(), dl7[5].GetData())
        print (dl7[6].GetData(), dl7[7].GetData(), dl7[8].GetData(), dl7[9].GetData())
        print (dl7[10].GetData(), dl7[11].GetData(), dl7[12].GetData(), dl7[13].GetData(), dl7[14].GetData())
        print (dl7[15].GetData(), dl7[16].GetData(), dl7[17].GetData(), dl7[18].GetData(), dl7[19].GetData(), dl7[20].GetData())
        print (dl7[21].GetData(), dl7[22].GetData(), dl7[23].GetData(), dl7[24].GetData(), dl7[25].GetData(), dl7[26].GetData(), dl7[27].GetData())

        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm7.edge)
        print(shaffler.Steps())
        
        while !shaffler.Empty() {
            let step : GamePlayStep? = shaffler.GetStep()
            print(step!.index, step!.direction, step!.motion)
        }
        print(shaffler.Steps())

        while shaffler.HasUndoStep() {
            let undostep : GamePlayStep? = shaffler.PeekUndoStep()
            print(undostep!.index, undostep!.direction, undostep!.motion)
        }
    }

}
