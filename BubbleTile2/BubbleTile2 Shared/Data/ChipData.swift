//
//  ChipData.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/12/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class ChipData {
    var m_RealPositionIndex : Int
    var m_LabelIndex : Int
    var m_GenericIndex : Int
    init() {
        m_RealPositionIndex = -1
        m_LabelIndex = -1
        m_GenericIndex = -1
    }
    
    public init(_ gIndex : Int, _ rIndex : Int, _ lIndex : Int) {
        m_RealPositionIndex = rIndex
        m_LabelIndex = lIndex
        m_GenericIndex = gIndex
    }

    public func IsMatch() -> Bool {
        let bRet : Bool = (m_RealPositionIndex == m_GenericIndex)
        return bRet
    }
    
    public func GetData()->(Int, Int, Int) {
        return (m_GenericIndex, m_RealPositionIndex, m_LabelIndex)
    }
}

extension ChipData {
    public var realindex : Int {
        get {
            return m_RealPositionIndex
        }
        set (newValue) {
            m_RealPositionIndex = newValue;
        }
    }

    public var labelindex : Int {
        get {
            return m_LabelIndex
        }
        set (newValue) {
            m_LabelIndex = newValue;
        }
    }

    public var genericindex : Int {
        get {
            return m_GenericIndex
        }
        set (newValue) {
            m_GenericIndex = newValue;
        }
    }
}

typealias ChipList = Array<ChipData> 
