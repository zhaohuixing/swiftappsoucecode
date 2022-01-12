///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		TBButton.swift

Created by: Zhaohui Xing on 4/8/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit
import Foundation

class TBButton : SKSpriteNode {
    private var m_EventID : enGameEventID = enGameEventID.GAME_EVENT_SETTING
    private var m_bEnable : Bool = true
    private let m_SKSHNormal : SKShader = SKShaderHelper.CreateEmptyShader()
    private let m_SKSHDisable : SKShader = SKShaderHelper.CreateSemiQpqueShader() //SKShaderHelper.CreateEmbossShader(grayscale: 0.6, strength: 1.0)

    
    public var eventID : enGameEventID {
        get {
            return m_EventID
        }
        set (newValue) {
            m_EventID = newValue
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        set {
        }
        get {
            return true
        }
    }

    func postEvent() {
        if m_bEnable == true {
            NotificationCenter.default.post(Notification(name: m_EventID.eventName))
        }
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension TBButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        postEvent()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
   
}
#endif

#if os(tvOS)
// Touch-based event handling
extension TBButton {
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        postEvent()
    }
}
#endif


#if os(OSX)
// Mouse-based event handling
extension TBButton {

    override func mouseDown(with event: NSEvent) {
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
        postEvent()
    }

}
#endif

extension TBButton {

    class func CreateToolBarButton(size: CGSize, image: String, eventID: enGameEventID)->TBButton {
        let btnImage : CGImage? = RenderHelper.LoadResourceImage(name:image)
        guard btnImage != nil else {
            fatalError("No valid Toolbar button image:\(image)")
        }
        let btnTexture : SKTexture = SKTexture(cgImage: btnImage!)
        let btnTB = TBButton(texture: btnTexture, size: size)
        btnTB.eventID = eventID
        btnTB.setEnable(true)
        return btnTB
    }

    public func setEnable(_ enable: Bool) {
        m_bEnable = enable
        updateButtonState()
    }

    private func updateButtonState() {
        if m_bEnable == true {
            self.shader = m_SKSHNormal
        }
        else {
            self.shader = m_SKSHDisable
        }
    }
}

