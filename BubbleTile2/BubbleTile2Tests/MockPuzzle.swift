//
//  MockPuzzle.swift
//  BubblePuzzleTests
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class MockPuzzle : IPuzzle {
    
    var m_Chips : Array<MockPuzzleChip>
    var m_ShaffleManager : ShaffleManager
    var m_UndoManager: UndoManager
    
    init() {
        m_Chips = Array<MockPuzzleChip>()
        m_ShaffleManager = ShaffleManager()
        m_UndoManager = UndoManager()
    }
    
    public func ShiftChips()
    {
        
    }
    
    public func MatchCheck()-> Bool
    {
        return true
    }

}
