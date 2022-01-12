///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		SettingScene.swift

Created by: Zhaohui Xing on 4/7/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class SettingScene: SKScene, SKPickerHost {
    var m_BubblePicker : SKPicker? = nil
    var m_PuzzlePicker : SKPicker? = nil
    var m_LayoutPicker : SKPicker? = nil
    var m_EdgePicker : SKPicker? = nil
    var m_GameSetting = (gameType:enGameType.BUBBLE_TILE, gridType:enGridType.PUZZLE_GRID_SQUARE, gridLayout:enGridLayout.PUZZLE_LALOUT_MATRIX, bubbleType:enBubbleType.PUZZLE_BUBBLE_COLOR, edge:3)
    
    override init() {
        let fsize = GameLayout.GetScreenSize()
        super.init(size: CGSize(width:fsize.0, height:fsize.1))
        self.name = SettingScene.SettingSceneName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SettingScene {
    class func newSettingScene() -> SettingScene {
        let scene : SettingScene = SettingScene()
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.scaleMode = .aspectFill
        scene.createBasicBackGround()
        scene.createUIControls()
        return scene
    }
    
    func createBasicBackGround() {
        let tileSet = SKTileSet(named: "BkRedSet")!
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

    func createUIControls() {
        createTBButtons()
        createSettingPickers()
    }
    
    func loadSetting() {
        m_GameSetting = GameSettingManager.GetGameSetting()
        setPickersSetting()
    }
    
    func notifyCompletion(sender: SKPicker) {
        if sender == m_BubblePicker! {
            let nSelection = m_BubblePicker!.selection
            let bUpdate = (m_GameSetting.bubbleType.Int() != nSelection)
            m_GameSetting.bubbleType = enBubbleType(rawValue: nSelection)!
            setBubblePicker()
            setPuzzlePicker(bUpdate)
            setLayoutPicker(bUpdate)
            setEdgePicker(bUpdate)
            saveSetting()
            return
        }
        if sender == m_PuzzlePicker! {
            let nSelection = m_PuzzlePicker!.selection
            let bUpdate = (m_GameSetting.gridType.Int() != nSelection)
            m_GameSetting.gridType = enGridType(rawValue: nSelection)!
            setPuzzlePicker(false)
            setLayoutPicker(bUpdate)
            setEdgePicker(bUpdate)
            saveSetting()
            return
        }
        if sender == m_LayoutPicker! {
            let nSelection = m_LayoutPicker!.selection
            m_GameSetting.gridLayout = enGridLayout(rawValue: nSelection)!
            setLayoutPicker(false)
            saveSetting()
            return
        }
        if sender == m_EdgePicker! {
            let nSelection = m_EdgePicker!.selection
            m_GameSetting.edge = PuzzleHelper.GetPuzzleEdge(type: m_GameSetting.gridType, index: nSelection)
            if m_GameSetting.edge < 0 {
                m_GameSetting.edge = PuzzleHelper.GetPuzzleEdgeRange(type: m_GameSetting.gridType).0
            }
            setEdgePicker(false)
            saveSetting()
            return
        }

    }

}

extension SettingScene {
    private func setBubblePicker()
    {
        m_BubblePicker!.selection = m_GameSetting.bubbleType.Int()
    }
    
    private func reloadPuzzlePicker() {
        m_PuzzlePicker!.clear()
        let imageSet : Int = m_GameSetting.bubbleType.Int()
        var scale : CGFloat = 0.8
        let fSize : CGFloat = getSamplePuzzleImageSize()
        var image : CGImage = RenderHelper.CreateSamplePuzzleImage(imageSet: imageSet, type:enGridType.PUZZLE_GRID_SQUARE, edge: 3, size: fSize)!
        m_PuzzlePicker!.AddRawImageItem(image: image, imagescale: scale)
        image = RenderHelper.CreateSamplePuzzleImage(imageSet: imageSet, type:enGridType.PUZZLE_GRID_TRIANGLE, edge: 3, size: fSize)!
        m_PuzzlePicker!.AddRawImageItem(image: image, imagescale: scale)

        image = RenderHelper.CreateSamplePuzzleImage(imageSet: imageSet, type:enGridType.PUZZLE_GRID_DIAMOND, edge: 3, size: fSize)!
        scale = 0.98
        m_PuzzlePicker!.AddRawImageItem(image: image, imagescale: scale)

        scale = 0.8
        image = RenderHelper.CreateSamplePuzzleImage(imageSet: imageSet, type:enGridType.PUZZLE_GRID_HEXAGON, edge: 2, size: fSize)!
        m_PuzzlePicker!.AddRawImageItem(image: image, imagescale: scale)
        m_PuzzlePicker!.isUserInteractionEnabled = true
    }
    
    private func setPuzzlePicker(_ updateIcon: Bool)
    {
        if updateIcon == true {
            reloadPuzzlePicker()
        }
        m_PuzzlePicker!.selection = m_GameSetting.gridType.Int()
    }
    
    private func reloadLayoutPicker() {
        m_LayoutPicker!.clear()
        let imageSet : Int = m_GameSetting.bubbleType.Int()
        let type : enGridType = m_GameSetting.gridType
        var scale : CGFloat = 0.8
        if type == enGridType.PUZZLE_GRID_DIAMOND {
            scale = 0.98
        }
        var nEdge : Int = 3
        if type != enGridType.PUZZLE_GRID_HEXAGON {
            nEdge = 4
        }
        let fSize : CGFloat = getSamplePuzzleImageSize()
        var image : CGImage = RenderHelper.CreateLayoutPuzzleDemoImage(imageSet: imageSet, type:type, layout:enGridLayout.PUZZLE_LALOUT_MATRIX, edge: nEdge, size: fSize)!
        m_LayoutPicker!.AddRawImageItem(image: image, imagescale: scale)
        image = RenderHelper.CreateLayoutPuzzleDemoImage(imageSet: imageSet, type:type, layout:enGridLayout.PUZZLE_LALOUT_SNAKE, edge: nEdge, size: fSize)!
        m_LayoutPicker!.AddRawImageItem(image: image, imagescale: scale)

        image = RenderHelper.CreateLayoutPuzzleDemoImage(imageSet: imageSet, type:type, layout:enGridLayout.PUZZLE_LALOUT_SPIRAL, edge: nEdge, size: fSize)!
        m_LayoutPicker!.AddRawImageItem(image: image, imagescale: scale)

        m_LayoutPicker!.isUserInteractionEnabled = true
    }
    
    private func setLayoutPicker(_ updateIcon: Bool)
    {
        if updateIcon == true {
            reloadLayoutPicker()
        }
        m_LayoutPicker!.selection = m_GameSetting.gridLayout.Int()
    }
    
    private func reloadEdgePicker() {
        m_EdgePicker!.clear()
        let scale : CGFloat = 0.8
        let edges = PuzzleHelper.GetPuzzleEdgeRange(type: m_GameSetting.gridType)
        let imageSet : Int = m_GameSetting.bubbleType.Int()
        let bWhiteColor : Bool = (imageSet == 4)
        for nLabel in edges.minedges ... edges.maxedges {
            if bWhiteColor == true {
                let image : CGImage = RenderHelper.CreatePuzzleChipWhiteNumberImage(imageSet: imageSet, index: nLabel)!
                m_EdgePicker!.AddRawImageItem(image: image, imagescale: scale)
            }
            else {
                let image : CGImage = RenderHelper.CreatePuzzleChipImage(imageSet: imageSet, index: nLabel)!
                m_EdgePicker!.AddRawImageItem(image: image, imagescale: scale)
            }
        }
    }
    
    private func setEdgePicker(_ updateIcon: Bool)
    {
        if updateIcon == true {
            reloadEdgePicker()
        }
        var index : Int = PuzzleHelper.GetPuzzleEdgeIndex(type:m_GameSetting.gridType, edge:m_GameSetting.edge)
        if index < 0 {
            index = 0
            m_GameSetting.edge = PuzzleHelper.GetPuzzleEdge(type: m_GameSetting.gridType, index: index)
        }
        m_EdgePicker!.selection = index
    }

    private func setPickersSetting() {
        setBubblePicker()
        setPuzzlePicker(true)
        setLayoutPicker(true)
        setEdgePicker(true)
    }
    
    private func saveSetting() {
        GameSettingManager.SetGameSetting(setting: m_GameSetting)
    }
}

extension SettingScene {
    private func createTBButtons() {
        let size = CGSize(width: GameLayout.GetToolBarButtonSize(), height: GameLayout.GetToolBarButtonSize())
        let closeBtn = TBButton.CreateToolBarButton(size: size, image: "close", eventID: enGameEventID.GAME_EVENT_CLOSESETTING)
        closeBtn.position = CGPoint(x: self.size.width*0.5 - size.width*0.5, y:self.size.height*0.5 - size.height*0.5)
#if os(iOS)
        let y = self.size.height*(-0.5)+(GameLayout.AdBannerHeight()+size.height*0.5)
        closeBtn.position = CGPoint(x: self.size.width*0.5 - size.width*0.5, y: y)
#endif
        self.addChild(closeBtn)
    }

    private func createSettingPickers() {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            createPhoneSettingPickers()
            return
        }
#endif
        createLandscapeSettingPickers()
    }

    private static var g_StartRatio : CGFloat = 0.32
    private func StartRatio()->CGFloat {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad {
            SettingScene.g_StartRatio = 0.315
        }
#endif
        return SettingScene.g_StartRatio
    }
    private func getBubbleControlLeftTop(_ isPhone: Bool)->CGPoint {
        var pt : CGPoint = CGPoint(x:-self.size.width*StartRatio(), y:self.size.height*0.3)
        
        if isPhone == true {
            pt.x = 0.0//-self.size.width*0.1
        }
        return pt
    }

    private func getSamplePuzzleImageSize()->CGFloat {
        let fSize : CGFloat = (self.size.width < self.size.height ? self.size.width : self.size.height) * 0.5
        return fSize
    }
    
    private func getPuzzleControlLeftTop(_ isPhone: Bool)->CGPoint {
        let change = PickerWidth(isPhone)+PickerInterval(isPhone)
        var pt : CGPoint = CGPoint(x:-self.size.width*StartRatio()+change, y:self.size.height*0.3)
        
        if isPhone == true {
            pt.x = 0.0
            pt.y = pt.y - (PickerHeight(isPhone)+PickerInterval(isPhone))
        }
        return pt
    }

    private func getLayoutControlLeftTop(_ isPhone: Bool)->CGPoint {
        let change = PickerWidth(isPhone)+PickerInterval(isPhone)
        var pt : CGPoint = CGPoint(x:-self.size.width*StartRatio()+change*2.0, y:self.size.height*0.3)
        
        if isPhone == true {
            pt.x = 0.0
            pt.y = pt.y - 2.0*(PickerHeight(isPhone)+PickerInterval(isPhone))
        }
        return pt
    }

    private func getEdgeControlLeftTop(_ isPhone: Bool)->CGPoint {
        let change = PickerWidth(isPhone)+PickerInterval(isPhone)
        var pt : CGPoint = CGPoint(x:-self.size.width*StartRatio()+change*3.0, y:self.size.height*0.3)
        
        if isPhone == true {
            pt.x = 0.0
            pt.y = pt.y - 3.0*(PickerHeight(isPhone)+PickerInterval(isPhone))
        }
        return pt
    }

    private func PickerWidth(_ isPhone : Bool)->CGFloat {
        var width : CGFloat = self.size.width*0.2
        if isPhone == true {
            width = self.size.width*0.6
        }
        return width
    }

    private func PickerHeight(_ isPhone : Bool)->CGFloat {
        var height : CGFloat = self.size.height*0.4
        if isPhone == true {
            height = self.size.height*0.1
        }
        return height
    }

    private func PickerInterval(_ isPhone : Bool)->CGFloat {
        var change : CGFloat = self.size.width*0.02
        if isPhone == true {
            change = self.size.height*0.04
        }
        return change
    }

    private func LabelPickerInterval(_ isPhone : Bool)->CGFloat {
        var change : CGFloat = self.size.width*0.006
        if isPhone == true {
            change = self.size.height*0.005
        }
        return change
    }

    private func PickerSize(_ isPhone : Bool)->CGSize {
        let size : CGSize = CGSize(width: PickerWidth(isPhone), height: PickerHeight(isPhone))
        return size
    }

    private func createBubbleControls(_ isPhone: Bool) {
        let bubbleLabel : SKLabelNode = SettingScene.SettingLabel(StringHelper.Bubble())
        self.addChild(bubbleLabel)
        let pt : CGPoint = getBubbleControlLeftTop(isPhone)
        bubbleLabel.position = pt
        
        let size = PickerSize(isPhone)
        
        var bkImage : SKTexture
        if isPhone == true {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .horizontal)
        }
        else {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .veritcal)
        }
        let bubblePicKer = SKPicker(texture: bkImage, size: size)
        if isPhone == true {
            bubblePicKer.layout = .horizontal
            bubblePicKer.position = CGPoint(x: 0.0, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        else {
            bubblePicKer.layout = .veritcal
            bubblePicKer.position = CGPoint(x: pt.x, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        bubblePicKer.displayItems = 3
        bubblePicKer.zPosition = 1
        bubblePicKer.Initialize()
        bubblePicKer.setHost(self)
        m_BubblePicker = bubblePicKer
        addChild(m_BubblePicker!)
    }

    private func createPuzzleControls(_ isPhone: Bool) {
        let puzzleLabel : SKLabelNode = SettingScene.SettingLabel(StringHelper.Puzzle())
        self.addChild(puzzleLabel)
        let pt : CGPoint = getPuzzleControlLeftTop(isPhone)
        puzzleLabel.position = pt
        
        let size = PickerSize(isPhone)
        
        var bkImage : SKTexture
        if isPhone == true {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .horizontal)
        }
        else {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .veritcal)
        }
        let puzzlePicKer = SKPicker(texture: bkImage, size: size)
        if isPhone == true {
            puzzlePicKer.layout = .horizontal
            puzzlePicKer.position = CGPoint(x: 0.0, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        else {
            puzzlePicKer.layout = .veritcal
            puzzlePicKer.position = CGPoint(x: pt.x, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        puzzlePicKer.displayItems = 3
        puzzlePicKer.zPosition = 1
        puzzlePicKer.Initialize()
        puzzlePicKer.setHost(self)
        m_PuzzlePicker = puzzlePicKer
        addChild(m_PuzzlePicker!)
    }

    private func createLayoutControls(_ isPhone: Bool) {
        let layoutLabel : SKLabelNode = SettingScene.SettingLabel(StringHelper.Layout())
        self.addChild(layoutLabel)
        let pt : CGPoint = getLayoutControlLeftTop(isPhone)
        layoutLabel.position = pt
        
        let size = PickerSize(isPhone)
        
        var bkImage : SKTexture
        if isPhone == true {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .horizontal)
        }
        else {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .veritcal)
        }
        let layoutPicKer = SKPicker(texture: bkImage, size: size)
        if isPhone == true {
            layoutPicKer.layout = .horizontal
            layoutPicKer.position = CGPoint(x: 0.0, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        else {
            layoutPicKer.layout = .veritcal
            layoutPicKer.position = CGPoint(x: pt.x, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        layoutPicKer.displayItems = 3
        layoutPicKer.zPosition = 1
        layoutPicKer.Initialize()
        layoutPicKer.setHost(self)
        m_LayoutPicker = layoutPicKer
        addChild(m_LayoutPicker!)
    }

    private func createEdgeControls(_ isPhone: Bool) {
        let edgeLabel : SKLabelNode = SettingScene.SettingLabel(StringHelper.Edge())
        self.addChild(edgeLabel)
        let pt : CGPoint = getEdgeControlLeftTop(isPhone)
        edgeLabel.position = pt
        
        let size = PickerSize(isPhone)
        
        var bkImage : SKTexture
        if isPhone == true {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .horizontal)
        }
        else {
            bkImage = SKPickerRender.createDefaultGradientTexture(size: size, layout: .veritcal)
        }
        let edgePicKer = SKPicker(texture: bkImage, size: size)
        if isPhone == true {
            edgePicKer.layout = .horizontal
            edgePicKer.position = CGPoint(x: 0.0, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        else {
            edgePicKer.layout = .veritcal
            edgePicKer.position = CGPoint(x: pt.x, y: pt.y - (size.height*0.5+LabelPickerInterval(isPhone)))
        }
        edgePicKer.displayItems = 3
        edgePicKer.zPosition = 1
        edgePicKer.Initialize()
        edgePicKer.setHost(self)
        m_EdgePicker = edgePicKer
        addChild(m_EdgePicker!)
    }

    private func loadBubbleIcons() {
        let scale : CGFloat = 0.8
        for i in 0 ... 4 {
            let sImageSet : String = "nb\(i)"
            m_BubblePicker!.AddImageItem(imageset: sImageSet, imagescale: scale)
        }
        m_BubblePicker!.selection = 0
    }

    
    private func createPhoneSettingPickers() {
        createBubbleControls(true)
        createPuzzleControls(true)
        createLayoutControls(true)
        createEdgeControls(true)
        loadBubbleIcons();
    }
    
    private func createLandscapeSettingPickers() {
        createBubbleControls(false)
        createPuzzleControls(false)
        createLayoutControls(false)
        createEdgeControls(false)
        loadBubbleIcons();
    }

}

extension SettingScene {
    class func SettingLabel(_ text : String)->SKLabelNode {
        let fontName : String = "Georgia-Bold"
        var fontSize : CGFloat = 20.0
#if os(OSX)
        let aFont : NSFont = NSFont(name: fontName, size: fontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:NSColor.blue] as CFDictionary
#else
        if UIDevice.current.userInterfaceIdiom != .pad {
            fontSize = GameLayout.GetScreenSize().1 * 0.018
        }
        else {
            fontSize = GameLayout.GetScreenSize().1 * 0.04
        }

#if os(tvOS)
        let aFont : UIFont = UIFont.boldSystemFont(ofSize:fontSize)
//        let aFont : UIFont = UIFont(name: "Times New Roman Bold", size: fontSize)!
#else
        let aFont : UIFont = UIFont(name: fontName, size: fontSize)!
#endif
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:UIColor.blue] as CFDictionary
#endif
        // create the attributed string
        let textCF = CFAttributedStringCreate(nil, text as CFString, attr)!
        let labelNode : SKLabelNode = SKLabelNode(attributedText: textCF)
        return labelNode
    }

    class func GetEdgePickerFontName()->String {
#if os(tvOS)
        let aFont : UIFont = UIFont.boldSystemFont(ofSize:20)
        return aFont.fontName
#endif
        let fontName : String = "Times New Roman Bold"
        return fontName
    }

}

extension SettingScene {
    class func SettingSceneName()->String {
        return "Setting Scene"
    }
}
