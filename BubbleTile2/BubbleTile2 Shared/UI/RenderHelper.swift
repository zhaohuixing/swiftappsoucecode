///**
/**
Workspace:      BubbleTile2
Project: 	BubbleTile2
Target:  	BubbleTile2 
Package: 	BubbleTile2 
File: 		RenderHelper.swift

Created by: Zhaohui Xing on 2/19/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit

extension CGContext {
    func drawLine(start:CGPoint, end:CGPoint) {
        beginPath()
        move(to:start)
        addLine(to: end)
        drawPath(using: .stroke)
    }
}

class RenderHelper {
    class func LoadResourceImage(name:String)->CGImage? {
    #if os(OSX)
        let image : CGImage? = NSImage(named: name)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        return image
    #else
        let image : CGImage? = UIImage(named: name)?.cgImage
        return image
    #endif
    }
    
    class func CreatePuzzleBoardImage()->CGImage? {
        let pFrameImage : CGImage? = RenderHelper.LoadResourceImage(name: "BoardFrame")
        let pBaseImage : CGImage? = RenderHelper.LoadResourceImage(name: "BoardBase")
   
        guard pFrameImage != nil && pBaseImage != nil else {
            return nil
        }
        
        let fFrameWidth : CGFloat = CGFloat(pFrameImage!.width)
        let fFrameHeight : CGFloat = CGFloat(pFrameImage!.height)
        let fBaseWidth : CGFloat = CGFloat(pBaseImage!.width)
        let fBaseHeight : CGFloat = CGFloat(pBaseImage!.height)
        let cx = fFrameWidth*0.5
        let cy = fFrameHeight*0.5
        let baseRect : CGRect = CGRect(x: cx-fBaseWidth*0.5, y: cy-fBaseHeight*0.5, width: fBaseWidth, height: fBaseHeight)
        let frameRect : CGRect = CGRect(x: 0.0, y: 0.0, width: fFrameWidth, height: fFrameHeight)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(fFrameWidth), height: Int(fFrameHeight), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: pBaseImage!.bitmapInfo.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }
        
        bitmapContext!.saveGState()
        bitmapContext!.draw(pBaseImage!, in:baseRect)
        
        bitmapContext!.setLineWidth(2.0)
        bitmapContext!.setStrokeColor(red: 0.3, green: 0.1, blue: 0.1, alpha: 0.8)
        var pt1 : CGPoint = CGPoint(x: cx-fBaseWidth*0.5+1, y: cy+fBaseHeight*0.5-1)
        var pt2 : CGPoint = CGPoint(x: cx+fBaseWidth*0.5-1, y: cy+fBaseHeight*0.5-1)
        var pt3 : CGPoint = CGPoint(x: cx+fBaseWidth*0.5-1, y: cy-fBaseHeight*0.5+1)
        bitmapContext!.drawLine(start: pt1, end: pt2)
        bitmapContext!.drawLine(start: pt2, end: pt3);

        let shadowClrSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let shadowSize : CGSize = CGSize(width:5, height:5)
        let clrvals : [CGFloat] = [0.3, 0.2, 0.2, 0.8]
        let shadowClrs : CGColor = CGColor(colorSpace: shadowClrSpace, components: clrvals)!
        bitmapContext!.setShadow(offset: shadowSize, blur: 5.0, color: shadowClrs)
        bitmapContext!.draw(pFrameImage!, in:frameRect)
        
        bitmapContext!.setStrokeColor(red: 0.2, green: 0.1, blue: 0.1, alpha: 0.5)
        pt1 = CGPoint(x: 1, y: 1)
        pt2 = CGPoint(x: fFrameWidth-1, y: 1)
        pt3 = CGPoint(x: fFrameWidth-1, y: fFrameHeight-1)
        let pt4 : CGPoint = CGPoint(x: 1, y: fFrameHeight-1)
        bitmapContext!.drawLine(start: pt1, end: pt2);
        bitmapContext!.drawLine(start: pt2, end: pt3);
        bitmapContext!.drawLine(start: pt3, end: pt4);
        bitmapContext!.drawLine(start: pt4, end: pt1); 

        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }
    
    private class func CreateNumericImage(_ number : Int)->CGImage? {
        let sNumber : String = String(describing: number) //or "\(number)"
        let fCharspce : CGFloat = 0
        let fFontSize : CGFloat = 70
        let strokeWidth : CGFloat = 2
        
#if os(OSX)
        let aFont : NSFont = NSFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:NSColor.black] as CFDictionary
#else
        let aFont : UIFont = UIFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:UIColor.black] as CFDictionary
#endif
        // create the attributed string
        let text = CFAttributedStringCreate(nil, sNumber as CFString, attr)!
        // create the line of text
        let line = CTLineCreateWithAttributedString(text)

        // retrieve the bounds of the text
        //let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.useOpticalBounds)

        //let width : CGFloat = bounds.width < bounds.height ? bounds.height : bounds.width
        //let height : CGFloat = width
        var ascent : CGFloat = 0.0
        var descent : CGFloat = 0.0
        var leading : CGFloat = 0.0
        //
        let width : CGFloat = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
        let height : CGFloat = CGFloat(ascent + descent)

        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bmpContext : CGContext? = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        guard bmpContext != nil else {
            return nil
        }
        
        let sx : CGFloat = 0
        let sy : CGFloat = descent

        bmpContext!.setStrokeColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        bmpContext!.setFillColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

        // set the line width to stroke the text with
        bmpContext!.setLineWidth(strokeWidth)
        bmpContext!.setTextDrawingMode(CGTextDrawingMode.fillStroke)
        bmpContext!.setCharacterSpacing(fCharspce)
        bmpContext!.textPosition = CGPoint(x: sx, y: sy)
        CTLineDraw(line, bmpContext!)
        
        let image : CGImage = bmpContext!.makeImage()!
        return image
    }

    private class func CreateRedColorNumericImage(_ number : Int)->CGImage? {
        let sNumber : String = String(describing: number) //or "\(number)"
        let fCharspce : CGFloat = 0
        let fFontSize : CGFloat = 70
        let strokeWidth : CGFloat = 2
            
    #if os(OSX)
        let aFont : NSFont = NSFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont,NSAttributedString.Key.foregroundColor:NSColor.red] as CFDictionary
    #else
        let aFont : UIFont = UIFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:UIColor.red] as CFDictionary
    #endif
            // create the attributed string
        let text = CFAttributedStringCreate(nil, sNumber as CFString, attr)!
            // create the line of text
        let line = CTLineCreateWithAttributedString(text)

        var ascent : CGFloat = 0.0
        var descent : CGFloat = 0.0
        var leading : CGFloat = 0.0
            //
        let width : CGFloat = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
        let height : CGFloat = CGFloat(ascent + descent)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bmpContext : CGContext? = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        guard bmpContext != nil else {
                return nil
        }
            
        let sx : CGFloat = 0
        let sy : CGFloat = descent

        bmpContext!.setStrokeColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        bmpContext!.setFillColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)

            // set the line width to stroke the text with
        bmpContext!.setLineWidth(strokeWidth)
        bmpContext!.setTextDrawingMode(CGTextDrawingMode.fillStroke)
        bmpContext!.setCharacterSpacing(fCharspce)
        bmpContext!.textPosition = CGPoint(x: sx, y: sy)
        CTLineDraw(line, bmpContext!)
            
        let image : CGImage = bmpContext!.makeImage()!
        return image
    }

    private class func CreateWhiteColorNumericImage(_ number : Int)->CGImage? {
        let sNumber : String = String(describing: number) //or "\(number)"
        let fCharspce : CGFloat = 0
        let fFontSize : CGFloat = 70
        let strokeWidth : CGFloat = 2
            
    #if os(OSX)
        let aFont : NSFont = NSFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont,NSAttributedString.Key.foregroundColor:NSColor.white] as CFDictionary
    #else
        let aFont : UIFont = UIFont(name: "Times New Roman", size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:UIColor.white] as CFDictionary
    #endif
            // create the attributed string
        let text = CFAttributedStringCreate(nil, sNumber as CFString, attr)!
            // create the line of text
        let line = CTLineCreateWithAttributedString(text)

        var ascent : CGFloat = 0.0
        var descent : CGFloat = 0.0
        var leading : CGFloat = 0.0
            //
        let width : CGFloat = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
        let height : CGFloat = CGFloat(ascent + descent)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bmpContext : CGContext? = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        guard bmpContext != nil else {
                return nil
        }
            
        let sx : CGFloat = 0
        let sy : CGFloat = descent

        bmpContext!.setStrokeColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bmpContext!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

            // set the line width to stroke the text with
        bmpContext!.setLineWidth(strokeWidth)
        bmpContext!.setTextDrawingMode(CGTextDrawingMode.fillStroke)
        bmpContext!.setCharacterSpacing(fCharspce)
        bmpContext!.textPosition = CGPoint(x: sx, y: sy)
        CTLineDraw(line, bmpContext!)
            
        let image : CGImage = bmpContext!.makeImage()!
        return image
    }

    public class func CreateStepSignImage(number: Int, size: CGSize)->CGImage? {
        let imageNumber : CGImage? = RenderHelper.CreateRedColorNumericImage(number)

        guard imageNumber != nil else {
            return nil
        }
        let fBaseWidth : CGFloat = size.width
        let fBaseHeight : CGFloat = size.height
        var fNumberWidth : CGFloat = fBaseWidth*0.72
        var fNumberHeight : CGFloat = fBaseHeight*0.72
        let fNumberImageRatio : CGFloat = CGFloat(imageNumber!.width)/CGFloat(imageNumber!.height)
        if fNumberImageRatio < 1.0 {
            fNumberWidth = fNumberHeight*fNumberImageRatio
        }
        else if 1.0 < fNumberImageRatio {
            fNumberHeight = fNumberWidth/fNumberImageRatio
        }
        
        let cxImage = fBaseWidth*0.5
        let cyImage = fBaseHeight*0.5
        let numberRect : CGRect = CGRect(x: cxImage-fNumberWidth*0.5, y: cyImage-fNumberHeight*0.5/*0.3*/, width: fNumberWidth, height: fNumberHeight)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(fBaseWidth), height: Int(fBaseHeight), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }
        bitmapContext!.saveGState()
        bitmapContext!.draw(imageNumber!, in:numberRect)
        bitmapContext!.restoreGState()

        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }
    
    private class func LoadImageSetImage(imageSet:Int)->CGImage? {
        let sImageSet : String = "nb\(imageSet)"
        let pImage : CGImage? = RenderHelper.LoadResourceImage(name: sImageSet)
        return pImage;
    }
    
    class func CreatePuzzleChipImage(imageSet:Int, index number:Int)->CGImage? {
        let imageNumber : CGImage? = RenderHelper.CreateNumericImage(number)
        let imageBase : CGImage? = RenderHelper.LoadImageSetImage(imageSet: imageSet)
        let shadowLength : CGFloat = 1

        guard imageBase != nil && imageNumber != nil else {
            return nil
        }
        let fBaseWidth : CGFloat = CGFloat(imageBase!.width)
        let fBaseHeight : CGFloat = CGFloat(imageBase!.height)
        let fContextWidth : CGFloat = fBaseWidth + shadowLength*2
        let fContextHeight : CGFloat = fBaseHeight + shadowLength*2
        var fNumberWidth : CGFloat = fBaseWidth*0.6
        var fNumberHeight : CGFloat = fBaseHeight*0.6
        let fNumberImageRatio : CGFloat = CGFloat(imageNumber!.width)/CGFloat(imageNumber!.height)
        if fNumberImageRatio < 1.0 {
            fNumberWidth = fNumberHeight*fNumberImageRatio
        }
        else if 1.0 < fNumberImageRatio {
            fNumberHeight = fNumberWidth/fNumberImageRatio
        }
        
        let cxImage = fBaseWidth*0.5
        let cyImage = fBaseHeight*0.5
        let baseRect : CGRect = CGRect(x: shadowLength, y: shadowLength, width: fBaseWidth, height: fBaseHeight)
        let numberRect : CGRect = CGRect(x: cxImage-fNumberWidth*0.5, y: cyImage-fNumberHeight*0.5/*0.3*/, width: fNumberWidth, height: fNumberHeight)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(fContextWidth), height: Int(fContextHeight), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }
        bitmapContext!.saveGState()

        let shadowClrSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let shadowSize : CGSize = CGSize(width:shadowLength, height:shadowLength*(-0.6))
        let clrvals : [CGFloat] = [0.2, 0.2, 0.2, 0.7]
        let shadowClrs : CGColor = CGColor(colorSpace: shadowClrSpace, components: clrvals)!
        bitmapContext!.saveGState()
        bitmapContext!.setShadow(offset: shadowSize, blur: shadowLength, color: shadowClrs)
        bitmapContext!.draw(imageBase!, in:baseRect)
        bitmapContext!.restoreGState()
        bitmapContext!.draw(imageNumber!, in:numberRect)
        bitmapContext!.restoreGState()

        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }

    class func CreatePuzzleChipWhiteNumberImage(imageSet:Int, index number:Int)->CGImage? {
        let imageNumber : CGImage? = RenderHelper.CreateWhiteColorNumericImage(number)
        let imageBase : CGImage? = RenderHelper.LoadImageSetImage(imageSet: imageSet)
        let shadowLength : CGFloat = 1

        guard imageBase != nil && imageNumber != nil else {
            return nil
        }
        let fBaseWidth : CGFloat = CGFloat(imageBase!.width)
        let fBaseHeight : CGFloat = CGFloat(imageBase!.height)
        let fContextWidth : CGFloat = fBaseWidth + shadowLength*2
        let fContextHeight : CGFloat = fBaseHeight + shadowLength*2
        var fNumberWidth : CGFloat = fBaseWidth*0.6
        var fNumberHeight : CGFloat = fBaseHeight*0.6
        let fNumberImageRatio : CGFloat = CGFloat(imageNumber!.width)/CGFloat(imageNumber!.height)
        if fNumberImageRatio < 1.0 {
            fNumberWidth = fNumberHeight*fNumberImageRatio
        }
        else if 1.0 < fNumberImageRatio {
            fNumberHeight = fNumberWidth/fNumberImageRatio
        }
        
        let cxImage = fBaseWidth*0.5
        let cyImage = fBaseHeight*0.5
        let baseRect : CGRect = CGRect(x: shadowLength, y: shadowLength, width: fBaseWidth, height: fBaseHeight)
        let numberRect : CGRect = CGRect(x: cxImage-fNumberWidth*0.5, y: cyImage-fNumberHeight*0.5/*0.3*/, width: fNumberWidth, height: fNumberHeight)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(fContextWidth), height: Int(fContextHeight), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }
        bitmapContext!.saveGState()

        let shadowClrSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let shadowSize : CGSize = CGSize(width:shadowLength, height:shadowLength*(-0.6))
        let clrvals : [CGFloat] = [0.2, 0.2, 0.2, 0.7]
        let shadowClrs : CGColor = CGColor(colorSpace: shadowClrSpace, components: clrvals)!
        bitmapContext!.saveGState()
        bitmapContext!.setShadow(offset: shadowSize, blur: shadowLength, color: shadowClrs)
        bitmapContext!.draw(imageBase!, in:baseRect)
        bitmapContext!.restoreGState()
        bitmapContext!.draw(imageNumber!, in:numberRect)
        bitmapContext!.restoreGState()

        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }

    class func CreateSamplePuzzleImage(imageSet:Int, type:enGridType, edge:Int, size: CGFloat)->CGImage? {
        let fBubbleSize = GameLayout.GetSampleDrawChipSize(type: type, edge:edge, drawLength:size)
        let centers = GameLayout.BuildSamplePuzzleLayout(type:type, edge:edge, size:size)
        let bubbleImage = LoadImageSetImage(imageSet:imageSet)!
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(size+1), height: Int(size+1), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }

        for i in 0 ... (centers.count-1) {
            let rect = CGRect(x:centers[i].x-fBubbleSize*0.5, y:centers[i].y-fBubbleSize*0.5, width:fBubbleSize, height:fBubbleSize)
            bitmapContext!.draw(bubbleImage, in:rect)
        }
        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }

    class func CreateLayoutPuzzleDemoImage(imageSet:Int, type:enGridType, layout:enGridLayout, edge:Int, size: CGFloat)->CGImage? {
        let fBubbleSize = GameLayout.GetSampleDrawChipSize(type: type, edge:edge, drawLength:size)*0.7
        let centers = GameLayout.BuildSamplePuzzleLayout(type:type, edge:edge, size:size)
        let bubbleImage = LoadImageSetImage(imageSet:imageSet)!
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(size+1), height: Int(size+1), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            return nil
        }
   
        bitmapContext!.setLineWidth(10.0)
        bitmapContext!.setStrokeColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)

        let samplePuzzel : Puzzle = Puzzle()
        samplePuzzel.Initialize(type, layout, edge)

        for i in 0 ... (centers.count-1) {
            if i < centers.count-1 {
                let labelIndex1 = samplePuzzel.GetLabelIndex(realIndex: i)
                let nextIndex = samplePuzzel.GetRealIndexByLabelIndex(labelIndex: (labelIndex1+1))
                if 0 <= nextIndex && nextIndex <= centers.count-1 {
                    bitmapContext!.drawLine(start:centers[i], end: centers[nextIndex])
                }
            }
        }
        for i in 0 ... (centers.count-1) {
            let rect = CGRect(x:centers[i].x-fBubbleSize*0.5, y:centers[i].y-fBubbleSize*0.5, width:fBubbleSize, height:fBubbleSize)
            bitmapContext!.draw(bubbleImage, in:rect)
        }
        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }

     class func CreateLayoutPuzzleSignImage(imageSet:Int, type:enGridType, layout:enGridLayout, edge:Int, size: CGFloat)->CGImage? {
         let fBubbleSize = GameLayout.GetSampleDrawChipSize(type: type, edge:edge, drawLength:size)*0.76
         let centers = GameLayout.BuildSamplePuzzleLayout(type:type, edge:edge, size:size)
         let bubbleImage = LoadImageSetImage(imageSet:imageSet)!
         let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
         let bitmapContext : CGContext? = CGContext(data: nil, width: Int(size+1), height: Int(size+1), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
         
         guard bitmapContext != nil else {
             return nil
         }
    
         bitmapContext!.setLineWidth(2.4)
         bitmapContext!.setStrokeColor(red: 1.0, green: 1.0, blue: 0.4, alpha: 1.0)

         let samplePuzzel : Puzzle = Puzzle()
         samplePuzzel.Initialize(type, layout, edge)

         for i in 0 ... (centers.count-1) {
             if i < centers.count-1 {
                 let labelIndex1 = samplePuzzel.GetLabelIndex(realIndex: i)
                 let nextIndex = samplePuzzel.GetRealIndexByLabelIndex(labelIndex: (labelIndex1+1))
                 if 0 <= nextIndex && nextIndex <= centers.count-1 {
                     bitmapContext!.drawLine(start:centers[i], end: centers[nextIndex])
                 }
             }
         }
         for i in 0 ... (centers.count-1) {
             let rect = CGRect(x:centers[i].x-fBubbleSize*0.5, y:centers[i].y-fBubbleSize*0.5, width:fBubbleSize, height:fBubbleSize)
             bitmapContext!.draw(bubbleImage, in:rect)
         }
         let image : CGImage = bitmapContext!.makeImage()!
         return image
     }
}
