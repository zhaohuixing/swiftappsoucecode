///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		PuzzleBoard+Extension.swift

Created by: Zhaohui Xing on 2/22/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension PuzzleChip {
    
    class func CreatePuzzleChip(size: CGSize, imageset: Int, chipDat: ChipData)-> PuzzleChip {
        let bWhiteColor : Bool = (imageset == 4)
        var chipImage : CGImage? = nil
        if bWhiteColor == true {
            chipImage = RenderHelper.CreatePuzzleChipWhiteNumberImage(imageSet: imageset, index: chipDat.labelindex)
        }
        else {
            chipImage = RenderHelper.CreatePuzzleChipImage(imageSet: imageset, index: chipDat.labelindex)
        }
        if chipImage == nil {
            if bWhiteColor == true {
                chipImage = RenderHelper.CreatePuzzleChipWhiteNumberImage(imageSet: 0, index: chipDat.labelindex)!
            }
            else {
                chipImage = RenderHelper.CreatePuzzleChipImage(imageSet: 0, index: chipDat.labelindex)!
            }
        }
        let chipTexture : SKTexture = SKTexture(cgImage: chipImage!)
        let chip = PuzzleChip(texture: chipTexture, size: size)
        chip.chipData = chipDat
        chip.setValue(SKAttributeValue(size: size), forAttribute: "a_size")
        return chip
    }
}

extension PuzzleChip {
    func CreateMultiStepsAction(path:[CGPoint], totalTime:CGFloat)->SKAction {
        var curPosition : CGPoint = self.position
        var totalLen : CGFloat = 0.0;
        var steps : [CGFloat] = [CGFloat]()
        for i in 0 ..< path.count {
            let curLen : CGFloat = CGFloat(sqrt(pow(Double(curPosition.x-path[i].x), 2.0) + pow(Double(curPosition.y-path[i].y), 2.0)))
            steps.append(curLen)
            totalLen += curLen
            curPosition = path[i]
        }
        
        var actions : [SKAction] = [SKAction]()
        curPosition = self.position
        for i in 0 ..< path.count {
            let timeAction : CGFloat = totalTime * steps[i]/totalLen
            actions.append(SKAction.move(to:path[i], duration: TimeInterval(timeAction)))
        }
        
        return SKAction.group(actions)
    }

    func MovePath(path:[CGPoint], totalTime:CGFloat) {
        SetMotionMode()
        var curPosition : CGPoint = self.position
        var totalLen : CGFloat = 0.0;
        var steps : [CGFloat] = [CGFloat]()
        for i in 0 ..< path.count {
            let curLen : CGFloat = CGFloat(sqrt(pow(Double(curPosition.x-path[i].x), 2.0) + pow(Double(curPosition.y-path[i].y), 2.0)))
            steps.append(curLen)
            totalLen += curLen
            curPosition = path[i]
        }
        
        var times : [Double] = [Double]()
        for i in 0 ..< path.count {
            let timeAction : Double = Double(totalTime * steps[i]/totalLen)
            times.append(timeAction)
        }
        
        RunPathStep(path:path, timeSteps:times, index:0)
    }
    
    func RunPathStep(path:[CGPoint], timeSteps:[Double], index:Int) {
        if 0 <= index && index < path.count {
            let pt = path[index]
            self.run(SKAction.move(to:pt, duration: timeSteps[index])) {
                self.position = pt
                self.RunPathStep(path: path, timeSteps: timeSteps, index: (index+1))
            }
        } else {
            self.CheckMatch()
            NotifyParentStopAnimation()
        }
    }

    func MoveTo(_ pt: CGPoint, _ timeInterval : CGFloat) {
        SetMotionMode()
        self.run(SKAction.move(to:pt, duration: Double(timeInterval))) {
            self.CheckMatch()
        }
    }

    func NotifyParentStopAnimation() {
        self.CheckMatch()
        let parent = self.parent as! PuzzleBoard
        parent.stopAnimation()
    }

    func BounceY(y: CGFloat, timeInterval : CGFloat) {
        SetMotionMode()
        let toPoint : CGPoint = CGPoint(x:self.position.x, y:(self.position.y+y))
        self.run(SKAction.move(to:toPoint, duration: Double(timeInterval))) {
            let backPoint = CGPoint(x:toPoint.x, y:toPoint.y-y)
            self.run(SKAction.move(to:backPoint, duration: Double(timeInterval))) {
                self.CheckMatch()
            }
        }
    }

    func BounceX(x: CGFloat, timeInterval : CGFloat) {
        SetMotionMode()
        let toPoint : CGPoint = CGPoint(x:self.position.x+x, y:(self.position.y))
        self.run(SKAction.move(to:toPoint, duration: Double(timeInterval))) {
            let backPoint = CGPoint(x:toPoint.x-x, y:toPoint.y)
            self.run(SKAction.move(to:backPoint, duration: Double(timeInterval))) {
                self.CheckMatch()
            }
        }
    }
}
