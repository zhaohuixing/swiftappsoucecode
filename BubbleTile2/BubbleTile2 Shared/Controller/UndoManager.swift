//
//  UndoManager.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/6/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class UndoManager {
    var m_StepsStack : CStack<GamePlayStep>
    
    init() {
        m_StepsStack = CStack<GamePlayStep>()
    }

    public func AddStep(_ step : GamePlayStep) {
        m_StepsStack.Push(value: step)
    }
    
    public func GetStep()-> GamePlayStep? {
        return m_StepsStack.Pop()
    }
    
    public func Empty()-> Bool {
        return m_StepsStack.Empty()
    }
    
    public func Count()-> Int {
        return m_StepsStack.Count()
    }

    public func Reset() {
        while !m_StepsStack.Empty() {
            let _ = m_StepsStack.Pop()
        }
    }
}
