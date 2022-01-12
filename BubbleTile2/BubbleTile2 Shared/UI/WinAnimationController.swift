///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		WinAnimayionController.swift

Created by: Zhaohui Xing on 5/21/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class WinAnimator : SKSpriteNode {
    fileprivate var m_winSign : SKSpriteNode? = nil
    
    var isAnimation : Bool {
        get {
            return (self.parent != nil)
        }
    }

    func Initialize() {
        let arrowSize = GameLayout.GetlayoutSignSize()
        let texture : SKTexture = WinAnimationController.CreateWinSignTexture()
        m_winSign = SKSpriteNode(texture: texture, size: CGSize(width: arrowSize, height: arrowSize))
        self.size = CGSize(width: arrowSize*2.0, height: arrowSize*2.0)
    }
    
    func EndAnimation() {
        if self.parent != nil {
            self.removeFromParent()
        }
        self.removeAllChildren()
    }

    func StartAnimation(parent: GameScene) {
        if self.parent == nil {
            parent.addChild(self)
        }
        startShowWinSign()
    }

    private func startShowWinSign() {
        if let spinny = m_winSign?.copy() as! SKSpriteNode? {
            let fy : CGFloat = (GameLayout.GetPuzzleSize().height)*0.5
            spinny.position = CGPoint(x: 0.0, y: fy)
            spinny.alpha = 0.0
            self.addChild(spinny)
            spinny.zPosition = 3.0
            spinny.run(SKAction.fadeIn(withDuration: 1))
            {
                self.rotateSpinnyforward(spinny, CGFloat(Double.pi*(1.0/6.0)))
            }
        }
    }
    
    private func rotateSpinnyforward(_ spinny: SKSpriteNode, _ angle: CGFloat) {
        spinny.run(SKAction.rotate(byAngle: angle, duration: 0.5))
        {
            self.rotateSpinnybackward(spinny, CGFloat(Double.pi*(-1.0/3.0)))
        }
    }

    private func rotateSpinnybackward(_ spinny: SKSpriteNode, _ angle: CGFloat) {
        spinny.run(SKAction.rotate(byAngle: angle, duration: 0.5))
        {
            self.rotateSpinnyforward(spinny, -angle)
        }
    }
}

class WinAnimationController {
    fileprivate unowned var m_GameScene : GameScene
    fileprivate var m_winSign : WinAnimator = WinAnimator()

    
    init(scene : GameScene) {
        m_GameScene = scene
        m_winSign.Initialize()
    }
    
    func EndWinAnimation() {
        m_winSign.EndAnimation()
    }

    func StartWinAnimation() {
        m_winSign.StartAnimation(parent: m_GameScene)
    }

}

extension WinAnimationController {
    class func CreateWinSignTexture()->SKTexture {
        let winImage : CGImage? = RenderHelper.LoadResourceImage(name:"winsign")
        guard winImage != nil else {
            fatalError("No valid win sign image:winsign")
        }

        let texture : SKTexture = SKTexture(cgImage: winImage!);
        return texture
    }
}

