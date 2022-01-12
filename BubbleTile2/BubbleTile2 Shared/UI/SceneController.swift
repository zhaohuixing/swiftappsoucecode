///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	 
Package: 	BubbleTile2 Shared 
File: 		SceneController.swift

Created by: Zhaohui Xing on 2/16/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import SpriteKit

class SceneController {
    fileprivate unowned var m_GameScene : GameScene
    fileprivate var m_GameController : GameController
    fileprivate var m_Puzzle : PuzzleBoard
    
    private var m_GameStatus : enGamePlayMode = enGamePlayMode.GAME_MODE_NONE

    private var m_ptShiftStart : CGPoint = CGPoint()
    private var m_ptShiftEnd : CGPoint = CGPoint()
    private var m_nFirstTouchIndex : Int = -1;
    private var m_bDemoMode : Bool = false;
    
    init(scene : GameScene) {
        m_GameScene = scene
        m_GameController = GameController(scene: m_GameScene)
        m_Puzzle = PuzzleBoard.CreateWoodPuzzle(size: GameLayout.GetPuzzleSize())
        m_Puzzle.gameScene = m_GameScene
        m_GameScene.addChild(m_Puzzle)
        self.gameStatus = enGamePlayMode.GAME_MODE_NONE
        m_nFirstTouchIndex = -1;
    }
    
    public var gameController : GameController {
        get {
            return m_GameController
        }
    }

    public var puzzle : PuzzleBoard {
        get {
            return m_Puzzle
        }
    }

    public var demoMode : Bool {
        get {
            return m_bDemoMode
        }
        set (newValue) {
            m_bDemoMode = newValue
            startDemo()
        }
    }
    
    public var gameStatus : enGamePlayMode {
        get {
            return m_GameStatus
        }
        set (newValue) {
            m_GameStatus = newValue
            updateToolbarState()
        }
    }
    
    func getBubbleType()->enBubbleType {
        return self.gameController.bubbleType
    }

    func startNewGame() {
        setupGame()
    }
    
    func setupGame() {
        m_GameController.initializeGameSetting()
        m_Puzzle.setupPuzzle()
        m_GameController.createNewGame()
        m_Puzzle.ArrangePuzzle()
        self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
        m_bDemoMode = false
    }
    
    func setGameStatus(status: enGamePlayMode) {
        self.gameStatus = status
    }
    
    func stopPlayAnimation() {
        self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
        if m_bDemoMode == true {
            if canResumeGamePlay() {
                let step = self.gameController.GetNextDemoStep()
                if step != nil {
                    self.m_Puzzle.playGame(step!)
                }
                else {
                    if m_GameScene.isRecordingPreviewVideo() == true {
                        m_GameScene.winAnimationController.StartWinAnimation()
                    }
                }
            }
            return;
        }
        checkGameResult {
            self.enterGameWinResult();
        }
    }
    
    func NotifyInvalidPlayStep() {
        if m_bDemoMode == true {
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
            if canResumeGamePlay() {
                let step = self.gameController.GetNextDemoStep()
                if step != nil {
                    self.m_Puzzle.playGame(step!)
                }
            }
            return;
        }
    }
    
    func startPlayAnimation() {
        let enMotion : enTouchMotion = PuzzleHelper.CheckTouchMotion(startX: Double(m_ptShiftStart.x),
                                                                     startY: Double(m_ptShiftStart.y),
                                                                     endX: Double(m_ptShiftEnd.x),
                                                                     endY: Double(m_ptShiftEnd.y))
        if enMotion == enTouchMotion.TOUCH_MOTION_NONE {
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
            return
        }
        let gameStep : GamePlayStep = self.gameController.CreatePlayStep(index: self.m_nFirstTouchIndex, touchMotion: enMotion)
        if gameStep.IsValid() == false {
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
            return
        }
        self.gameController.playGame(step: gameStep, completion: self.m_Puzzle.playGame(_:))
    }

    func checkGameResult(completion:@escaping ()->Void) {
        let bSuccess = m_Puzzle.MatchCheck()
        if(bSuccess == true) {
            completion()
        }
    }
    
    func enterGameWinResult() {
        self.gameStatus = enGamePlayMode.GAME_MODE_RESULT_WIN
        m_Puzzle.StartChipsWinAnimation()
        m_GameScene.winAnimationController.StartWinAnimation()
        GameRatingController.IncrementWonCounts()
        GameRatingController.RatingMe()
    }
    
    func canShiftBubble()->Bool {
        let bRet : Bool = (m_GameStatus == enGamePlayMode.GAME_MODE_PLAY && !m_bDemoMode)
        return bRet
    }
    
    func getCenterPointFor(point: CGPoint)->CGPoint {
        var pt : CGPoint = point
        let index = m_Puzzle.checkIndexByLocation(point: point)
        if 0 <= index {
            pt = m_Puzzle.GetChipCenter(index: index)
        }
        return pt
    }
    
    func enterPlayTouchMode(point: CGPoint) {
        m_nFirstTouchIndex = m_Puzzle.checkIndexByLocation(point: point)
        if 0 <= m_nFirstTouchIndex {
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY_TOUCH
            m_ptShiftStart = point
        }
    }
    
    func movePlayTouch(to:CGPoint) {
        if 0 <= m_nFirstTouchIndex {
            m_ptShiftEnd = to;
            self.updateTouchIndicator()
        }
    }

    func endPlayTouch(stop:CGPoint, completion completionHandler:@escaping ()->Void) {
        if 0 <= m_nFirstTouchIndex {
            m_ptShiftEnd = stop
            completionHandler()
        }
    }
    

    func isPlayTouchMode()->Bool {
        return (m_GameStatus == enGamePlayMode.GAME_MODE_PLAY_TOUCH)
    }
    
    func canUndo()->Bool {
        let bCan : Bool = (m_GameStatus == enGamePlayMode.GAME_MODE_PLAY) && self.gameController.canUndo() && !m_bDemoMode
        return bCan
    }
    
    func playUndo() {
        self.gameStatus = enGamePlayMode.GAME_MODE_PLAY_SHIFTBUBBLE
        self.gameController.playUndo(completion: self.m_Puzzle.playGame(_:))
    }

    func undoCount()->Int {
        return self.gameController.getUndoStepCount()
    }

    func updateTouchIndicator() {
        let enMotion : enTouchMotion = PuzzleHelper.CheckTouchMotion(startX: Double(m_ptShiftStart.x),
                                                                     startY: Double(m_ptShiftStart.y),
                                                                     endX: Double(m_ptShiftEnd.x),
                                                                     endY: Double(m_ptShiftEnd.y))
        let centerPt : CGPoint = getCenterPointFor(point: m_ptShiftEnd)
        m_GameScene.showIndicator(at: centerPt, direction: enMotion)
    }
    
    func startDemo() {
        self.gameController.recordGamePlay()
        if self.gameController.ApplySnapshot(self.gameController.gameBegin) == true {
            m_Puzzle.ArrangePuzzle()
            m_bDemoMode = true //Must called before self.gameStatus assignment
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
            self.gameController.ResetDemoStep()
            if self.gameController.HasDemoStep() {
                m_Puzzle.run(SKAction.wait(forDuration: 1.5)) {
                    let step = self.gameController.GetNextDemoStep()
                    if step != nil {
                        self.m_Puzzle.playGame(step!)
                    }
                }
            }
        }
    }
    
    func resumeGamePlay() {
        if self.gameController.ApplySnapshot(self.gameController.gamePlay) == true {
            m_Puzzle.ArrangePuzzle()
            m_bDemoMode = false  //Must called before self.gameStatus assignment
            self.gameStatus = enGamePlayMode.GAME_MODE_PLAY
        }
    }
    
    func canResumeGamePlay()->Bool {
        if m_GameStatus == enGamePlayMode.GAME_MODE_PLAY_SHIFTBUBBLE {
            return false
        }

        return (m_bDemoMode && m_GameStatus == enGamePlayMode.GAME_MODE_PLAY)
    }
    
    func updateToolbarState() {
        m_GameScene.updateToolbarStatus(m_GameStatus)
    }
}
