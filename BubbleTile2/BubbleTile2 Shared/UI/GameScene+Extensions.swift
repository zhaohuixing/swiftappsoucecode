///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	 
Package: 	BubbleTile2 Shared 
File: 		GameScene.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension GameScene: IPuzzleScene {
    func ResetScene() {
        return;
    }
    
    func canShiftBubble()->Bool {
        return self.sceneController.canShiftBubble()
    }
    
    func UpdateStepCount() {
        let nCount = self.sceneController.undoCount()
        updateStepSign(nCount)
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.sceneController.canShiftBubble() == false || touches.count < 0 {
            return
        }
        
        let ptStart : CGPoint = touches.first!.location(in:self)
        startPlayTouchMode(at:ptStart)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.sceneController.isPlayTouchMode() && 0 < touches.count {
            let ptMove : CGPoint = touches.first!.location(in:self)
            movePlayTouch(to: ptMove)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.sceneController.isPlayTouchMode() && 0 < touches.count {
            let ptStop : CGPoint = touches.first!.location(in:self)
            endPlayTouch(stop: ptStop)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
#endif

#if os(tvOS)
// Touch-based event handling
extension GameScene {
    func touchDown(atPoint pos : CGPoint) {
        if self.sceneController.canShiftBubble() == false  {
            return
        }
        
        startPlayTouchMode(at:pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if self.sceneController.isPlayTouchMode()  {
            movePlayTouch(to: pos)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if self.sceneController.isPlayTouchMode()  {
            endPlayTouch(stop: pos)
        }
    }
}
#endif


#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if self.sceneController.canShiftBubble() == false {
            return
        }
        
        let ptStart : CGPoint = event.location(in: self)
        startPlayTouchMode(at:ptStart)
    }
    
    override func mouseDragged(with event: NSEvent) {
        if self.sceneController.isPlayTouchMode() {
            let ptMove : CGPoint = event.location(in: self)
            movePlayTouch(to: ptMove)
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if self.sceneController.isPlayTouchMode() {
            let ptStop : CGPoint = event.location(in: self)
            endPlayTouch(stop: ptStop)
        }
    }

}
#endif

extension GameScene {
    class func GameSceneName()->String {
        return "Game Scene"
    }
}
