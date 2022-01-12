//
//  PuzzleTriangle.swift
//  BubbleTile2
//
//  Created by Zhaohui Xing on 2/22/19.
//  Copyright © 2019 Zhaohui Xing. All rights reserved.
//

import Foundation

extension Puzzle {
    func ShiftBubbleTileChipDiagonalPuzzle(_ step: GamePlayStep) {
        switch step.motion {
            case enBubbleMotion.BUBBLE_MOTION_HORIZONTAL:
                let nRowIndex = GetGridRow(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipHorizontalForward(row: nRowIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipHorizontalBackward(row: nRowIndex)
                    default:
                        return
                }
            case enBubbleMotion.BUBBLE_MOTION_60DIAGONAL:
                let nColIndex = GetGridColumn(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipDiagonal60Forward(column: nColIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipDiagonal60Backward(column: nColIndex)
                    default:
                        return
                }
            case enBubbleMotion.BUBBLE_MOTION_120DIAGONAL:
                let nColIndex = GetGridDiagonal120Column(index:step.index)
                switch step.direction {
                    case enMotionDirection.MOTION_DIRECTION_FORWARD:
                        ShiftBubbleTileChipDiagonal120Forward(column: nColIndex)
                    case enMotionDirection.MOTION_DIRECTION_BACKWARD:
                        ShiftBubbleTileChipDiagonal120Backward(column: nColIndex)
                    default:
                        return
                }
            default:
                return
        }
    }

}
