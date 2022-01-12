///**
/**
Workspace:     PickerControl For SpriteKit
Project:     PickerControl For SpriteKit
Target:      PickerControl For SpriteKit
Package:     PickerControl For SpriteKit
File: 		SKPickerTypes.swift

Created by: Zhaohui Xing on 5/1/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

public enum SKPickerLayout : Int {
    case veritcal
    case horizontal
}

public enum SKPickerSpeed : Int {
    case noanimation
    case slow
    case medium
    case fast
}

public enum SKPickerRolling : Int {
    case ascend           //rolling toward next items
    case descend          //rolling toward previous items
}
