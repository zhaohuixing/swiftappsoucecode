//
//  HexagonPuzzleShaffleTests.swift
//  BubblePuzzle
//
//  Created by Zhaohui Xing on 2/12/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import XCTest

class HexagonPuzzleShaffleTests: XCTestCase {

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

    func testHexagonMatrixShaffle5() {
        let sm5 : Puzzle = Puzzle()
        sm5.Initialize(enGridType.PUZZLE_GRID_HEXAGON, enGridLayout.PUZZLE_LALOUT_MATRIX, 5)
        
        print (sm5.number)
        
        let dl5 : ChipList = sm5.chips
        print (dl5.count)

        XCTAssert (sm5.number == dl5.count)
        
        print (dl5[0].GetData(),  dl5[1].GetData(),  dl5[2].GetData(),  dl5[3].GetData(),  dl5[4].GetData())
        print (dl5[5].GetData(),  dl5[6].GetData(),  dl5[7].GetData(),  dl5[8].GetData(),  dl5[9].GetData(), dl5[10].GetData())
        print (dl5[11].GetData(), dl5[12].GetData(), dl5[13].GetData(), dl5[14].GetData(), dl5[15].GetData(), dl5[16].GetData(), dl5[17].GetData())
        print (dl5[18].GetData(), dl5[19].GetData(), dl5[20].GetData(), dl5[21].GetData(), dl5[22].GetData(), dl5[23].GetData(), dl5[24].GetData(), dl5[25].GetData())
        print (dl5[26].GetData(), dl5[27].GetData(), dl5[28].GetData(), dl5[29].GetData(), dl5[30].GetData(), dl5[31].GetData(), dl5[32].GetData(), dl5[33].GetData(), dl5[34].GetData())
        print (dl5[35].GetData(), dl5[36].GetData(), dl5[37].GetData(), dl5[38].GetData(), dl5[39].GetData(), dl5[40].GetData(), dl5[41].GetData(), dl5[42].GetData())
        print (dl5[43].GetData(), dl5[44].GetData(), dl5[45].GetData(), dl5[46].GetData(), dl5[47].GetData(), dl5[48].GetData(), dl5[49].GetData())
        print (dl5[50].GetData(), dl5[51].GetData(), dl5[52].GetData(), dl5[53].GetData(), dl5[54].GetData(), dl5[55].GetData())
        print (dl5[56].GetData(), dl5[57].GetData(), dl5[58].GetData(), dl5[59].GetData(), dl5[60].GetData())
        
        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm5.edge)
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
    
    func testHexagonSnakeShaffle5() {
        let sm5 : Puzzle = Puzzle()
        sm5.Initialize(enGridType.PUZZLE_GRID_HEXAGON, enGridLayout.PUZZLE_LALOUT_SNAKE, 5)
        print (sm5.number)
        
        let dl5 : ChipList = sm5.chips
        print (dl5.count)

        XCTAssert (sm5.number == dl5.count)
        
        print (dl5[0].GetData(),  dl5[1].GetData(),  dl5[2].GetData(),  dl5[3].GetData(),  dl5[4].GetData())
        print (dl5[5].GetData(),  dl5[6].GetData(),  dl5[7].GetData(),  dl5[8].GetData(),  dl5[9].GetData(), dl5[10].GetData())
        print (dl5[11].GetData(), dl5[12].GetData(), dl5[13].GetData(), dl5[14].GetData(), dl5[15].GetData(), dl5[16].GetData(), dl5[17].GetData())
        print (dl5[18].GetData(), dl5[19].GetData(), dl5[20].GetData(), dl5[21].GetData(), dl5[22].GetData(), dl5[23].GetData(), dl5[24].GetData(), dl5[25].GetData())
        print (dl5[26].GetData(), dl5[27].GetData(), dl5[28].GetData(), dl5[29].GetData(), dl5[30].GetData(), dl5[31].GetData(), dl5[32].GetData(), dl5[33].GetData(), dl5[34].GetData())
        print (dl5[35].GetData(), dl5[36].GetData(), dl5[37].GetData(), dl5[38].GetData(), dl5[39].GetData(), dl5[40].GetData(), dl5[41].GetData(), dl5[42].GetData())
        print (dl5[43].GetData(), dl5[44].GetData(), dl5[45].GetData(), dl5[46].GetData(), dl5[47].GetData(), dl5[48].GetData(), dl5[49].GetData())
        print (dl5[50].GetData(), dl5[51].GetData(), dl5[52].GetData(), dl5[53].GetData(), dl5[54].GetData(), dl5[55].GetData())
        print (dl5[56].GetData(), dl5[57].GetData(), dl5[58].GetData(), dl5[59].GetData(), dl5[60].GetData())

        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm5.edge)
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
    
    func testHexagonSpiralShaffle5() {
        let sm5 : Puzzle = Puzzle()
        sm5.Initialize(enGridType.PUZZLE_GRID_HEXAGON, enGridLayout.PUZZLE_LALOUT_SPIRAL, 5)
        print (sm5.number)
        
        let dl5 : ChipList = sm5.chips
        print (dl5.count)

        XCTAssert (sm5.number == dl5.count)
        
        print (dl5[0].GetData(),  dl5[1].GetData(),  dl5[2].GetData(),  dl5[3].GetData(),  dl5[4].GetData())
        print (dl5[5].GetData(),  dl5[6].GetData(),  dl5[7].GetData(),  dl5[8].GetData(),  dl5[9].GetData(), dl5[10].GetData())
        print (dl5[11].GetData(), dl5[12].GetData(), dl5[13].GetData(), dl5[14].GetData(), dl5[15].GetData(), dl5[16].GetData(), dl5[17].GetData())
        print (dl5[18].GetData(), dl5[19].GetData(), dl5[20].GetData(), dl5[21].GetData(), dl5[22].GetData(), dl5[23].GetData(), dl5[24].GetData(), dl5[25].GetData())
        print (dl5[26].GetData(), dl5[27].GetData(), dl5[28].GetData(), dl5[29].GetData(), dl5[30].GetData(), dl5[31].GetData(), dl5[32].GetData(), dl5[33].GetData(), dl5[34].GetData())
        print (dl5[35].GetData(), dl5[36].GetData(), dl5[37].GetData(), dl5[38].GetData(), dl5[39].GetData(), dl5[40].GetData(), dl5[41].GetData(), dl5[42].GetData())
        print (dl5[43].GetData(), dl5[44].GetData(), dl5[45].GetData(), dl5[46].GetData(), dl5[47].GetData(), dl5[48].GetData(), dl5[49].GetData())
        print (dl5[50].GetData(), dl5[51].GetData(), dl5[52].GetData(), dl5[53].GetData(), dl5[54].GetData(), dl5[55].GetData())
        print (dl5[56].GetData(), dl5[57].GetData(), dl5[58].GetData(), dl5[59].GetData(), dl5[60].GetData())

        let shaffler : ShaffleManager = ShaffleManager()
        shaffler.ShaffleEasyLevel(type: enGridType.PUZZLE_GRID_HEXAGON, edge: sm5.edge)
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
