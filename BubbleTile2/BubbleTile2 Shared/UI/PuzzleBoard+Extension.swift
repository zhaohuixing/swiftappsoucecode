///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension.swift

Created by: Zhaohui Xing on 2/18/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleBoard {
    
    class func CreateTransparentPuzzle(size: CGSize)-> PuzzleBoard {
#if os(OSX)
        return PuzzleBoard(color: NSColor.red, size: size)
        //return PuzzleBoard(color: NSColor.clear, size: size)
#else
        return PuzzleBoard(color: UIColor.red, size: size)
        //return PuzzleBoard(color: UIColor.clear, size: size)
#endif
    }
    
    class func CreateWoodPuzzle(size: CGSize)-> PuzzleBoard {
        let boardImage : CGImage = RenderHelper.CreatePuzzleBoardImage()!
        let boardTexture : SKTexture = SKTexture(cgImage: boardImage)
        let puzzle : PuzzleBoard = PuzzleBoard(texture: boardTexture, size: size)
        //let puzzle : PuzzleBoard = PuzzleBoard()
        //puzzle.size = size
        //puzzle.addGlow()
        return puzzle
    }

}

extension PuzzleBoard {
    func initializePuzzle(type gridType:enGridType, layout layOut: enGridLayout, edge nEdge: Int, imageSet: Int) {
        switch gridType {
        case enGridType.PUZZLE_GRID_TRIANGLE:
            initializeTrianglePuzzle(layout: layOut, edge: nEdge, imageSet:imageSet)
        case enGridType.PUZZLE_GRID_SQUARE:
            initializeSquarePuzzle(layout: layOut, edge: nEdge, imageSet:imageSet)
        case enGridType.PUZZLE_GRID_DIAMOND:
            initializeDiamondPuzzle(layout: layOut, edge: nEdge, imageSet:imageSet)
        case enGridType.PUZZLE_GRID_HEXAGON:
            initializeHexagonPuzzle(layout: layOut, edge: nEdge, imageSet:imageSet)
        }
        forceShowChips()
    }
    
    func forceShowChips() {
        let count = self.children.count
        for i in 0 ... (count-1) {
            self.children[i].zPosition = 1.0
        }
    }
    
    func GetChipCenter(index: Int)->CGPoint {
        guard 0 <= index && index < m_ChipCenters.count else {
            fatalError("Index is not valid for querying chip center")
        }
        
        return m_ChipCenters[index]
    }
    
    func GetChipByArrayIndex(arrayIndex: Int)->PuzzleChip? {
        guard 0 < self.children.count && 0 <= arrayIndex && arrayIndex < self.children.count else {
            //fatalError("Array index is not valid for querying puzzle chip by array index")
            return nil
        }

        let childNode = self.children[arrayIndex] as! PuzzleChip
        return childNode
    }

    func GetChipByGridIndex(gridIndex: Int)->PuzzleChip? {
        guard 0 < self.children.count && 0 <= gridIndex && gridIndex < self.children.count else {
            //fatalError("Grid index is not valid for querying puzzle chip by grid index")
            return nil
        }

        for i in 0 ..< self.children.count {
            let childNode = self.children[i] as! PuzzleChip
            if childNode.realindex == gridIndex {
                return childNode
            }
        }
        
        return nil
    }
    
    func ShiftBubbleTileChip(step:GamePlayStep) {
        switch self.type {
            case enGridType.PUZZLE_GRID_TRIANGLE:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            case enGridType.PUZZLE_GRID_SQUARE:
                ShiftBubbleTileChipSquarePuzzle(step)
            case enGridType.PUZZLE_GRID_DIAMOND:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            case enGridType.PUZZLE_GRID_HEXAGON:
                ShiftBubbleTileChipDiagonalPuzzle(step)
            }
    }
    
    func stopAnimation() {
        m_GameScene!.sceneController.stopPlayAnimation()
    }

    func startAnimation() {
        //m_GameScene!.sceneController.startPlayAnimation()
        m_GameScene!.sceneController.setGameStatus(status:enGamePlayMode.GAME_MODE_PLAY_SHIFTBUBBLE)
    }

    func playGame(_ step: GamePlayStep) {
        ShiftBubbleTileChip(step:step)
    }
}
