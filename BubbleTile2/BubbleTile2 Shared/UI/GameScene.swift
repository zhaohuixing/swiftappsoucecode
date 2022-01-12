///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	 
Package: 	BubbleTile2 Shared 
File: 		GameScene.swift

Created by: Zhaohui Xing on 1/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/


import SpriteKit

class GameScene: SKScene {
    
    private var m_GameController : SceneController?
    private var m_Toolbar : ToolBarPanel? = nil
    private var m_layoutSign : LayoutSign? = nil
    private var m_stepSign : StepSign? = nil
    private var m_IndicatorController : MotionIndicatorController? = nil
    private var m_WinAnimationController : WinAnimationController? = nil

    func isRecordingPreviewVideo()->Bool {
        return false;
    }
    
    override init() {
        let fsize = GameLayout.GetScreenSize()
        
        super.init(size: CGSize(width:fsize.0, height:fsize.1))
        m_IndicatorController = MotionIndicatorController(scene:self)
        m_WinAnimationController = WinAnimationController(scene: self)
        self.name = GameScene.GameSceneName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    class func newGameScene() -> GameScene {
        return newBlankGameScene();
    }
    
    class func newBlankGameScene()->GameScene {
        let scene : GameScene = GameScene()
        let fsize = GameLayout.GetScreenSize()
        scene.size = CGSize(width:fsize.0, height:fsize.1)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.createBasicBackGround()
        scene.scaleMode = .aspectFill //.resizeFill //.
        scene.initializeGameController()
        scene.initializeToolBar()
        scene.initializeLayoutSign()
        scene.initializeStepSign()
        return scene
    }

    public var indicatorController : MotionIndicatorController {
        get {
            if let _ = m_IndicatorController {
                return m_IndicatorController!
            }
            else {
                m_IndicatorController = MotionIndicatorController(scene:self)
                return m_IndicatorController!
            }
        }
    }

    public var winAnimationController : WinAnimationController {
        get {
            if let _ = m_WinAnimationController {
                return m_WinAnimationController!
            }
            else {
                m_WinAnimationController = WinAnimationController(scene: self)
                return m_WinAnimationController!
            }
        }
    }

    public var sceneController : SceneController {
        get {
            if let _ = m_GameController {
                return m_GameController!
            }
            else {
                initializeGameController ()
                return m_GameController!
            }
        }
    }
    
    func GetSceneMinSize()->CGFloat {
        let width = self.size.width
        let height = self.size.height
        let fRet = (width > height) ? height : width
        return fRet
    }

    func initializeGameController () {
        m_GameController = SceneController(scene : self)
    }
    
    func startPlayTouchMode(at:CGPoint) {
        self.sceneController.enterPlayTouchMode(point: at)
        let centerPt : CGPoint = self.sceneController.getCenterPointFor(point: at)
        self.indicatorController.ShowTouchStartIndicator(location: centerPt, gridType: self.sceneController.puzzle.type)
    }
    
    func movePlayTouch(to:CGPoint) {
        self.indicatorController.EndStartIndicator()
        self.sceneController.movePlayTouch(to: to)
    }

    func endPlayTouch(stop: CGPoint) {
        self.indicatorController.EndAllIndicators()
        self.sceneController.endPlayTouch(stop: stop){
            self.sceneController.startPlayAnimation()
        }
    }
    
    func showIndicator(at: CGPoint, direction: enTouchMotion) {
//        if self.indicatorController.isAnimation == false {
            self.indicatorController.ShowTouchMotionIndicator(location: at, direction: direction, gridType: self.sceneController.puzzle.type)
//        }
//        else {
//            return
//        }
    }
    

    func CanUndo()->Bool {
        let bCan : Bool = self.sceneController.canUndo()
        return bCan
    }
    
    func Undo() {
        self.sceneController.playUndo()
        
    }

    func setUpScene() {
        startNewGame()
    }

    func startNewGame() {
        self.sceneController.startNewGame()
        self.winAnimationController.EndWinAnimation()
        updateStepSign(0)
        checkGameResult()
    }

    func resumeGamePlay() {
        if self.isRecordingPreviewVideo() == true {
            self.winAnimationController.EndWinAnimation()
        }
        
        self.sceneController.resumeGamePlay()
    }
    
    func createBasicBackGround() {
        let tileSet = SKTileSet(named: "BKGreenSet")!

        let rows = 1 + Int(self.size.height/tileSet.defaultTileSize.height);
        let cols = 1 + Int(self.size.width/tileSet.defaultTileSize.width);
        let map = SKTileMapNode(tileSet: tileSet, columns: cols, rows: rows, tileSize:tileSet.defaultTileSize)
        map.enableAutomapping = true
        let g = tileSet.tileGroups.first
        for col in 0..<cols {
            for row in 0..<rows {
                map.setTileGroup(g, forColumn: col, row: row)
            }
        }
        self.addChild(map);
    
    }

    func checkGameResult() {
        m_GameController!.checkGameResult {
            self.m_GameController!.enterGameWinResult()
        }
    }
    
    func initializeToolBar() {
        let fSize = GameLayout.GetToolBarButtonSize()
        let toolbar = ToolBarPanel()
        toolbar.size = CGSize(width: fSize*5.0, height: fSize)
        //let screensize = GameLayout.GetScreenSize()
        var x = -(self.size.width - fSize*5.0)*0.5
        var y : CGFloat = (self.size.height - fSize)*0.5
    #if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            x = 0.0
            y = y*(-1.0)
            if GameLayout.hasAdBanner() {
                y = y + GameLayout.AdBannerHeight()
            }
        }
    #endif

        toolbar.position = CGPoint(x: x, y: y)
        toolbar.CreateToolBarButtons()
        m_Toolbar = toolbar
        addChild(toolbar)
    }
    
    func updateToolbarStatus(_ gameStatus : enGamePlayMode) {
        if let toolbar = m_Toolbar {
            var btnStatus : enToolBarMode = enToolBarMode.TBMODE_NONE
            let bDemoMode = self.sceneController.demoMode
            switch (gameStatus) {
                case enGamePlayMode.GAME_MODE_PLAY:
                    btnStatus = enToolBarMode.TBMODE_PLAY
                    if bDemoMode == true {
                        btnStatus = enToolBarMode.TBMODE_DEMO_PLAY_END
                    }
                case enGamePlayMode.GAME_MODE_PLAY_TOUCH:
                    btnStatus = enToolBarMode.TBMODE_PLAY_TOUCH
                case enGamePlayMode.GAME_MODE_PLAY_SHIFTBUBBLE:
                    btnStatus = enToolBarMode.TBMODE_PLAY_SHIFTBUBBLE
                    if bDemoMode == true {
                        btnStatus = enToolBarMode.TBMODE_DEMO_PLAY_SHIFTBUBBLE
                    }
                case enGamePlayMode.GAME_MODE_RESULT_WIN:
                    btnStatus = enToolBarMode.TBMODE_RESULT
                case enGamePlayMode.GAME_MODE_RESULT_LOSE:
                    btnStatus = enToolBarMode.TBMODE_RESULT
                case enGamePlayMode.GAME_MODE_CONFIGURE:
                    btnStatus = enToolBarMode.TBMODE_CONFIGURE
                default:
                    btnStatus = enToolBarMode.TBMODE_NONE
            }
            
            toolbar.UpdateToobarButton(btnStatus)
        }
    }
    
    func initializeLayoutSign() {
        let fSize = GameLayout.GetlayoutSignSize()
        let layoutSign = LayoutSign()
        layoutSign.size = CGSize(width: fSize, height: fSize)
        var x = (self.size.width - fSize)*0.5
        var y : CGFloat = (self.size.height - fSize)*0.5
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            x = 0.0
            y = GameLayout.GetPuzzleLength()*0.5+GameLayout.GetlayoutSignSize()*0.8
        }
#endif
        layoutSign.position = CGPoint(x: x, y: y)
        m_layoutSign = layoutSign
        addChild(layoutSign)
    }
    
    func loadLayoutSign() {
        let gameSetting = GameSettingManager.GetGameSetting()
        let imageSet : Int = gameSetting.bubbleType.Int()
        let type : enGridType = gameSetting.gridType
        let layout : enGridLayout = gameSetting.gridLayout
        var nEdge : Int = 3
        if type != enGridType.PUZZLE_GRID_HEXAGON {
            nEdge = 4
        }
        m_layoutSign?.UpdateLayoutSign(imageSet: imageSet, type: type, layout: layout, edge: nEdge)
    }

    func initializeStepSign() {
        let fSize = GameLayout.GetStepSignSize()
        let stepSign = StepSign()
        stepSign.size = CGSize(width: fSize, height: fSize)
        var x = (self.size.width - fSize)*0.5-(GameLayout.GetlayoutSignSize()+10)
        var y : CGFloat = (self.size.height - fSize)*0.5
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            x = 0.0
            y = -GameLayout.GetPuzzleLength()*0.5 - fSize*0.6
        }
#endif
        stepSign.position = CGPoint(x: x, y: y)
        stepSign.InitializeStepUI()
        m_stepSign = stepSign
        addChild(stepSign)
    }
    
    func updateStepSign(_ number: Int) {
        m_stepSign!.UpdateSteps(number)
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
}

