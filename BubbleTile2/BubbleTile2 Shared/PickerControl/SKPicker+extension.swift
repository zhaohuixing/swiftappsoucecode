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

extension SKPicker  {
    @objc public func SwipeVerticalAscend() {
        if self.layout == .horizontal {
            return
        }
        AnimateItems(items: 10, speed: 0.2, direction: .ascend)
    }

    @objc public func SwipeVerticalDescend() {
        if self.layout == .horizontal {
            return
        }
        AnimateItems(items: 10, speed: 0.2, direction: .descend)
    }
    
    @objc public func SwipeHorizontalAscend() {
        if self.layout == .veritcal {
            return
        }
        AnimateItems(items: 10, speed: 0.2, direction: .ascend)
    }
    
    @objc public func SwipeHorizontalDescend() {
        if self.layout == .veritcal {
            return
        }
        AnimateItems(items: 10, speed: 0.2, direction: .descend)
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension SKPicker {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canAnimation {
            if event != nil && touches.first != nil {
                let time : TimeInterval = event!.timestamp
                var pt : CGPoint = touches.first!.location(in: nil)
                pt.y = -1.0*pt.y
                self.gestureHandler.start(point: pt, time: time)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canAnimation {
            if event != nil && touches.first != nil {
                let time : TimeInterval = event!.timestamp
                var pt : CGPoint = touches.first!.location(in: nil)
                pt.y = -1.0*pt.y
                self.gestureHandler.move(point: pt, time: time)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.canAnimation {
            if event != nil && touches.first != nil {
                let time : TimeInterval = event!.timestamp
                var pt : CGPoint = touches.first!.location(in: nil)
                pt.y = -1.0*pt.y
                self.gestureHandler.stop(point: pt, time: time)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
#endif

#if os(tvOS)
// Touch-based event handling
extension SKPicker {
    func touchDown(atPoint pos : CGPoint) {
        self.gestureHandler.start(point: pos, time: 0)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.gestureHandler.move(point: pos, time: 100)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.gestureHandler.stop(point: pos, time: 100)
    }
}
#endif


#if os(OSX)
// Mouse-based event handling
extension SKPicker {
    override func mouseDown(with event: NSEvent) {
        if self.canAnimation {
            let pt : CGPoint = CGPoint(x:event.locationInWindow.x, y:event.locationInWindow.y)
            let time : TimeInterval = event.timestamp
            self.gestureHandler.start(point: pt, time: time)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        if self.canAnimation {
            let pt : CGPoint = CGPoint(x:event.locationInWindow.x, y:event.locationInWindow.y)
            let time : TimeInterval = event.timestamp
            self.gestureHandler.move(point: pt, time: time)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if self.canAnimation {
            let pt : CGPoint = CGPoint(x:event.locationInWindow.x, y:event.locationInWindow.y)
            let time : TimeInterval = event.timestamp
            self.gestureHandler.stop(point: pt, time: time)
        }
    }
}
#endif



