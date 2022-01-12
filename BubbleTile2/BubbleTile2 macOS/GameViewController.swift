///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 macOS 
Package: 	BubbleTile2 macOS 
File: 		GameViewController.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController, IEvnetHandler {

    private var m_GameScene : GameScene? = nil
    private var m_SettingScene : SettingScene? = nil

    func isGameScene()->Bool {
        let skView = self.view as! SKView
        
        if skView.scene!.name! == GameScene.GameSceneName() {
            return true
        }
        else {
            return false
        }
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
        if m_GameScene != nil {
            m_GameScene!.resumeGamePlay()
        }
    }

    func newgame() {
        if m_GameScene != nil {
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
        //skView.presentScene(m_GameScene!)
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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameLayout.SetScreenSize(width: self.view.frame.width, height:view.frame.height)

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
        //        skView.presentScene(m_SettingScene!)
    }

    func CanResumePlayGame()->Bool {
        if m_GameScene != nil {
            return m_GameScene!.sceneController.canResumeGamePlay()
        }
        return false
    }
}

