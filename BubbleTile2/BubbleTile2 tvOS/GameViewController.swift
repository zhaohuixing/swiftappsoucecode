///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 tvOS 
Package: 	BubbleTile2 tvOS 
File: 		GameViewController.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, IEvnetHandler {
 
    private var m_GameScene : GameScene? = nil
    private var m_SettingScene : SettingScene? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let screenWidth  = UIScreen.main.bounds.width * UIScreen.main.scale
        let screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
        GameLayout.SetScreenSize(width: screenWidth, height: screenHeight)

        let scene = GameScene.newGameScene()
        m_GameScene = scene
        m_SettingScene = SettingScene.newSettingScene()

        // Present the scene
        let skView = self.view as! SKView
        let reveal = SKTransition.doorway(withDuration: 0.5)
        reveal.pausesIncomingScene = false
        reveal.pausesOutgoingScene = true
        skView.presentScene(scene, transition: reveal)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = false//true
        skView.showsNodeCount = false//true
        initHandler()
        m_GameScene!.loadLayoutSign()
    }

    func undo() {
        if m_GameScene != nil {
            if m_GameScene!.sceneController.canUndo() {
                m_GameScene!.Undo()
            }
        }
    }

    func demo() {
        if m_GameScene != nil {
            m_GameScene!.sceneController.startDemo()
        }
    }

    func resume() {
        if m_GameScene != nil && CanResumePlayGame() {
            m_GameScene!.resumeGamePlay()
        }
    }

    func newgame() {
        if m_GameScene != nil {
            m_GameScene!.isUserInteractionEnabled = true
            m_GameScene!.startNewGame()
        }
    }
    
    func setting() {
        if canGotoSetting() == true {
            startNewSetting()
        }
    }
    
    func closesetting() {
        let skView = self.view as! SKView
        let reveal = SKTransition.doorway(withDuration: 0.5)
        reveal.pausesIncomingScene = false
        reveal.pausesOutgoingScene = true
        skView.presentScene(m_GameScene!, transition: reveal)
        m_GameScene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        m_GameScene!.scaleMode = .aspectFill
        m_GameScene!.isUserInteractionEnabled = true
        m_GameScene!.startNewGame()
        m_GameScene!.loadLayoutSign()
    }

    
    func initHandler() {
        _initHandler()
    }
    func releaseHandler() {
        _releaseHandler()
    }

    func canGotoSetting()->Bool {
        return true
    }
    
    func startNewSetting() {
        let skView = self.view as! SKView
        m_SettingScene!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        m_SettingScene!.scaleMode = .aspectFill
        m_SettingScene!.loadSetting()
        m_SettingScene!.isUserInteractionEnabled = true
        let reveal = SKTransition.doorway(withDuration: 0.5)
        reveal.pausesIncomingScene = false
        reveal.pausesOutgoingScene = true
        skView.presentScene(m_SettingScene!, transition: reveal)
    }

    func CanResumePlayGame()->Bool {
        if m_GameScene != nil {
            return m_GameScene!.sceneController.canResumeGamePlay()
        }
        return false
    }

}
