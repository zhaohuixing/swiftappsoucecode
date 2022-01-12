///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		StepSign.swift

Created by: Zhaohui Xing on 5/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class StepSign : SKSpriteNode {
    private var m_SignLabel : SKSpriteNode? = nil
    func InitializeStepUI() {
        let image : CGImage = RenderHelper.LoadResourceImage(name: "signled")!
        let texture : SKTexture = SKTexture(cgImage: image);
        self.texture = texture
        self.zPosition = 1.0
        InitializeLabel()
    }
    
    func UpdateSteps(_ step: Int) {
        let image : CGImage = RenderHelper.CreateStepSignImage(number: step, size: self.size)!
        let texture : SKTexture = SKTexture(cgImage: image);
        m_SignLabel!.texture = texture
    }
    
    private func InitializeLabel() {
        let labelNode : SKSpriteNode = SKSpriteNode()
        labelNode.size = self.size
        labelNode.zPosition = 1.0
        m_SignLabel = labelNode
        self.addChild(labelNode)
        UpdateSteps(0)
    }
}
