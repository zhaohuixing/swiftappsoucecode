///**
/**
Workspace:     PickerControl For SpriteKit
Project:     PickerControl For SpriteKit
Target:      PickerControl For SpriteKit
Package:     PickerControl For SpriteKit
File: 		SKPickerGestureRecognizer.swift

Created by: Zhaohui Xing on 5/5/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class SKPickerGestureRecognizer {
    private var m_GestureHost : SKPicker? = nil
    
    private var m_StartPoint : CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var m_EndPoint : CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var m_StartTime : TimeInterval = 0.0
    private var m_EndTime : TimeInterval = 0.0

    private var m_ItemsFastSpeed : Int = 15
    private var m_ItemsMediumSpeed : Int = 5
    private var m_AnimateMediumTime : CGFloat = 0.2
    private var m_AnimateFastTime : CGFloat = 0.1
    
    init(_ host: SKPicker) {
        m_GestureHost = host
        //registerGestures()
    }
    
    public var host : SKPicker {
        get {
            return m_GestureHost!
        }
    }
    
    public var rollingFast : Int {
        get {
            return m_ItemsFastSpeed
        }
        set(newValue) {
            m_ItemsFastSpeed = newValue
            if m_ItemsFastSpeed <= 0 {
                m_ItemsFastSpeed = 15
            }
        }
    }

    public var rollingMedium : Int {
        get {
            return m_ItemsMediumSpeed
        }
        set(newValue) {
            m_ItemsMediumSpeed = newValue
            if m_ItemsMediumSpeed <= 0 {
                m_ItemsMediumSpeed = 5
            }
        }
    }

    public var rollingTimeMedium : CGFloat {
        get {
            return m_AnimateMediumTime
        }
        set(newValue) {
            m_AnimateMediumTime = newValue
            if m_AnimateMediumTime <= 0.0 {
                m_AnimateMediumTime = 0.2
            }
        }
    }

    public var rollingTimeFast : CGFloat {
        get {
            return m_AnimateFastTime
        }
        set(newValue) {
            m_AnimateFastTime = newValue
            if m_AnimateFastTime <= 0.0 {
                m_AnimateFastTime = 0.1
            }
        }
    }
}

extension SKPickerGestureRecognizer {
    private func checkRollSpeed(velocity: CGFloat)->SKPickerSpeed {
        var speed : SKPickerSpeed = .slow
        
        switch velocity {
        case 0.0 ..< 500.0:
            speed = .slow
        case 500.0 ..< 2000.0:
            speed = .medium
        default:
            speed = .fast
        }
        
        return speed
    }
    
    private func rollPickerVerical() {
        let deltaY = m_EndPoint.y - m_StartPoint.y
        
        let volcity : CGFloat = abs(deltaY)/CGFloat(abs(m_EndTime - m_StartTime))
        
        NSLog("\(volcity)")
        
        let speed = checkRollSpeed(velocity: volcity)
        
        if speed == .medium || speed == .fast {
            return
        }
        
        let size = self.host.ItemSize()
        if size.height <= abs(deltaY) {
            if deltaY <= 0.0 {
                self.host.selection = self.host.selection-1
            }
            else {
                self.host.selection = self.host.selection+1
            }
            m_StartPoint = m_EndPoint
            //m_StartTime = m_EndTime
            return
        }
        let offset = abs(deltaY)/size.height
        if deltaY < 0.0 {
            if self.host.canRollDescend {
                self.host.Rolling(offset: offset, direction: .descend)
            }
        }
        else {
            if self.host.canRollAscend {
                self.host.Rolling(offset: offset, direction: .ascend)
            }
        }
    }
    
    private func rollPickerHorizontal() {
        let deltaX = m_EndPoint.x - m_StartPoint.x

        let volcity : CGFloat = abs(deltaX)/CGFloat(abs(m_EndTime - m_StartTime))

        NSLog("\(volcity)")

        let speed = checkRollSpeed(velocity: volcity)
        
        if speed == .medium || speed == .fast {
            return
        }

        let size = self.host.ItemSize()
        if size.width <= abs(deltaX) {
            if deltaX < 0.0 {
                self.host.selection = self.host.selection+1
            }
            else {
                self.host.selection = self.host.selection-1
            }
            m_StartPoint = m_EndPoint
            //m_StartTime = m_EndTime
            return
        }
        let offset = abs(deltaX)/size.width
        if deltaX < 0.0 {
            if self.host.canRollAscend {
                self.host.Rolling(offset: offset, direction: .ascend)
            }
        }
        else {
            if self.host.canRollDescend {
                self.host.Rolling(offset: offset, direction: .descend)
            }
        }
    }

    private func rollPicker() {
        if self.host.layout == .veritcal {
            rollPickerVerical()
        }
        else {
            rollPickerHorizontal()
        }
    }

    private func stopRollVerical()
    {
        let deltaY = m_EndPoint.y - m_StartPoint.y
        
        let volcity : CGFloat = abs(deltaY)/CGFloat(abs(m_EndTime - m_StartTime))
        
        let speed = checkRollSpeed(velocity: volcity)
        
        if speed == .medium {
            if 0 < deltaY {
                self.host.AnimateItems(items: m_ItemsMediumSpeed, speed: m_AnimateMediumTime, direction: .ascend)
            }
            else {
                self.host.AnimateItems(items: m_ItemsMediumSpeed, speed: m_AnimateMediumTime, direction: .descend)
            }
            return
        }
        if speed == .fast {
            if 0 < deltaY {
                self.host.AnimateItems(items: m_ItemsFastSpeed, speed: m_AnimateFastTime, direction: .ascend)
            }
            else {
                self.host.AnimateItems(items: m_ItemsFastSpeed, speed: m_AnimateFastTime, direction: .descend)
            }
            return
        }
        
        let size = self.host.ItemSize()
        if size.height*0.5 <= abs(deltaY) {
            if deltaY <= 0.0 {
                self.host.selection = self.host.selection-1
            }
            else {
                self.host.selection = self.host.selection+1
            }
        }
        else {
            self.host.selection = self.host.selection
        }
        self.host.rollingCompleted()
    }
    
    private func stopRollHorizontal()
    {
        let deltaX = m_EndPoint.x - m_StartPoint.x
        
        let volcity : CGFloat = abs(deltaX)/CGFloat(abs(m_EndTime - m_StartTime))
        
        let speed = checkRollSpeed(velocity: volcity)
        
        if speed == .medium {
            if deltaX < 0.0 {
                self.host.AnimateItems(items: m_ItemsMediumSpeed, speed: m_AnimateMediumTime, direction: .ascend)
            }
            else {
                self.host.AnimateItems(items: m_ItemsMediumSpeed, speed: m_AnimateMediumTime, direction: .descend)
            }
            return
        }
        if speed == .fast {
            if deltaX < 0.0 {
                self.host.AnimateItems(items: m_ItemsFastSpeed, speed: m_AnimateFastTime, direction: .ascend)
            }
            else {
                self.host.AnimateItems(items: m_ItemsFastSpeed, speed: m_AnimateFastTime, direction: .descend)
            }
            return
        }
        
        let size = self.host.ItemSize()
        if size.width*0.5 <= abs(deltaX) {
            if deltaX <= 0.0 {
                self.host.selection = self.host.selection+1
            }
            else {
                self.host.selection = self.host.selection-1
            }
        }
        else {
            self.host.selection = self.host.selection
        }
        self.host.rollingCompleted()
    }
    
    private func stopRolling() {
        if self.host.layout == .veritcal {
            stopRollVerical()
        }
        else {
            stopRollHorizontal()
        }
    }
}

extension SKPickerGestureRecognizer {
    public func start(point: CGPoint, time:TimeInterval) {
        m_StartPoint = point
        m_StartTime = time
    }

    public func move(point: CGPoint, time:TimeInterval) {
        m_EndPoint = point
        m_EndTime = time
        rollPicker()
    }

    public func stop(point: CGPoint, time:TimeInterval) {
        m_EndPoint = point
        m_EndTime = time
        stopRolling()
    }
}
