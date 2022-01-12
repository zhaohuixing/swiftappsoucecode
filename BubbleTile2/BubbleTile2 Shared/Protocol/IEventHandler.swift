///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		IEventHandler.swift

Created by: Zhaohui Xing on 4/10/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import Foundation


//Define a Objective-C protocol for supporting #selector
@objc protocol IEvnetHandler  {
    func undo()
    func demo()
    func resume()
    func newgame()
    func setting()
    func closesetting()

    func initHandler()
    func releaseHandler()
}

extension IEvnetHandler {
    func _initHandler() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.undo), name: enGameEventID.undoEvent(), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.setting), name: enGameEventID.settingEvent(), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.demo), name: enGameEventID.demoEvent(), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.resume), name: enGameEventID.resumeEvent(), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.newgame), name: enGameEventID.newgameEvent(), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.closesetting), name: enGameEventID.closesettingEvent(), object: nil)
    }
    func _releaseHandler() {
        NotificationCenter.default.removeObserver(self, name: enGameEventID.undoEvent(), object: nil)
        NotificationCenter.default.removeObserver(self, name: enGameEventID.settingEvent(), object: nil)
        NotificationCenter.default.removeObserver(self, name: enGameEventID.demoEvent(), object: nil)
        NotificationCenter.default.removeObserver(self, name: enGameEventID.resumeEvent(), object: nil)
        NotificationCenter.default.removeObserver(self, name: enGameEventID.newgameEvent(), object: nil)
        NotificationCenter.default.removeObserver(self, name: enGameEventID.closesettingEvent(), object: nil)
    }
    
}
