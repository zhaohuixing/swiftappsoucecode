///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		ToolBarPanel.swift

Created by: Zhaohui Xing on 4/11/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class ToolBarPanel : SKSpriteNode {
    private var m_SettingBtn : TBButton? = nil
    private var m_NewGameBtn : TBButton? = nil
    private var m_UndoBtn : TBButton? = nil
    private var m_DemoBtn : TBButton? = nil
    private var m_ResumeBtn : TBButton? = nil

    func CreateToolBarButtons() {
        let size = CGSize(width: GameLayout.GetToolBarButtonSize(), height: GameLayout.GetToolBarButtonSize())
        let settingBtn = TBButton.CreateToolBarButton(size: size, image: "wizard", eventID: enGameEventID.GAME_EVENT_SETTING)
        settingBtn.position = CGPoint(x: -size.width*2.0, y: 0)
        self.addChild(settingBtn)
        m_SettingBtn = settingBtn
        m_SettingBtn!.setValue(SKAttributeValue(size: size), forAttribute: "a_size")

        let newGameBtn = TBButton.CreateToolBarButton(size: size, image: "play", eventID: enGameEventID.GAME_EVENT_NEWGAME)
        newGameBtn.position = CGPoint(x: -size.width, y: 0)
        self.addChild(newGameBtn)
        m_NewGameBtn = newGameBtn
        m_NewGameBtn!.setValue(SKAttributeValue(size: size), forAttribute: "a_size")

        let undoBtn = TBButton.CreateToolBarButton(size: size, image: "undo", eventID: enGameEventID.GAME_EVENT_UNDO)
        undoBtn.position = CGPoint(x: 0, y: 0)
        self.addChild(undoBtn)
        m_UndoBtn = undoBtn
        m_UndoBtn!.setValue(SKAttributeValue(size: size), forAttribute: "a_size")

        let demoBtn = TBButton.CreateToolBarButton(size: size, image: "demo", eventID: enGameEventID.GAME_EVENT_DEMO)
        demoBtn.position = CGPoint(x: size.width, y: 0)
        self.addChild(demoBtn)
        m_DemoBtn = demoBtn
        m_DemoBtn!.setValue(SKAttributeValue(size: size), forAttribute: "a_size")

        let resumeBtn = TBButton.CreateToolBarButton(size: size, image: "resume", eventID: enGameEventID.GAME_EVENT_RESUME)
        resumeBtn.position = CGPoint(x: size.width*2.0, y: 0)
        self.addChild(resumeBtn)
        m_ResumeBtn = resumeBtn
        m_ResumeBtn!.setValue(SKAttributeValue(size: size), forAttribute: "a_size")
    }

    func UpdateToobarButton(_ btnStatus : enToolBarMode) {
        switch btnStatus {
            case enToolBarMode.TBMODE_NONE:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(true)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(true)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_PLAY:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(true)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(true)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(true)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(true)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_PLAY_TOUCH:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(false)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(false)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_PLAY_SHIFTBUBBLE:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(false)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(false)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_DEMO_PLAY_SHIFTBUBBLE:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(false)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(false)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_DEMO_PLAY_END:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(true)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(true)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(true)
                }
            case enToolBarMode.TBMODE_RESULT:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(true)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(true)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
            case enToolBarMode.TBMODE_CONFIGURE:
                if let settingBtn = m_SettingBtn {
                    settingBtn.setEnable(false)
                }
                if let newGameBtn = m_NewGameBtn {
                    newGameBtn.setEnable(false)
                }
                if let undoBtn = m_UndoBtn {
                    undoBtn.setEnable(false)
                }
                if let demoBtn = m_DemoBtn {
                    demoBtn .setEnable(false)
                }
                if let resumeBtn = m_ResumeBtn {
                    resumeBtn.setEnable(false)
                }
        }
    }
}

#if os(OSX)
// Mouse-based event handling
extension ToolBarPanel {

    override func mouseDown(with event: NSEvent) {
        NSLog("mouseDown")
    }
    
    override func mouseDragged(with event: NSEvent) {
        NSLog("mouseDragged")
    }
    
    override func mouseUp(with event: NSEvent) {
        NSLog("mouseUp")
    }

}
#endif
