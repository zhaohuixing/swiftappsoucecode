///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 watchOS App Extension 
Package: 	BubbleTile2 watchOS App Extension 
File: 		InterfaceController.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    private var m_GameScene : GameScene? = nil
    private var m_SettingScene : SettingScene? = nil

    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let scene = GameScene.newGameScene()
        m_GameScene = scene
        m_SettingScene = SettingScene.newSettingScene()

        // Present the scene
        self.skInterface.presentScene(scene)
        
        // Use a preferredFramesPerSecond that will maintain consistent frame rate
        self.skInterface.preferredFramesPerSecond = 30
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
