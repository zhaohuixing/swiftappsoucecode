///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		LayoutSign.swift

Created by: Zhaohui Xing on 5/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class LayoutSign : SKSpriteNode {
    func UpdateLayoutSign(imageSet: Int, type: enGridType, layout: enGridLayout, edge: Int) {
        let fSize : CGFloat = self.size.width
        let image : CGImage = RenderHelper.CreateLayoutPuzzleSignImage(imageSet: imageSet, type:type, layout:layout, edge: edge, size: fSize)!
        
        let texture : SKTexture = SKTexture(cgImage: image);
        self.texture = texture
        self.zPosition = 1.0
    }
}
