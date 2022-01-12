///**
/**
Workspace:     PickerControl For SpriteKit
Project: 	PickerControl For SpriteKit
Target:  	PickerControl For SpriteKit
Package: 	PickerControl For SpriteKit
File: 		SKPicker.swift

Created by: Zhaohui Xing on 5/1/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

protocol SKPickerHost {
    func notifyCompletion(sender: SKPicker)
}

class SKPicker: SKSpriteNode {
    private var m_Layout : SKPickerLayout = .veritcal
    private var m_DisplayItems : Int = 3
    private var m_nSelectedItem : Int = -1

    private var m_nOneItemAnimateSteps = 10
    private var m_CanAnimation : Bool = true
    private var m_GestureHandler : SKPickerGestureRecognizer? = nil
    
    private var m_Host : SKPickerHost? = nil
    
    public var layout : SKPickerLayout {
        get {
            return m_Layout
        }
        set (newValue) {
            m_Layout = newValue
        }
    }

    public var displayItems : Int {
        get {
            return m_DisplayItems
        }
        set (newValue) {
            m_DisplayItems = newValue
            if m_DisplayItems%2 == 0 {
                m_DisplayItems = m_DisplayItems+1
            }
        }
    }

    public var selection : Int {
        get {
            return m_nSelectedItem
        }
        set (newValue) {
            m_nSelectedItem = newValue
            if m_nSelectedItem < 0 {
                m_nSelectedItem = 0
            }
            let itemLast : Int = ItemCount()-1
            if itemLast < m_nSelectedItem {
                m_nSelectedItem = itemLast
            }
            SetSelection()
        }
    }
    
    public var itemSteps : Int {
        get {
            return m_nOneItemAnimateSteps
        }
        set(newValue) {
            m_nOneItemAnimateSteps = newValue
        }
    }
    
    public var canAnimation : Bool {
        get {
            return m_CanAnimation
        }
    }
    
    public var gestureHandler : SKPickerGestureRecognizer! {
        get {
            if m_GestureHandler == nil {
                m_GestureHandler = SKPickerGestureRecognizer(self)
            }
            return m_GestureHandler!
        }
    }
    
    public var canRollAscend : Bool {
        get {
            return (m_nSelectedItem < ItemCount()-1)
        }
    }

    public var canRollDescend : Bool {
        get {
            return (0 < m_nSelectedItem)
        }
    }
}

extension SKPicker  {
    private func SetSelection() {
        let itemCount : Int = ItemCount()
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }
        
        SetZeroDemensionItems(start: startShowItem, end: endShowItem)
        self.children[m_nSelectedItem].position = CGPoint(x:0.0, y:0.0)
        self.children[m_nSelectedItem].xScale = 1.0
        self.children[m_nSelectedItem].yScale = 1.0
        self.children[m_nSelectedItem].zPosition = 1.0
        SetTransitionItems(start: startShowItem, end: endShowItem)
    }

    private func SetZeroDemensionItems(start: Int, end: Int) {
        var zeroPosition : CGPoint = CGPoint(x: 0.0, y: self.size.height/2.0)
        var zeroXScale : CGFloat = 1.0
        var zeroYScale : CGFloat = 0.00001
        if m_Layout == .horizontal {
            zeroPosition.x = self.size.width/2.0
            zeroPosition.y = 0.0
            zeroXScale = 0.00001
            zeroYScale = 1.0
        }
        
        if 0 < start {
            for i in 0 ... (start-1) {
                self.children[i].position = zeroPosition
                self.children[i].xScale = zeroXScale
                self.children[i].yScale = zeroYScale
                self.children[i].zPosition = -1.0
            }
        }
        
        let itemLast : Int = ItemCount()-1
        zeroPosition = CGPoint(x: 0.0, y: -self.size.height/2.0)
        if m_Layout == .horizontal {
            zeroPosition.x = -self.size.width/2.0
            zeroPosition.y = 0.0
        }

        if end < itemLast {
            for i in (end+1) ... itemLast {
                self.children[i].position = zeroPosition
                self.children[i].xScale = zeroXScale
                self.children[i].yScale = zeroYScale
                self.children[i].zPosition = -1.0
            }
        }
    }

    private func SetTransitionItems(start: Int, end: Int) {
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var stdSize = ItemSize().height
        if m_Layout == .horizontal {
            stdSize = ItemSize().width
        }
        
        for i in 0 ... nonSelectedShowItems-1 {
            let transit = transition(step: i)
            let prevIndex = m_nSelectedItem - nonSelectedShowItems+i
            
            if start <= prevIndex && prevIndex < m_nSelectedItem {
                if m_Layout == .veritcal {
                    self.children[prevIndex].position.y = transit.1
                    self.children[prevIndex].yScale = transit.0/stdSize
                    self.children[prevIndex].xScale = 1.0
                }
                else {
                    self.children[prevIndex].position.x = -transit.1
                    self.children[prevIndex].xScale = transit.0/stdSize
                    self.children[prevIndex].yScale = 1.0
                }
                self.children[prevIndex].zPosition = 1.0
            }
            let nextIndex = m_nSelectedItem + nonSelectedShowItems-i
            if m_nSelectedItem < nextIndex && nextIndex <= end {
                if m_Layout == .veritcal {
                    self.children[nextIndex].position.y = -transit.1
                    self.children[nextIndex].yScale = transit.0/stdSize
                    self.children[nextIndex].xScale = 1.0
                }
                else {
                    self.children[nextIndex].position.x = transit.1
                    self.children[nextIndex].xScale = transit.0/stdSize
                    self.children[nextIndex].yScale = 1.0
                }
                self.children[nextIndex].zPosition = 1.0
            }
        }
    }

    private func transition(step: Int)-> (CGFloat, CGFloat) {
        var fSize : CGFloat = 0.0
        var fDistance : CGFloat = 0.0
        let startAngle = offsetAngle(step : (step-1))
        let endAngle = offsetAngle(step : step)
        let fradius = radius()
        fSize = fradius*(sin(startAngle) - sin(endAngle))
        fDistance = fradius*sin(endAngle) + fSize*0.5
        return (fSize, fDistance)
    }

    private func transitionWithOffset(step: Int, offset: CGFloat)-> (CGFloat, CGFloat) {
        var fSize : CGFloat = 0.0
        var fDistance : CGFloat = 0.0
        var startAngle = offsetAngle(step : (step-1))
        startAngle = startAngle+offset
        if CGFloat.pi*0.5 < startAngle {
            startAngle = CGFloat.pi*0.5
        }
        
        let endAngle = offsetAngle(step : step) + offset
        let fradius = radius()
        fSize = fradius*(sin(startAngle) - sin(endAngle))
        fDistance = fradius*sin(endAngle) + fSize*0.5
        return (fSize, fDistance)
    }

    private func baseRollAngle()-> CGFloat {
        let dividor : CGFloat = CGFloat(m_DisplayItems)
        let baseAngle : CGFloat = CGFloat.pi/dividor //=(180.0/dividor)*CGFloat.pi/180.0
        return baseAngle
    }

    private func offsetAngle(step : Int)-> CGFloat {
        let baseAngle : CGFloat = baseRollAngle() //=(180.0/dividor)*CGFloat.pi/180.0
        let angle : CGFloat = (CGFloat.pi*0.5)-(baseAngle)*CGFloat(step+1)
        return angle
    }

    private func radius()-> CGFloat {
        var radius = self.size.height*0.5
        if m_Layout == .horizontal {
            radius = self.size.width*0.5
        }
        return radius
    }
    
    private func RunAnimateOneItemAscend(time:CGFloat, index:Int, start:Int, end:Int) {
        if m_nOneItemAnimateSteps <= index {
            self.selection = m_nSelectedItem + 1
            rollingCompleted()
            return
        }
        
        let dAnimateStepAngle : CGFloat = baseRollAngle()/CGFloat(m_nOneItemAnimateSteps)
        self.run(SKAction.wait(forDuration: TimeInterval(time))) {
            self.MoveItemsAscend(angle:dAnimateStepAngle*CGFloat(index+1), start:start, end:end)
            self.RunAnimateOneItemAscend(time:time, index:(index+1), start:start, end:end)
        }
    }
    
    private func MoveItemsAscend(angle:CGFloat, start:Int, end:Int) {
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        let fradius = radius()
        let halfBaseAngle = baseRollAngle()*0.5
        var stdSize = ItemSize().height
        if m_Layout == .horizontal {
            stdSize = ItemSize().width
        }

        for i in 0 ... nonSelectedShowItems-1 {
            let prevIndex = m_nSelectedItem - nonSelectedShowItems+i
            if start <= prevIndex && prevIndex < m_nSelectedItem {
                let transit = transitionWithOffset(step: i, offset:angle)
                
                if m_Layout == .veritcal {
                    self.children[prevIndex].position.y = transit.1
                    self.children[prevIndex].yScale = transit.0/stdSize
                    self.children[prevIndex].xScale = 1.0
                }
                else {
                    self.children[prevIndex].position.x = -transit.1
                    self.children[prevIndex].xScale = transit.0/stdSize
                    self.children[prevIndex].yScale = 1.0
                }
                self.children[prevIndex].zPosition = 1.0
            }
            let nextIndex = m_nSelectedItem + nonSelectedShowItems-i
            if m_nSelectedItem < nextIndex && nextIndex <= end {
                //let transit = transitionWithOffsetReverse(step: i, offset:angle)
                let transit = transitionWithOffset(step: i, offset:-angle)
                if m_Layout == .veritcal {
                    self.children[nextIndex].position.y = -transit.1
                    self.children[nextIndex].yScale =  transit.0/stdSize
                    self.children[nextIndex].xScale = 1.0
                }
                else {
                    self.children[nextIndex].position.x =  transit.1
                    self.children[nextIndex].xScale = transit.0/stdSize
                    self.children[nextIndex].yScale = 1.0
                }
                self.children[nextIndex].zPosition = 1.0
            }
        }

        let startAngle = (halfBaseAngle+angle)
        let endAngle = (-halfBaseAngle+angle)
        let fSize = fradius*(sin(startAngle) - sin(endAngle))
        let fDistance = fradius*sin(endAngle) + fSize*0.5
        if m_Layout == .veritcal {
            self.children[m_nSelectedItem].position.y = fDistance
            self.children[m_nSelectedItem].xScale = 1.0
            self.children[m_nSelectedItem].yScale = fSize/stdSize
        }
        else {
            self.children[m_nSelectedItem].position.x = -fDistance
            self.children[m_nSelectedItem].xScale = fSize/stdSize
            self.children[m_nSelectedItem].yScale = 1.0
        }
        self.children[m_nSelectedItem].zPosition = 1.0

        if end < ItemCount()-1 {
            let i = end+1
            let startAngle = -(CGFloat.pi*0.5)
            let endAngle = -(CGFloat.pi*0.5-angle)
            let fSize = fradius*(sin(endAngle) - sin(startAngle))
            let fDistance = (fradius*sin(endAngle) - fSize*0.5)

            if m_Layout == .veritcal {
                self.children[i].position.y = fDistance
                self.children[i].yScale = fSize/stdSize
                self.children[i].xScale = 1.0
            }
            else {
                self.children[i].position.x = -fDistance
                self.children[i].xScale = fSize/stdSize
                self.children[i].yScale = 1.0
            }
            self.children[i].zPosition = 1.0

        }
    }
    
    private func RunAnimateOneItemDescend(time:CGFloat, index:Int, start:Int, end:Int) {
        if m_nOneItemAnimateSteps <= index {
            self.selection = m_nSelectedItem - 1
            rollingCompleted()
            return
        }
        
        let dAnimateStepAngle : CGFloat = baseRollAngle()/CGFloat(m_nOneItemAnimateSteps)
        self.run(SKAction.wait(forDuration: TimeInterval(time))) {
            self.MoveItemsDescend(angle:dAnimateStepAngle*CGFloat(index+1), start:start, end:end)
            self.RunAnimateOneItemDescend(time:time, index:(index+1), start:start, end:end)
        }
    }

    private func MoveItemsDescend(angle:CGFloat, start:Int, end:Int) {
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        let fradius = radius()
        let halfBaseAngle = baseRollAngle()*0.5
        var stdSize = ItemSize().height
        if m_Layout == .horizontal {
            stdSize = ItemSize().width
        }

        for i in 0 ... nonSelectedShowItems-1 {
            let prevIndex = m_nSelectedItem - nonSelectedShowItems+i
            if start <= prevIndex && prevIndex < m_nSelectedItem {
                let transit = transitionWithOffset(step: i, offset:-angle)
                
                if m_Layout == .veritcal {
                    self.children[prevIndex].position.y = transit.1
                    self.children[prevIndex].yScale = transit.0/stdSize
                    self.children[prevIndex].xScale = 1.0
                }
                else {
                    self.children[prevIndex].position.x = -transit.1
                    self.children[prevIndex].xScale = transit.0/stdSize
                    self.children[prevIndex].yScale = 1.0
                }
                self.children[prevIndex].zPosition = 1.0
            }
            let nextIndex = m_nSelectedItem + nonSelectedShowItems-i
            if m_nSelectedItem < nextIndex && nextIndex <= end {
                let transit = transitionWithOffset(step: i, offset:angle)
                if m_Layout == .veritcal {
                    self.children[nextIndex].position.y = -transit.1
                    self.children[nextIndex].yScale =  transit.0/stdSize
                    self.children[nextIndex].xScale = 1.0
                }
                else {
                    self.children[nextIndex].position.x =  transit.1
                    self.children[nextIndex].xScale = transit.0/stdSize
                    self.children[nextIndex].yScale = 1.0
                }
                self.children[nextIndex].zPosition = 1.0
            }
        }

        let startAngle = (-halfBaseAngle-angle)//(halfBaseAngle+angle)
        let endAngle = (halfBaseAngle-angle)//(-halfBaseAngle+angle)
        let fSize = fradius*(sin(startAngle) - sin(endAngle))
        let fDistance = fradius*sin(endAngle) + fSize*0.5
        if m_Layout == .veritcal {
            self.children[m_nSelectedItem].position.y = fDistance
            self.children[m_nSelectedItem].xScale = 1.0
            self.children[m_nSelectedItem].yScale = -fSize/stdSize
        }
        else {
            self.children[m_nSelectedItem].position.x = -fDistance
            self.children[m_nSelectedItem].xScale = -fSize/stdSize
            self.children[m_nSelectedItem].yScale = 1.0
        }
        self.children[m_nSelectedItem].zPosition = 1.0

        if 0 < start {
            let i = start-1
            let startAngle = (CGFloat.pi*0.5)
            let endAngle = (CGFloat.pi*0.5-angle)
            let fSize = fradius*(sin(startAngle)-sin(endAngle))
            let fDistance = (fradius*sin(startAngle) - fSize*0.5)

            if m_Layout == .veritcal {
                self.children[i].position.y = fDistance
                self.children[i].yScale = fSize/stdSize
                self.children[i].xScale = 1.0
            }
            else {
                self.children[i].position.x = -fDistance
                self.children[i].xScale = fSize/stdSize
                self.children[i].yScale = 1.0
            }
            self.children[i].zPosition = 1.0
        }
    }
    
    private func AnimateOneItemAscend(_ speed: CGFloat) {
        if ItemCount()-1 <= m_nSelectedItem {
            rollingCompleted()
            return
        }
        let itemCount : Int = ItemCount()
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }

        //let nAnimateSteps : Int = m_nOneItemAnimateSteps
        let dAnimateStepTime : CGFloat = speed/CGFloat(m_nOneItemAnimateSteps)
        RunAnimateOneItemAscend(time:dAnimateStepTime, index:0, start:startShowItem, end:endShowItem)
    }

    private func AnimateOneItemDescend(_ speed: CGFloat) {
        if m_nSelectedItem <= 0 {
            rollingCompleted()
            return
        }
        let itemCount : Int = ItemCount()
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }

        //let nAnimateSteps : Int = m_nOneItemAnimateSteps
        let dAnimateStepTime : CGFloat = speed/CGFloat(m_nOneItemAnimateSteps)
        RunAnimateOneItemDescend(time:dAnimateStepTime, index:0, start:startShowItem, end:endShowItem)
    }

    private func RunAnimateItemsAscend(time:CGFloat, index:Int, start:Int, end:Int, item:Int, items:Int)
    {
        if m_nOneItemAnimateSteps <= index {
            self.selection = m_nSelectedItem + 1
            if ItemCount()-1 <= self.selection {
                rollingCompleted()
                return
            }
            if items-1 <= item {
                rollingCompleted()
                return
            }
            self.run(SKAction.wait(forDuration: TimeInterval(time))) {
                self.StartAnimateItemsAscend(time:time, item:(item+1), items:items)
                return
            }
            return
        }
        
        let dAnimateStepAngle : CGFloat = baseRollAngle()/CGFloat(m_nOneItemAnimateSteps)
        self.run(SKAction.wait(forDuration: TimeInterval(time))) {
            self.MoveItemsAscend(angle:dAnimateStepAngle*CGFloat(index+1), start:start, end:end)
            self.RunAnimateItemsAscend(time:time, index:(index+1), start:start, end:end, item:item, items:items)
        }
    }

    private func StartAnimateItemsAscend(time: CGFloat, item:Int, items:Int) {
        let itemCount : Int = ItemCount()
        if itemCount-1 <= m_nSelectedItem {
            rollingCompleted()
            return
        }
        if items <= item {
            rollingCompleted()
            return
        }
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }

        RunAnimateItemsAscend(time:time, index:0, start:startShowItem, end:endShowItem, item: item, items: items)
    }

    private func RunAnimateItemsDescend(time:CGFloat, index:Int, start:Int, end:Int, item:Int, items:Int)
    {
        if m_nOneItemAnimateSteps <= index {
            self.selection = m_nSelectedItem - 1
            if self.selection <= 0 {
                rollingCompleted()
                return
            }
            if items-1 <= item {
                rollingCompleted()
                return
            }
            self.run(SKAction.wait(forDuration: TimeInterval(time))) {
                self.StartAnimateItemsDescend(time:time, item:(item+1), items:items)
                return
            }
            return
        }
        
        let dAnimateStepAngle : CGFloat = baseRollAngle()/CGFloat(m_nOneItemAnimateSteps)
        self.run(SKAction.wait(forDuration: TimeInterval(time))) {
            self.MoveItemsDescend(angle:dAnimateStepAngle*CGFloat(index+1), start:start, end:end)
            self.RunAnimateItemsDescend(time:time, index:(index+1), start:start, end:end, item:item, items:items)
        }
    }


    private func StartAnimateItemsDescend(time: CGFloat, item:Int, items:Int) {
        let itemCount : Int = ItemCount()
        if m_nSelectedItem <= 0 {
            rollingCompleted()
            return
        }
        if items <= item {
            rollingCompleted()
            return
        }
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }

        RunAnimateItemsDescend(time:time, index:0, start:startShowItem, end:endShowItem, item: item, items: items)
    }

    
    private func AnimateItemsAscend(_ items: Int, _ speed: CGFloat)
    {
        let dAnimateStepTime : CGFloat = speed/CGFloat(m_nOneItemAnimateSteps*items)
        StartAnimateItemsAscend(time:dAnimateStepTime, item:0, items:items)
    }
    
    private func AnimateItemsDescend(_ items: Int, _ speed: CGFloat)
    {
        let dAnimateStepTime : CGFloat = speed/CGFloat(m_nOneItemAnimateSteps*items)
        StartAnimateItemsDescend(time:dAnimateStepTime, item:0, items:items)
    }
    
    private func RollingAscend(offset: CGFloat) {
        let itemCount : Int = ItemCount()
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }
        let dAnimateStepAngle : CGFloat = baseRollAngle()*offset
        self.MoveItemsAscend(angle:dAnimateStepAngle, start:startShowItem, end:endShowItem)
    }
        
    private func RollingDescend(offset: CGFloat) {
        let itemCount : Int = ItemCount()
        let nonSelectedShowItems : Int = (m_DisplayItems-1)/2
        var startShowItem : Int = m_nSelectedItem - nonSelectedShowItems
        if startShowItem < 0 {
            startShowItem = 0
        }
        var endShowItem : Int = m_nSelectedItem + nonSelectedShowItems
        if itemCount <= endShowItem {
            endShowItem = itemCount-1
        }
        let dAnimateStepAngle : CGFloat = baseRollAngle()*offset
        self.MoveItemsDescend(angle:dAnimateStepAngle, start:startShowItem, end:endShowItem)
    }
   
}

extension SKPicker  {
    public func ItemSize()->CGSize {
        let baseAngle : CGFloat = baseRollAngle()

        if m_Layout == .veritcal {
            let width = self.size.width
            let totalLength = self.size.height
            let height = totalLength*sin(baseAngle*0.5) //(totalLength*0.5)*sin(baseAngle*0.5)*2.0
            return CGSize(width: width, height: height)
        }
        else
        {
            let totalLength = self.size.width
            let height = self.size.height
            let width = totalLength*sin(baseAngle*0.5) //(totalLength*0.5)*sin(baseAngle*0.5)*2.0
            return CGSize(width: width, height: height)
        }
    }
    
    public func ItemCount()->Int {
        let nCount : Int = self.children.count
        return nCount
    }

    //Add image item from image assets
    public func AddImageItem(imageset: String, imagescale: CGFloat) {
        var scale = imagescale
        if 1.0 < scale || scale <= 0.0 {
            scale = 1.0
        }
        let itemSize = ItemSize()
        
        let texture = SKPickerRender.createImageSetTexture(name: imageset, size: itemSize, scale: scale, layout:m_Layout)
        let child = SKSpriteNode(texture: texture, size: itemSize)
        child.zPosition = 1.0
        addChild(child)
    }

    //Add image item from image assets
    public func AddRawImageItem(image: CGImage, imagescale: CGFloat) {
        var scale = imagescale
        if 1.0 < scale || scale <= 0.0 {
            scale = 1.0
        }
        let itemSize = ItemSize()
        
        let texture = SKPickerRender.createTextureFromImage(image: image, size: itemSize, scale: scale, layout:m_Layout)
        let child = SKSpriteNode(texture: texture, size: itemSize)
        child.zPosition = 1.0
        addChild(child)
    }


    //Add image item from image assets
    public func AddLabelItem(text: String, fontname: String, imagescale: CGFloat) {
        var scale = imagescale
        if 1.0 < scale || scale <= 0.0 {
            scale = 1.0
        }
        let itemSize = ItemSize()
     
        let texture = SKPickerRender.createLabelTexture(text: text, fontname: fontname, size: itemSize, scale: scale, layout:m_Layout)
        let child = SKSpriteNode(texture: texture, size: itemSize)
        child.zPosition = 1.0
        addChild(child)
    }
    
    //Add image item from image assets
    public func AddColorLabelItem(text: String, fontname: String, color:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat),  imagescale: CGFloat) {
        var scale = imagescale
        if 1.0 < scale || scale <= 0.0 {
            scale = 1.0
        }
        let itemSize = ItemSize()
     
        let texture = SKPickerRender.createColorLabelTexture(text: text, fontname: fontname, color: color, size: itemSize, scale: scale, layout:m_Layout)
        let child = SKSpriteNode(texture: texture, size: itemSize)
        child.zPosition = 1.0
        addChild(child)
    }

    public func AnimateOneItem(speed: CGFloat, direction: SKPickerRolling) {
        m_CanAnimation = false
        if direction == .ascend {
            AnimateOneItemAscend(speed)
        }
        else {
            AnimateOneItemDescend(speed)
        }
    }
    
    public func CanAnimateOneItem(direction: SKPickerRolling)->Bool {
        if direction == .ascend {
            if m_nSelectedItem < ItemCount() {
                return true
            }
        }
        else {
            if 0 < m_nSelectedItem {
                return true
            }
        }
        
        return false;
    }

    public func AnimateItems(items: Int, speed: CGFloat, direction: SKPickerRolling) {
        m_CanAnimation = false
        if direction == .ascend {
            AnimateItemsAscend(items, speed)
        }
        else {
            AnimateItemsDescend(items, speed)
        }
    }

    public func Rolling(offset: CGFloat, direction: SKPickerRolling) {
        if direction == .ascend {
            RollingAscend(offset: offset)
        }
        else {
            RollingDescend(offset: offset)
        }
    }

    public func Initialize() {
        if m_GestureHandler == nil {
            m_GestureHandler = SKPickerGestureRecognizer(self)
        }
        self.isUserInteractionEnabled = true
    }
    
    public func setHost(_ host : SKPickerHost) {
        m_Host = host
    }

    public func rollingCompleted() {
        m_CanAnimation = true
        if m_Host != nil {
            m_Host?.notifyCompletion(sender: self)
        }
    }

    public func clear() {
        self.removeAllChildren()
    }
}

