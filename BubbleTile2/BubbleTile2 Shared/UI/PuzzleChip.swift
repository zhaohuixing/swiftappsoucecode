///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleChip.swift

Created by: Zhaohui Xing on 2/21/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class PuzzleChip : SKSpriteNode {
    unowned var m_ChipData : ChipData? = nil
    private let m_SKSHNormal : SKShader = SKShaderHelper.CreateEmptyShader()
    private let m_SKSHNotMatch : SKShader = SKShaderHelper.CreateSemiQpqueShader() //SKShaderHelper.CreateBlackToGrayShader()
    private let m_SKSHMotion : SKShader = SKShaderHelper.CreateChipMotionShader()

    public func CheckMatch() {
        let bRet : Bool = (m_ChipData!.IsMatch())
        if bRet == true {
            self.shader = m_SKSHNormal
        }
        else {
            self.shader = m_SKSHNotMatch
        }
    }

    public func StartWinAnimation() {
        self.shader = SKShaderHelper.CreateChipWinAnimationShader()
    }

    public func SetMotionMode() {
        self.shader = m_SKSHMotion
    }

    public var chipData : ChipData {
        get {
            guard let _ = m_ChipData else {
                fatalError("ChipData object is not assigned to Puzzl")
            }
            return m_ChipData!
        }
        set (newValue) {
            m_ChipData = newValue
        }
    }
   
    public var realindex : Int {
        get {
            return m_ChipData!.realindex
        }
        set (newValue) {
            m_ChipData!.realindex = newValue
        }
    }

    public var labelindex : Int {
        get {
            return m_ChipData!.labelindex
        }
    }

    public var genericindex : Int {
        get {
            return m_ChipData!.genericindex
        }
    }
    
    func ChangeTo(gridIndex: Int) {
        m_ChipData!.realindex = gridIndex
    }
}
