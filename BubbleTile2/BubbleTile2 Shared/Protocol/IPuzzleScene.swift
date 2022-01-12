//
//  IPuzzleScene.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation
import SpriteKit

protocol IPuzzleScene : AnyObject {
    func ResetScene()
    func UpdateStepCount()
}
