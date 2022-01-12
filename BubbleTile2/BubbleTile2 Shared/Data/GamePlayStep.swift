//
//  GamePlayStep.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/6/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

public class GamePlayStep : Equatable {
    var m_Motion : enBubbleMotion
    var m_Direction : enMotionDirection
    var m_PositionIndex : Int

    init() {
        m_Motion = enBubbleMotion.BUBBLE_MOTION_NONE
        m_Direction = enMotionDirection.MOTION_DIRECTION_NONE
        m_PositionIndex = -1
    }

    init(motion move:enBubbleMotion, direction dir:enMotionDirection, index idx:Int) {
        m_Motion = move
        m_Direction = dir
        m_PositionIndex = idx
    }
    
    func Reverse()->GamePlayStep {
        let revDirection : enMotionDirection = m_Direction.Reverse()
        let newStep : GamePlayStep = GamePlayStep(motion:m_Motion, direction: revDirection, index: m_PositionIndex)
        return newStep
    }
    
    func IsValid()->Bool {
        if m_Motion == enBubbleMotion.BUBBLE_MOTION_NONE || m_Direction == enMotionDirection.MOTION_DIRECTION_NONE || m_PositionIndex < 0 {
            return false;
        }

        return true;
    }
}

extension GamePlayStep {
    public var motion : enBubbleMotion {
        get {
            return m_Motion
        }
        set (newValue) {
            m_Motion = newValue;
        }
    }
    
    public var direction : enMotionDirection {
        get {
            return m_Direction
        }
        set (newValue) {
            m_Direction = newValue;
        }
    }

    public var index : Int {
        get {
            return m_PositionIndex
        }
        set (newValue) {
            m_PositionIndex = newValue;
        }
    }

    //For Equatable 
    public static func == (lhs: GamePlayStep, rhs: GamePlayStep) -> Bool {
        let bRet : Bool = (lhs.motion == rhs.motion && lhs.direction == rhs.direction && lhs.index == rhs.index)
        return bRet
    }
}


typealias CUndoSteps = CStack<GamePlayStep>
typealias CShuffleSteps = CQueue<GamePlayStep>

