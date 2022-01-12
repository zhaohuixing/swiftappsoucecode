//
//  GameConstants.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 1/28/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

//Default is internal, so have to put "public"
public enum enGameType : Int {
    case BUBBLE_TILE = 0
    case JAGSAW_PUZZLE = 1
    
    func Int()->Int {
        var ret = 0;
        
        switch self {
            case .BUBBLE_TILE:
                ret = 0;
            case .JAGSAW_PUZZLE:
                ret = 1;
        }
        
        return ret;
    }
}

public enum enBubbleType : Int {
    case PUZZLE_BUBBLE_COLOR = 0
    case PUZZLE_BUBBLE_STAR = 1
    case PUZZLE_BUBBLE_FROG = 2
    case PUZZLE_BUBBLE_REDHEART = 3
    case PUZZLE_BUBBLE_BLUE = 4

    func Int()->Int {
        var ret = 0;

        switch self {
            case .PUZZLE_BUBBLE_COLOR:
                ret = 0;
            case .PUZZLE_BUBBLE_STAR:
                ret = 1;
            case .PUZZLE_BUBBLE_FROG:
                ret = 2;
            case .PUZZLE_BUBBLE_REDHEART:
                ret = 3;
            case .PUZZLE_BUBBLE_BLUE:
                ret = 4;
        }

        return ret;
    }
}

public enum enGridType : Int {
    case PUZZLE_GRID_SQUARE = 0
    case PUZZLE_GRID_TRIANGLE = 1
    case PUZZLE_GRID_DIAMOND = 2
    case PUZZLE_GRID_HEXAGON = 3

    func Int()->Int {
        var ret = 0;

        switch self {
            case .PUZZLE_GRID_SQUARE:
                ret = 0;
            case .PUZZLE_GRID_TRIANGLE:
                ret = 1;
            case .PUZZLE_GRID_DIAMOND:
                ret = 2;
            case .PUZZLE_GRID_HEXAGON:
                ret = 3;
        }

        return ret;
    }
}

public enum enGridLayout : Int {
    case PUZZLE_LALOUT_MATRIX = 0
    case PUZZLE_LALOUT_SNAKE = 1
    case PUZZLE_LALOUT_SPIRAL = 2
    
    func Int()->Int {
        var ret = 0;

        switch self {
            case .PUZZLE_LALOUT_MATRIX:
                ret = 0;
            case .PUZZLE_LALOUT_SNAKE:
                ret = 1;
            case .PUZZLE_LALOUT_SPIRAL:
                ret = 2;
        }

        return ret;
    }
}

public enum enTouchMotion : Int {
    case TOUCH_MOTION_NONE = -1
    case TOUCH_MOTION_HORIZONTAL_POSITIVE = 0
    case TOUCH_MOTION_HORIZONTAL_NEGATIVE = 1
    case TOUCH_MOTION_VERTICAL_UP = 2
    case TOUCH_MOTION_VERTICAL_DOWN = 3
    case TOUCH_MOTION_DIAGNOL30_POSITIVE = 4
    case TOUCH_MOTION_DIAGNOL30_NEGATIVE = 5
    case TOUCH_MOTION_DIAGNOL60_POSITIVE = 6
    case TOUCH_MOTION_DIAGNOL60_NEGATIVE = 7
    case TOUCH_MOTION_DIAGNOL120_POSITIVE = 8
    case TOUCH_MOTION_DIAGNOL120_NEGATIVE = 9
    case TOUCH_MOTION_DIAGNOL150_POSITIVE = 10
    case TOUCH_MOTION_DIAGNOL150_NEGATIVE = 11
}

public enum enBubbleMotion : Int {
    case BUBBLE_MOTION_NONE = 0
    case BUBBLE_MOTION_HORIZONTAL = 1
    case BUBBLE_MOTION_VERTICAL = 2
    case BUBBLE_MOTION_60DIAGONAL = 3
    case BUBBLE_MOTION_120DIAGONAL = 4
}

public enum enMotionDirection : Int {
    case MOTION_DIRECTION_NONE = 0
    case MOTION_DIRECTION_FORWARD = 1
    case MOTION_DIRECTION_BACKWARD = 2
}

public enum enGamePlayMode : Int {
    case GAME_MODE_NONE = 0
    case GAME_MODE_PLAY = 1
    case GAME_MODE_PLAY_TOUCH = 2
    case GAME_MODE_PLAY_SHIFTBUBBLE = 3
    case GAME_MODE_RESULT_WIN = 4
    case GAME_MODE_RESULT_LOSE = 5
    case GAME_MODE_CONFIGURE = 6
}

public enum enToolBarMode : Int {
    case TBMODE_NONE = 0
    case TBMODE_PLAY = 1
    case TBMODE_PLAY_TOUCH = 2
    case TBMODE_PLAY_SHIFTBUBBLE = 3
    case TBMODE_DEMO_PLAY_SHIFTBUBBLE = 4
    case TBMODE_DEMO_PLAY_END = 5
    case TBMODE_RESULT = 6
    case TBMODE_CONFIGURE = 7
}

extension enMotionDirection {
    func Reverse()->enMotionDirection {
        switch self {
            case enMotionDirection.MOTION_DIRECTION_NONE:
                return enMotionDirection.MOTION_DIRECTION_NONE
            case enMotionDirection.MOTION_DIRECTION_FORWARD:
                return enMotionDirection.MOTION_DIRECTION_BACKWARD
            case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                return enMotionDirection.MOTION_DIRECTION_FORWARD
        }
    }
}

public enum enGameEventID : Int {
    case GAME_EVENT_SETTING = 0
    case GAME_EVENT_NEWGAME = 1
    case GAME_EVENT_UNDO = 2
    case GAME_EVENT_DEMO = 3
    case GAME_EVENT_RESUME = 4
    case GAME_EVENT_CLOSESETTING = 5

    public var strEventID : String {
        get {
            return String(self.rawValue)
        }
    }
    
    public var eventName : Notification.Name {
        get {
            return Notification.Name(self.strEventID)
        }
    }
    
    //Must use static rather than class since enum type does not support class func,
    static func undoEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_UNDO.eventName
    }

    static func settingEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_SETTING.eventName
    }

    static func demoEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_DEMO.eventName
    }
    
    static func resumeEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_RESUME.eventName
    }

    static func newgameEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_NEWGAME.eventName
    }

    static func closesettingEvent()->Notification.Name {
        return enGameEventID.GAME_EVENT_CLOSESETTING.eventName
    }
}
