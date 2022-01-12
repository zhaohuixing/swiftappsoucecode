///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	 
Package: 	BubbleTile2 macOS 
File: 		AppDelegate.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let FrameSize : NSSize = NSSize(width:800, height:600)//(width:960, height:720)//(width:1027, height:768)
        let mainWindows = NSApplication.shared.mainWindow
        if mainWindows != nil {
            mainWindows!.setContentSize(FrameSize)
            mainWindows!.contentMinSize = FrameSize
            mainWindows!.contentMaxSize = FrameSize
            GameLayout.SetScreenSize(width: FrameSize.width, height:FrameSize.height)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
//        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController
//        viewController.releaseHandler()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    @IBAction func Setting(_ sender: Any) {
        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController
        
        if viewController.isGameScene() == false {
            return
        }
        
        viewController.setting()
    }

    @IBAction func NewGame(_ sender: Any) {
        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController

        if viewController.isGameScene() == false {
            viewController.closesetting()
        }
        else {
            viewController.newgame()
        }
    }


    @IBAction func Undo(_ sender: Any) {
        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController
        
        if viewController.isGameScene() == false {
            return
        }
        viewController.undo()
    }

    @IBAction func DemoPlay(_ sender: Any) {
        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController
        if viewController.isGameScene() == false {
            return
        }
        viewController.demo()
    }

    @IBAction func ResumeGamePlay(_ sender: Any) {
        let viewController : GameViewController = NSApplication.shared.mainWindow?.contentViewController as! GameViewController
        if viewController.isGameScene() == false {
            return
        }
        if viewController.CanResumePlayGame() {
            viewController.resume()
        }
    }
}

