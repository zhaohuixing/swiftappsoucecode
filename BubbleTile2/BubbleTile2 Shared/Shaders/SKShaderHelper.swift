///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		SKShaderHelper.swift

Created by: Zhaohui Xing on 5/17/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import Foundation
import SpriteKit

class SKShaderHelper {
    class func CreateEmbossShader(grayscale: CGFloat, strength: CGFloat)->SKShader {
        let uniforms: [SKUniform] = [SKUniform(name: "u_grayscale", float: Float(grayscale)),
            SKUniform(name: "u_strength", float: Float(strength))
        ]

        let attributes = [SKAttribute(name: "a_size", type: .vectorFloat2)]

        return SKShader(fromFile: "SKSHEmboss", uniforms: uniforms, attributes: attributes)
    }

    class func CreateEmptyShader()->SKShader {
        return SKShader(fromFile: "SKSHEmpty")
    }

    class func CreateBlackToGrayShader()->SKShader {
        let uniforms: [SKUniform] = []
        let attributes = [SKAttribute(name: "a_size", type: .vectorFloat2)]
        return SKShader(fromFile: "SKSHBlackToGray", uniforms: uniforms, attributes: attributes)
    }
    
    class func CreateChipWinAnimationShader()->SKShader {
        return SKShader(fromFile: "SKSHWinAnimation")
    }

    class func CreateChipMotionShader()->SKShader {
        return SKShader(fromFile: "SKSHShiftAnimation")
    }

    class func CreateSemiQpqueShader()->SKShader {
        return SKShader(fromFile: "SKSHSemiOpque")
    }
}
