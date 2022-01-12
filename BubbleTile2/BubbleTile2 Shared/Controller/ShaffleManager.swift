//
//  ShaffleManager.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/12/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class ShaffleManager {
    var m_StepsQueue : CQueue<GamePlayStep>
    var m_RestoreSteps : Array<GamePlayStep>
    var m_nRestoreStepCursor : Int
    var m_nCachedIndex : Int
    var m_nCount : Int
    var m_nEdge : Int
    var m_GridType : enGridType
    
    init() {
        m_StepsQueue = CQueue<GamePlayStep>()
        m_RestoreSteps = Array<GamePlayStep>()
        m_nRestoreStepCursor = -1
        m_nCachedIndex = -1;
        m_nCount = -1
        m_nEdge = 0
        m_GridType = enGridType.PUZZLE_GRID_SQUARE
    }
    
    public func AddStep(_ step : GamePlayStep) {
        let undoStep = step.Reverse()
        m_StepsQueue.Push_Back(value: step)
        m_RestoreSteps.append(undoStep)
        m_nRestoreStepCursor += 1
    }

    public func GetStep()-> GamePlayStep? {
        return m_StepsQueue.Pop_Front()
    }

    public func UndeStepCount()->Int {
        return m_RestoreSteps.count
    }

    public func UndoStep(index: Int)-> GamePlayStep? {
        guard  index >= 0 && index < m_RestoreSteps.count else {
            return nil
        }
        
        return m_RestoreSteps[index]
    }
    
    public func PeekUndoStep()-> GamePlayStep? {
        guard  m_nRestoreStepCursor >= 0 else {
            return nil
        }
        
        let step = m_RestoreSteps[m_nRestoreStepCursor]
        m_nRestoreStepCursor -= 1
        return step
    }

    public func HasUndoStep()-> Bool {
        if m_nRestoreStepCursor >= 0 {
            return true
        }
        else  {
            return false
        }
    }
    
    public func ResetUndoSteps() {
        m_nRestoreStepCursor = m_RestoreSteps.count - 1
    }
    
    public func Empty()-> Bool {
        return m_StepsQueue.Empty()
    }

    public func Steps()-> Int {
        return m_StepsQueue.Count()
    }

    public func Reset() {
        //if !m_StepsQueue.Empty() {
            //m_StepsQueue = CQueue<GamePlayStep>()
            m_StepsQueue.Clear()
        //}
        //if m_RestoreSteps.count > 0{
            m_RestoreSteps.removeAll()
        //}
        m_nRestoreStepCursor = -1

        m_nCachedIndex = -1;
        m_nCount = -1
        m_nEdge = 0
    }
    
    private func CreateSteps()->Int {
        let nRand : Int = Int(arc4random_uniform(UInt32.max)) //Correct way of type conversion

        let nThreshold : Int = (m_nCount < 10) ? m_nCount*3 : 30
        var nSteps : Int = nRand%nThreshold+1;
        if nSteps == 0 {
            nSteps = nThreshold/2;
        }
        return nSteps
    }

    private func CreateEasyStep()->GamePlayStep {

        //let nRand : Int = (Int)arc4random_uniform(UInt32.max) //Not compilable in swift since not calling Int type object initializer, since type conversion in swift is creating a new object of converted type
        let nRand : Int = Int(arc4random_uniform(UInt32.max)) //Correct way of type conversion
        
        var nIndex : Int = nRand % m_nCount
        if m_nCachedIndex == nIndex {
            nIndex = (nIndex+1)%m_nCount
        }
        m_nCachedIndex = nIndex
        
        var nDirect : enMotionDirection? = enMotionDirection(rawValue: (nRand%3))
        if nDirect == enMotionDirection.MOTION_DIRECTION_NONE {
            nDirect = enMotionDirection.MOTION_DIRECTION_BACKWARD
        }
        
        var nMotion : enBubbleMotion?
        switch m_GridType {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                nMotion = enBubbleMotion(rawValue: nRand%4)
                if nMotion == enBubbleMotion.BUBBLE_MOTION_NONE {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_120DIAGONAL;
                }
                else if nMotion == enBubbleMotion.BUBBLE_MOTION_VERTICAL {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_60DIAGONAL;
                }
            case enGridType.PUZZLE_GRID_SQUARE:
                nMotion = enBubbleMotion(rawValue: nRand%3)
                if nMotion == enBubbleMotion.BUBBLE_MOTION_NONE {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_VERTICAL;
                }
            case enGridType.PUZZLE_GRID_DIAMOND:
                nMotion = enBubbleMotion(rawValue: nRand%4)
                if nMotion == enBubbleMotion.BUBBLE_MOTION_NONE {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_120DIAGONAL
                }
                else if nMotion == enBubbleMotion.BUBBLE_MOTION_VERTICAL {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_60DIAGONAL;
            }
            case enGridType.PUZZLE_GRID_HEXAGON:
                nMotion = enBubbleMotion(rawValue: nRand%4)
                if nMotion == enBubbleMotion.BUBBLE_MOTION_NONE {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_120DIAGONAL;
                }
                else if nMotion == enBubbleMotion.BUBBLE_MOTION_VERTICAL {
                    nMotion = enBubbleMotion.BUBBLE_MOTION_60DIAGONAL;
            }
        }

        let step : GamePlayStep = GamePlayStep(motion: nMotion!, direction: nDirect!, index: nIndex)

        return step
    }
    
    public func ShaffleEasyLevel(type gridType : enGridType, edge nEdge : Int) {
        Reset()
        m_GridType = gridType
        m_nEdge = nEdge
        m_nCount = PuzzleHelper.GetPuzzleBubbleCount(type: m_GridType, edge:m_nEdge)
        let nSteps = CreateSteps()
        for _ in 0 ... (nSteps-1) {
            AddStep(CreateEasyStep())
        }
    }

    public func ShaffleDifficultLevel(type gridType : enGridType, edge nEdge : Int) {
        Reset()
        m_GridType = gridType
        m_nEdge = nEdge
        m_nCount = PuzzleHelper.GetPuzzleBubbleCount(type: m_GridType, edge:m_nEdge)

    }
}
