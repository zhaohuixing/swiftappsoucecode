//
//  GameController.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 1/26/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

class GameController {
    unowned var m_GameScene : IPuzzleScene?
    fileprivate var m_Puzzle : Puzzle = Puzzle()
        
    private var m_GameType : enGameType = enGameType.BUBBLE_TILE
    
    private var m_UndoManager : UndoManager = UndoManager()
    private var m_ShaffleManager : ShaffleManager = ShaffleManager()
    private var m_ChipBubbleType: enBubbleType = enBubbleType.PUZZLE_BUBBLE_COLOR
    private var m_GameBeginSnapshot : [Int] = [Int]()
    private var m_GamePlaySnapshot : [Int] = [Int]()

    init() {
        m_GameScene = nil
        //m_Puzzle.Initialize(enGridType.PUZZLE_GRID_SQUARE, enGridLayout.PUZZLE_LALOUT_MATRIX, 3)
    }

    init(scene: IPuzzleScene) {
        m_GameScene = scene
        //m_Puzzle.Initialize(enGridType.PUZZLE_GRID_SQUARE, enGridLayout.PUZZLE_LALOUT_MATRIX, 3)
    }
    
    deinit {
        m_GameScene = nil
    }
    
    func Valid()->Bool {
        return m_Puzzle.Valid() && m_GameScene != nil
    }
    
    func CreatePlayStep(index: Int, touchMotion: enTouchMotion)->GamePlayStep {
        let gameStep : GamePlayStep = GamePlayStep()
        
        if self.puzzle.puzzleType == enGridType.PUZZLE_GRID_SQUARE {
            switch touchMotion {
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_POSITIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_FORWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_HORIZONTAL
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_NEGATIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_BACKWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_HORIZONTAL
                case enTouchMotion.TOUCH_MOTION_VERTICAL_UP,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL60_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL120_POSITIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_FORWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_VERTICAL
                case enTouchMotion.TOUCH_MOTION_VERTICAL_DOWN,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL60_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL120_NEGATIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_BACKWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_VERTICAL
                default:
                    return gameStep
            }
        }
        else {
            switch touchMotion {
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_POSITIVE:
                        if self.puzzle.puzzleType == enGridType.PUZZLE_GRID_TRIANGLE && index == 0 {
                            return gameStep
                        }
                        if self.puzzle.puzzleType == enGridType.PUZZLE_GRID_DIAMOND && (index == 0 || index == self.puzzle.number-1) {
                            return gameStep
                        }
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_FORWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_HORIZONTAL
                case enTouchMotion.TOUCH_MOTION_HORIZONTAL_NEGATIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL150_POSITIVE,
                     enTouchMotion.TOUCH_MOTION_DIAGNOL30_NEGATIVE:
                        if self.puzzle.puzzleType == enGridType.PUZZLE_GRID_TRIANGLE && index == 0 {
                            return gameStep
                        }
                        if self.puzzle.puzzleType == enGridType.PUZZLE_GRID_DIAMOND && (index == 0 || index == self.puzzle.number-1) {
                            return gameStep
                        }
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_BACKWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_HORIZONTAL
                case enTouchMotion.TOUCH_MOTION_DIAGNOL60_POSITIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_FORWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_60DIAGONAL
                case enTouchMotion.TOUCH_MOTION_DIAGNOL60_NEGATIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_BACKWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_60DIAGONAL
                case enTouchMotion.TOUCH_MOTION_DIAGNOL120_POSITIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_FORWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_120DIAGONAL
                case enTouchMotion.TOUCH_MOTION_DIAGNOL120_NEGATIVE:
                        gameStep.index = index
                        gameStep.direction = enMotionDirection.MOTION_DIRECTION_BACKWARD
                        gameStep.motion = enBubbleMotion.BUBBLE_MOTION_120DIAGONAL

                default:
                    return gameStep
            }
        }
        
        return gameStep
    }
    
    func playGame(step: GamePlayStep, completion completionHandler:@escaping (_ step: GamePlayStep)->Void) {
        m_UndoManager.AddStep(step)
        m_GameScene!.UpdateStepCount()
        completionHandler(step)
    }

    func playUndo(completion completionHandler:@escaping (_ step: GamePlayStep)->Void) {
        let gameStep : GamePlayStep? = m_UndoManager.GetStep()
        if gameStep != nil {
            gameStep!.direction = gameStep!.direction.Reverse()
            completionHandler(gameStep!)
        }
        m_GameScene!.UpdateStepCount()
    }

    func canUndo()->Bool {
        let bCan : Bool = (m_UndoManager.Empty() == false)
        return bCan
    }
    
    func getUndoStepCount()->Int {
        return m_UndoManager.Count()
    }

    func initializeGameSetting() {
        m_UndoManager.Reset()
        m_ShaffleManager.Reset()
        let gameSetting = GameSettingManager.GetGameSetting()
        m_GameType = gameSetting.gameType
        m_ChipBubbleType = gameSetting.bubbleType
        m_Puzzle.Initialize(gameSetting.gridType, gameSetting.gridLayout, gameSetting.edge)
    }
    
    func createNewGame() {
        m_ShaffleManager.ShaffleEasyLevel(type: m_Puzzle.puzzleType, edge:m_Puzzle.edge)

        while !m_ShaffleManager.Empty() {
            let step : GamePlayStep? = m_ShaffleManager.GetStep()
            if step != nil {
                m_Puzzle.ShiftBubbleTileChip(step:step!)
            }
        }
        m_Puzzle.MakeSnapshot(&m_GameBeginSnapshot)
    }
    
    func recordGamePlay() {
        m_Puzzle.MakeSnapshot(&m_GamePlaySnapshot)
    }
    
    func ApplySnapshot(_ indexlist : [Int])->Bool {
        return m_Puzzle.ApplySnapshot(indexlist)
    }

    func ResetDemoStep() {
        m_ShaffleManager.ResetUndoSteps()
    }
    
    func GetNextDemoStep()->GamePlayStep? {
        let step = m_ShaffleManager.PeekUndoStep()
        return step
    }

    func HasDemoStep()->Bool {
        let bHas = m_ShaffleManager.HasUndoStep()
        return bHas
    }
    
    func GetDemoStepCount()->Int {
        return m_ShaffleManager.UndeStepCount()
    }

    func GetDemoStep(index:Int)->GamePlayStep? {
        return m_ShaffleManager.UndoStep(index:index)
    }
}

extension GameController {
    public var gameScene : IPuzzleScene {
        get {
            return m_GameScene!
        }
        set (newValue) {
            m_GameScene = newValue;
        }
    }
    
    public var puzzle : Puzzle {
        get {
            return m_Puzzle
        }
    }
    
    public var chips : ChipList {
        get {
            return m_Puzzle.chips
        }
    }

    public var bubbleType : enBubbleType {
        get {
            return m_ChipBubbleType
        }
    }
    
    public var gamePlay : [Int] {
        get {
            return m_GamePlaySnapshot
        }
    }
    
    public var gameBegin : [Int] {
        get {
            return m_GameBeginSnapshot
        }
    }
}
