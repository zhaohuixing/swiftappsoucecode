///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		GameRatingController.swift

Created by: Zhaohui Xing on 5/25/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import Foundation
import StoreKit

class GameRatingController {
    
    static let g_RatingCount = 5
    
    private class func GetSuiteName()->String {
        return String("BubbleTile2Rating")
    }

    class func GetLastRatingVersion()->String {
        let userPref = UserDefaults(suiteName:GetSuiteName())
        var lastVersion : String? = userPref!.string(forKey: GetLastVersionKey())
        if lastVersion == nil {
            lastVersion = "0"
        }
        return lastVersion!
    }

    class func SetLastRatingVersion(version :String) {
        let userPref = UserDefaults(suiteName:GetSuiteName())
         userPref!.set(version, forKey: GetLastVersionKey())
    }

    class func IncrementWonCounts(){
        let userPref = UserDefaults(suiteName:GetSuiteName())
        let wonCount : Int = userPref!.integer(forKey: GetWonCountKey()) + 1
        userPref!.set(wonCount, forKey:GetWonCountKey())
    }

    class func SetWonCount(count :Int) {
        let userPref = UserDefaults(suiteName:GetSuiteName())
        userPref!.set(count, forKey:GetWonCountKey())
    }

    class func GetWonCount()->Int {
        let userPref = UserDefaults(suiteName:GetSuiteName())
        let wonCount : Int = userPref!.integer(forKey: GetWonCountKey())
        return wonCount
    }


    class func RatingMe() {
        guard  let currentVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String else {
            return
        }
        let lastRatingVersion = GetLastRatingVersion()
        let wonCount = GetWonCount()
        if wonCount >= g_RatingCount && currentVersion != lastRatingVersion {
            let oneSecondsFromNow = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: oneSecondsFromNow) {
                SKStoreReviewController.requestReview()
                SetLastRatingVersion(version : currentVersion)
                SetWonCount(count: 0)
            }
        }
    }
    
    private class func GetLastVersionKey()->String {
        return String("LasetVersion")
    }

    private class func GetWonCountKey()->String {
        return String("Won Numbers")
    }

    /*
    private class func GetGridTypeKey()->String {
        return String("GridType")
    }

    private class func GetGridLayoutKey()->String {
        return String("GridLayout")
    }

    private class func GetBubbleTypeKey()->String {
        return String("BubbleType")
    }

    private class func GetPuzzleEdgeKey()->String {
        return String("Edges")
    }

    class func GetGameSetting()->(gameType:enGameType, gridType: enGridType, gridLayout: enGridLayout, bubbleType: enBubbleType, edge:Int) {
        var gameSetting = (gameType:enGameType.BUBBLE_TILE, gridType:enGridType.PUZZLE_GRID_SQUARE, gridLayout:enGridLayout.PUZZLE_LALOUT_MATRIX, bubbleType:enBubbleType.PUZZLE_BUBBLE_COLOR, edge:3)
        
        let userPref = UserDefaults(suiteName:GetSuiteName())
        if userPref != nil {
            gameSetting.gameType = enGameType(rawValue: userPref!.integer(forKey: GetGameTypeKey())) ?? enGameType.BUBBLE_TILE
            gameSetting.gridType = enGridType(rawValue: userPref!.integer(forKey: GetGridTypeKey())) ?? enGridType.PUZZLE_GRID_SQUARE
            gameSetting.gridLayout = enGridLayout(rawValue: userPref!.integer(forKey: GetGridLayoutKey())) ?? enGridLayout.PUZZLE_LALOUT_MATRIX
            gameSetting.bubbleType = enBubbleType(rawValue: userPref!.integer(forKey: GetBubbleTypeKey())) ?? enBubbleType.PUZZLE_BUBBLE_COLOR
            gameSetting.edge = userPref!.integer(forKey: GetPuzzleEdgeKey())
            if gameSetting.edge == 0 {
                gameSetting.edge = 3
            }
        }
        
        return gameSetting
    }

    class func SetGameSetting(setting: (gameType:enGameType, gridType: enGridType, gridLayout: enGridLayout, bubbleType: enBubbleType, edge:Int)) {
        let userPref = UserDefaults(suiteName:GetSuiteName())

        if userPref != nil {
            userPref!.set(setting.gameType.Int(), forKey:GetGameTypeKey())
            userPref!.set(setting.gridType.Int(), forKey:GetGridTypeKey())
            userPref!.set(setting.gridLayout.Int(), forKey:GetGridLayoutKey())
            userPref!.set(setting.bubbleType.Int(), forKey:GetBubbleTypeKey())
            userPref!.set(setting.edge, forKey:GetPuzzleEdgeKey())
        }
        
    }*/

}
