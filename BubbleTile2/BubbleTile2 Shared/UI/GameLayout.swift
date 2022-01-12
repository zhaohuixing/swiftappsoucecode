///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		GameLayout.swift

Created by: Zhaohui Xing on 2/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit


class GameLayout {

    /* Both the static and class keywords allow us to attach variables to a class rather than to instances of a class.
       Where static and class differ is how they support inheritance: a static property is owned by the class and cannot
       be changed by subclasses, a class property it may be overridden if needed.
       
       Static functions are invoked by the class itself, not by an instance. Static functions can not be overridden.
       Class functions are also static functions but can be dynamically dispatched and can be overridden by subclasses
       unlike static functions
    */
    static var g_BoardStartPoint: CGPoint = CGPoint(x:0, y:0)
    static let g_EffectiveRatioBoardLength: CGFloat = 0.88
    static let SQURT_3 : CGFloat = 1.732050807568877
    static let g_DemoStepTime : CGFloat = 2.3 //Must larger than g_pathTime, otherwise will deadlock
    static let g_PathTime : CGFloat = 2.2
    static let g_StepTime : CGFloat = 2
    static var g_ScreenWidth : CGFloat = 800
    static var g_ScreenHeight : CGFloat = 600
    static var g_PuzzleRatio : CGFloat = 0.78
    static var g_PuzzleLength : CGFloat = 800
    static var g_ToolBarButtonSize : CGFloat = 40
    static var g_LayoutSignSize : CGFloat = 100
    static var g_bHasAdBanner : Bool = false
    static var g_AdBannerHeight : CGFloat = 50.0

    class func hasAdBanner()->Bool {
        return g_bHasAdBanner
    }
    
    class func SetAdBanner(_ bHasAd: Bool) {
        g_bHasAdBanner = bHasAd
    }

    class func AdBannerHeight()->CGFloat {
        #if os(iOS)
        return g_AdBannerHeight*UIScreen.main.scale
        #else
        return 0.0
        #endif
    }
    
    class func SetAdBannerHeight(_ height: CGFloat) {
        g_AdBannerHeight = height
    }

    class func GetPuzzleSizeRatio()->CGFloat {
        return g_PuzzleRatio
    }
    
    class func SetScreenSize(width: CGFloat, height: CGFloat) {
        g_ScreenWidth = width
        g_ScreenHeight = height
        let minSize : CGFloat = min(width, height)
        g_PuzzleLength = minSize*g_PuzzleRatio
        var ftbScale : CGFloat = 10.0;
        #if os(iOS)
        //if UIDevice.current.userInterfaceIdiom != .pad {
            ftbScale = 8.0
        //}
        #else
        ftbScale = 10.0;
        #endif

        g_ToolBarButtonSize = g_PuzzleLength/ftbScale
    }
    
    class func GetScreenSize()->(CGFloat, CGFloat) {
        return (g_ScreenWidth, g_ScreenHeight)
    }

    class func SetPuzzleLength(_ length: CGFloat) {
        g_PuzzleLength = length
    }

    class func GetPuzzleLength()-> CGFloat {
        /*#if os(OSX)
            let size : CGFloat = 800.0
        #elseif os(iOS)
            let size : CGFloat = 800.0
        #elseif os(tvOS)
            let size : CGFloat = 800.0
        #endif*/
        return g_PuzzleLength
    }

    class func GetToolBarButtonSize()-> CGFloat {
        //#if os(OSX)
        //    let size : CGFloat = 80.0
        //#elseif os(iOS)
        //    let size : CGFloat = 40.0
        //#elseif os(tvOS)
        //    let size : CGFloat = 40.0
        //#endif
        //return size
        return g_ToolBarButtonSize
    }

    class func GetlayoutSignSize()-> CGFloat {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            return g_ToolBarButtonSize*3.0
        }
        else {
            return  (g_ScreenWidth - GameLayout.GetPuzzleLength())*0.36
        }
#else
        return (g_ScreenWidth - GameLayout.GetPuzzleLength())*0.36
#endif
    }

    class func GetStepSignSize()-> CGFloat {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            return g_ToolBarButtonSize*1.5
        }
        else {
            return g_ToolBarButtonSize
        }
#else
        return g_ToolBarButtonSize*1.1
#endif
    }

    class func GetArrowSignSize()-> CGFloat {
#if !os(OSX)
        return GameLayout.GetPuzzleLength()*0.2
#endif
        //return 80
    }

    class func GetPuzzleNonFrameLength()-> CGFloat {
        return GetPuzzleLength()*g_EffectiveRatioBoardLength
    }

    class func GetPuzzleSize()-> CGSize {
        let length : CGFloat = GetPuzzleLength()
        let size : CGSize = CGSize(width: length, height: length)
        return size
    }
    
    class func SetPuzzleBoardStartPoint(_ point: CGPoint) {
        g_BoardStartPoint = point
    }
    
    class func GetPuzzleBoardStartPoint()->CGPoint {
        return g_BoardStartPoint
    }

    static func GetGridMaxSize(maxGrid:CGFloat)->CGFloat {
        let fSize : CGFloat = GetPuzzleLength()*g_EffectiveRatioBoardLength
        let fRet : CGFloat = fSize*maxGrid/(maxGrid+2.0)
        return fRet
    }

    static func GetGridCenter()->CGPoint {
        //let size : CGSize = GetPuzzleSize()
        //let cx = g_BoardStartPoint.x - size.width*0.5
        //let cy = g_BoardStartPoint.x + size.height*0.5
        //let ct : CGPoint = CGPoint(x: cx, y: cy)
        let ct : CGPoint = CGPoint(x: 0, y: 0)
        return ct
    }
    
    static func GetPuzzleMaxDemension(type gridType : enGridType, edge nEdge : Int)->CGFloat {
        var nRet : CGFloat = 0.0
        
        switch gridType {
        case enGridType.PUZZLE_GRID_TRIANGLE:
            nRet = CGFloat(nEdge)
        case enGridType.PUZZLE_GRID_SQUARE:
            nRet = CGFloat(nEdge)
        case enGridType.PUZZLE_GRID_DIAMOND:
            nRet = CGFloat(nEdge)*GameLayout.SQURT_3
        case enGridType.PUZZLE_GRID_HEXAGON:
            nRet = CGFloat(2*nEdge-1)
        }
        
        return nRet
    }
    

    static func GetChipSize(type gridType : enGridType, edge nEdge : Int)->CGFloat {
        let chipNumber : CGFloat = GetPuzzleMaxDemension(type: gridType, edge: nEdge)
        let rowLength : CGFloat = GetGridMaxSize(maxGrid:chipNumber)
        let fSize : CGFloat = rowLength/CGFloat(chipNumber)
        return fSize
    }

    static func GetDemoStepTime()->CGFloat {
        return g_DemoStepTime
    }

    static func GetPathAnimationTime()->CGFloat {
        return g_PathTime
    }

    static func GetStepAnimationTime()->CGFloat {
        return g_StepTime
    }

    static func GetChipYOffset()->CGFloat {
        return 0.133974596215561//(1.0 - SQURT_3*0.5)
    }

    static func GetChipXOffset()->CGFloat {
        return 0.154700538379252  //(2.0/SQURT_3-1.0)
    }
    
    static func GetGameStartAnimationTime()->TimeInterval {
        return 0.6
    }
}
