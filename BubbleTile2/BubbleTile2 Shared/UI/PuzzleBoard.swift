///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard.swift

Created by: Zhaohui Xing on 2/17/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

class PuzzleBoard : SKSpriteNode {
    unowned var m_GameScene : GameScene? = nil
    internal var m_fBubbleSize : CGFloat = 20
    var m_ChipCenters : Array<CGPoint> = Array<CGPoint>()

    public var gameScene : GameScene {
        get {
            guard let _ = m_GameScene else {
                fatalError("GameScene object is not assigned to Puzzl")
            }
            return m_GameScene!
        }
        set (newValue) {
            m_GameScene = newValue
        }
    }

    public var puzzle : Puzzle {
        get {
            guard m_GameScene != nil else {
                fatalError("No valid GameScene object to get puzzle property in Puzzle Board")
            }
            return m_GameScene!.sceneController.gameController.puzzle
        }
    }

    public var edge :  Int {
        get {
            return self.puzzle.edge
        }
    }
    public var type :  enGridType {
        get {
            return self.puzzle.puzzleType
        }
    }
    public var layout :  enGridLayout {
        get {
            return self.puzzle.layoutType
        }
    }

    func MatchCheck()->Bool {
        let count = self.children.count
        for i in 0 ... (count-1) {
            let chip = self.children[i] as! PuzzleChip
            chip.CheckMatch()
        }
        let bRet = self.puzzle.MatchCheck()
        return bRet
    }

    func setupPuzzle() {
        guard m_GameScene != nil else {
            fatalError("No valid objects for setupPuzzle")
        }
        self.removeAllChildren();
        m_ChipCenters.removeAll()
        GameLayout.SetPuzzleBoardStartPoint(self.position)
        //initializePuzzleSetting()
        let puzzle = self.puzzle
        let gridType = puzzle.puzzleType
        let nEdge = puzzle.edge
        let layOut = puzzle.layoutType
        let imageSet : Int = m_GameScene!.sceneController.getBubbleType().Int()
        m_fBubbleSize = GameLayout.GetChipSize(type: gridType, edge: nEdge)
        initializePuzzle(type: gridType, layout: layOut, edge: nEdge, imageSet: imageSet)
    }
    
    func checkIndexByLocation(point: CGPoint)->Int {
        var nRet : Int = -1
        
        for i in 0 ... m_ChipCenters.count-1 {
            let fOffset = m_fBubbleSize*0.5
            let left = m_ChipCenters[i].x - fOffset;
            let right = m_ChipCenters[i].x + fOffset;
            let top = m_ChipCenters[i].y + fOffset;
            let bottom = m_ChipCenters[i].y - fOffset;
            if left <= point.x && point.x <= right && bottom <= point.y && point.y <= top {
                nRet = i;
                break
            }
        }
        
        return nRet;
    }
 
    func NotifyParentInvalidPlayStep() {
        m_GameScene!.sceneController.NotifyInvalidPlayStep()
    }
    
    func StartChipsWinAnimation() {
        let count = self.children.count
        if count == 0 {
            return
        }
        for i in 0 ... (count-1) {
            let chip = self.children[i] as! PuzzleChip
            chip.StartWinAnimation()
        }
    }
}
