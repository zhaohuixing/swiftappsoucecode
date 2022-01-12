///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		MotionIndicatorController.swift

Created by: Zhaohui Xing on 5/21/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class MotionIndicator : SKSpriteNode {
    fileprivate var m_arrowSign : SKSpriteNode? = nil
    let m_Alpha : CGFloat = 0.5
    let m_AnimationTime : Double = 0.5

    var m_CurrentMotion : enBubbleMotion = enBubbleMotion.BUBBLE_MOTION_NONE
    var m_CurrentDirection : enMotionDirection = enMotionDirection.MOTION_DIRECTION_NONE
    
    var isAnimation : Bool {
        get {
            return (self.parent != nil)
        }
    }

    func Initialize() {
        let arrowSize = GameLayout.GetArrowSignSize();
        let texture : SKTexture = MotionIndicatorController.CreateLeftArrowTexture()
        m_arrowSign = SKSpriteNode(texture: texture, size: CGSize(width: arrowSize*0.5, height: arrowSize*0.5))
        self.size = CGSize(width: arrowSize*2.0, height: arrowSize*2.0)
    }
    
    func TouchStartAnimation(parent: GameScene, gridType: enGridType) {
        if self.isAnimation == true {
            return
        }
        
        parent.addChild(self)
        showHorizontalIndicator()
        if gridType == enGridType.PUZZLE_GRID_SQUARE {
            showVerticalIndicator()
        }
        else {
            showDiagonal60Indicator()
            showDiagonal120Indicator()
        }
    }
    
    func EndAnimation() {
        if self.parent != nil {
            //self.run(SKAction.removeFromParent())
            self.removeFromParent()
        }
        self.removeAllChildren()
        m_CurrentMotion = enBubbleMotion.BUBBLE_MOTION_NONE
        m_CurrentDirection = enMotionDirection.MOTION_DIRECTION_NONE
    }
    
    func TouchMotionAnimation(parent: GameScene, touchMotion: enBubbleMotion, touchDirection : enMotionDirection)
    {
        if self.isAnimation == false {
            parent.addChild(self)
        }
        
        if m_CurrentMotion != touchMotion || m_CurrentDirection != touchDirection || 1 < self.children.count  {
            m_CurrentMotion = touchMotion
            m_CurrentDirection = touchDirection
            updateMotionAnimation()
        }
    }
    
    private func updateMotionAnimation() {
        self.removeAllChildren()
        switch m_CurrentMotion {
        case enBubbleMotion.BUBBLE_MOTION_HORIZONTAL:
            switch m_CurrentDirection {
            case enMotionDirection.MOTION_DIRECTION_FORWARD:
                showHorizontalIndicatorForward()
            case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                showHorizontalIndicatorBackward()
            default:
                return
            }
        case enBubbleMotion.BUBBLE_MOTION_VERTICAL:
            switch m_CurrentDirection {
            case enMotionDirection.MOTION_DIRECTION_FORWARD:
                showVerticalIndicatorForward()
            case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                showVerticalIndicatorBackward()
            default:
                return
            }
        case enBubbleMotion.BUBBLE_MOTION_60DIAGONAL:
            switch m_CurrentDirection {
            case enMotionDirection.MOTION_DIRECTION_FORWARD:
                showDiagonal60IndicatorForward()
            case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                showDiagonal60IndicatorBackward()
            default:
                return
            }
        case enBubbleMotion.BUBBLE_MOTION_120DIAGONAL:
            switch m_CurrentDirection {
            case enMotionDirection.MOTION_DIRECTION_FORWARD:
                showDiagonal120IndicatorForward()
            case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                showDiagonal120IndicatorBackward()
            default:
                return
            }
        default:
            return
        }
    }
    
    private func showHorizontalIndicatorBackward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*0.5), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(-fMoving), y:0), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()]))
            {
                self.showHorizontalIndicatorBackward()
            }
        }
    }
    
    private func showHorizontalIndicatorForward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.zPosition = 3.0
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*(-0.5)), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(fMoving), y:0), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()]))
            {
                self.showHorizontalIndicatorForward()
            }
        }
    }

    private func showHorizontalIndicator() {
        showHorizontalIndicatorForward()
        showHorizontalIndicatorBackward()
    }
    
    private func showVerticalIndicatorForward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                SKAction.move(to:CGPoint(x:0.0, y:(+fMoving)), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()])) {self.showVerticalIndicatorForward()}
        }
    }
    
    private func showVerticalIndicatorBackward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*(-1.0)), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                SKAction.move(to:CGPoint(x:0.0, y:(-fMoving)), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()])) {self.showVerticalIndicatorBackward()}
        }
    }

    private func showVerticalIndicator() {
        showVerticalIndicatorForward()
        showVerticalIndicatorBackward()
    }
        
    private func showDiagonal60Indicator() {
        showDiagonal60IndicatorForward()
        showDiagonal60IndicatorBackward()
    }
    
    private func showDiagonal60IndicatorForward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*(-1.0)/6.0), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(fMoving*0.5), y:(fMoving*0.866025403784439)), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()])) {self.showDiagonal60IndicatorForward()}
        }
    }
    
    private func showDiagonal60IndicatorBackward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*(5.0)/6.0), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(-fMoving*0.5), y:(-fMoving*0.866025403784439)), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()])) {self.showDiagonal60IndicatorBackward()}
        }
    }
        
    private func showDiagonal120Indicator() {
        showDiagonal120IndicatorForward()
        showDiagonal120IndicatorBackward()
    }
    
    private func showDiagonal120IndicatorForward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*1.0/6.0), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(-fMoving*0.5), y:(fMoving*0.866025403784439)), duration:m_AnimationTime),
                                          SKAction.fadeOut(withDuration: m_AnimationTime),
                                          SKAction.removeFromParent()])) {self.showDiagonal120IndicatorForward()}
        }
    }
    
    private func showDiagonal120IndicatorBackward() {
        if let spinny = m_arrowSign?.copy() as! SKSpriteNode? {
            spinny.zPosition = 3.0
            spinny.alpha = m_Alpha
            self.addChild(spinny)
            let fMoving = GameLayout.GetArrowSignSize()
            spinny.run(SKAction.rotate(byAngle: CGFloat(Double.pi*(-5.0)/6.0), duration: 0.0))
            spinny.run(SKAction.sequence([//SKAction.fadeIn(withDuration: 0.1),
                                          SKAction.move(to:CGPoint(x:(fMoving*0.5), y:(-fMoving*0.866025403784439)), duration:m_AnimationTime),
                                        SKAction.fadeOut(withDuration: m_AnimationTime),
                                        SKAction.removeFromParent()])) {self.showDiagonal120IndicatorBackward()}
        }
    }

}

class MotionIndicatorController {
    fileprivate unowned var m_GameScene : GameScene
    fileprivate var m_touchStartSign : MotionIndicator = MotionIndicator()
    fileprivate var m_touchMotionSign : MotionIndicator = MotionIndicator()

    
    init(scene : GameScene) {
        m_GameScene = scene
        m_touchStartSign.Initialize()
        m_touchMotionSign.Initialize()
    }
    
    func EndStartIndicator() {
        m_touchStartSign.EndAnimation()
    }

    func EndAllIndicators() {
        m_touchStartSign.EndAnimation()
        m_touchMotionSign.EndAnimation()
    }

    func ShowTouchStartIndicator(location: CGPoint, gridType: enGridType) {
        if m_touchStartSign.isAnimation == false {
            m_touchStartSign.position = location
            m_touchStartSign.zPosition = 1.0
            m_touchStartSign.TouchStartAnimation(parent: m_GameScene, gridType: gridType)
        }
    }

    func ShowTouchMotionIndicator(location: CGPoint, direction: enTouchMotion, gridType: enGridType) {
        m_touchStartSign.EndAnimation()
        //self.isAnimation = true;
        if gridType == enGridType.PUZZLE_GRID_SQUARE {
            switch direction {
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_POSITIVE:
                        showHorizontalIndicatorForward(location: location)
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_NEGATIVE:
                        showHorizontalIndicatorBackward(location: location)
                case enTouchMotion.TOUCH_MOTION_VERTICAL_UP,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL60_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL120_POSITIVE:
                        showVerticalIndicatorForward(location: location)
                case enTouchMotion.TOUCH_MOTION_VERTICAL_DOWN,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL60_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL120_NEGATIVE:
                        showVerticalIndicatorBackward(location: location)
                default:
                    return
            }
        }
        else {
            switch direction {
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_POSITIVE:
                        showHorizontalIndicatorForward(location: location)
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_NEGATIVE:
                        showHorizontalIndicatorBackward(location: location)
                case enTouchMotion.TOUCH_MOTION_DIAGNOL60_POSITIVE:
                        showDiagonal60IndicatorForward(location: location)
                case enTouchMotion.TOUCH_MOTION_DIAGNOL60_NEGATIVE:
                        showDiagonal60IndicatorBackward(location: location)
                case enTouchMotion.TOUCH_MOTION_DIAGNOL120_POSITIVE:
                        showDiagonal120IndicatorForward(location: location)
                case enTouchMotion.TOUCH_MOTION_DIAGNOL120_NEGATIVE:
                        showDiagonal120IndicatorBackward(location: location)
                default:
                    return
            }
        }
    }
    
    private func showDiagonal120IndicatorForward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_120DIAGONAL, touchDirection: enMotionDirection.MOTION_DIRECTION_FORWARD)
    }
    
    private func showDiagonal120IndicatorBackward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_120DIAGONAL, touchDirection: enMotionDirection.MOTION_DIRECTION_BACKWARD)
    }

    private func showDiagonal60Indicator(location: CGPoint) {
        showDiagonal60IndicatorForward(location: location)
        showDiagonal60IndicatorBackward(location: location)
    }

    private func showDiagonal60IndicatorForward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_60DIAGONAL, touchDirection: enMotionDirection.MOTION_DIRECTION_FORWARD)
    }
    
    private func showDiagonal60IndicatorBackward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_60DIAGONAL, touchDirection: enMotionDirection.MOTION_DIRECTION_BACKWARD)
    }

    private func showDiagonal120Indicator(location: CGPoint) {
        showDiagonal120IndicatorForward(location: location)
        showDiagonal120IndicatorBackward(location: location)
    }

    private func showHorizontalIndicatorBackward(location: CGPoint) {
     m_touchMotionSign.position = location
     m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_HORIZONTAL, touchDirection: enMotionDirection.MOTION_DIRECTION_BACKWARD)
    }
    
    private func showHorizontalIndicatorForward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_HORIZONTAL, touchDirection: enMotionDirection.MOTION_DIRECTION_FORWARD)
    }

    private func showHorizontalIndicator(location: CGPoint) {
        showHorizontalIndicatorForward(location: location)
        showHorizontalIndicatorBackward(location: location)
    }

    private func showVerticalIndicatorForward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_VERTICAL, touchDirection: enMotionDirection.MOTION_DIRECTION_FORWARD)
    }
    
    private func showVerticalIndicatorBackward(location: CGPoint) {
        m_touchMotionSign.position = location
        m_touchMotionSign.TouchMotionAnimation(parent: m_GameScene, touchMotion: enBubbleMotion.BUBBLE_MOTION_VERTICAL, touchDirection: enMotionDirection.MOTION_DIRECTION_BACKWARD)
    }

    private func showVerticalIndicator(location: CGPoint) {
        showVerticalIndicatorForward(location: location)
        showVerticalIndicatorBackward(location: location)
    }
}

extension MotionIndicatorController {
    class func CreateLeftArrowTexture()->SKTexture {
    let arrowImage : CGImage? = RenderHelper.LoadResourceImage(name:"arrow")
    guard arrowImage != nil else {
            fatalError("No valid Toolbar button image:arrow")
    }

    let texture : SKTexture = SKTexture(cgImage: arrowImage!);
    return texture
    }
}

