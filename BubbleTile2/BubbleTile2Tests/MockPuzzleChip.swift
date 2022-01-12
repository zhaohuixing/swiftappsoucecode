//
//  MockPuzzleChip.swift
//  BubblePuzzleTests
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class MockPuzzleChip : IPuzzleChip {
    var m_Data : ChipData
    
    init() {
        m_Data = ChipData()
    }
    
    public init(_ gIndex : Int, _ rIndex : Int, _ lIndex : Int) {
        m_Data = ChipData(gIndex, rIndex, lIndex)
    }

    public func GetData()->ChipData {
        return m_Data
    }
    
    public func IsMatch()->Bool {
        return m_Data.IsMatch()
    }
    
    public func MoveTo(index realIndex: Int) {
        m_Data.realindex = realIndex
    }

    public func GetRealIndex()->Int {
        return m_Data.realindex;
    }
    
    public func GetLabel()->Int {
        return m_Data.labelindex
    }
    
    public func GetGenericIndex()->Int {
        return m_Data.genericindex
    }

}
