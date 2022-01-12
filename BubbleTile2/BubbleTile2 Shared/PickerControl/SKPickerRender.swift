///**
/**
Workspace:     PickerControl For SpriteKit
Project:     PickerControl For SpriteKit
Target:      PickerControl For SpriteKit
Package:     PickerControl For SpriteKit
File: 		SKPickerRender.swift

Created by: Zhaohui Xing on 5/1/20
Copyright (c) 2020 Zhaohui Xing. All rights reserved.
*/
import SpriteKit
import simd

class SKPickerRender {
    class func createImageSetTexture(name: String, size: CGSize, scale:CGFloat, layout:SKPickerLayout)->SKTexture {
        #if os(OSX)
            let image : CGImage? = NSImage(named: name)?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        #else
            let image : CGImage? = UIImage(named: name)?.cgImage
        #endif
        let texture : SKTexture = createTextureFromImage(image: image!, size: size, scale: scale, layout: layout)
        return texture
    }

    class func createLabelTexture(text: String, fontname: String, size: CGSize, scale:CGFloat, layout:SKPickerLayout)->SKTexture {
        let image : CGImage = createTextImage(text : text, fontName: fontname)
        let texture : SKTexture = createTextureFromImage(image: image, size: size, scale: scale, layout: layout)
        return texture
    }
    
    class func createColorLabelTexture(text: String, fontname: String, color:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat), size: CGSize, scale:CGFloat, layout:SKPickerLayout)->SKTexture {
        let image : CGImage = createColorTextImage(text : text, fontName: fontname, color: color)
        let texture : SKTexture = createTextureFromImage(image: image, size: size, scale: scale, layout: layout)
        return texture
    }

    class func createColorTexture(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, size: CGSize, layout:SKPickerLayout)->SKTexture {
        let bkImage : CGImage = createColorImage(red: red, green: green, blue: blue, alpha: alpha, size: size, layout: layout)
        let texture : SKTexture = SKTexture(cgImage: bkImage);
        
        return texture
    }
    
    class func createDefaultGradientTexture(size: CGSize, layout:SKPickerLayout)->SKTexture {
        let bkImage : CGImage = createDefaultGradientImage(size: size, layout: layout)
        let texture : SKTexture = SKTexture(cgImage: bkImage);
        
        return texture
    }

    private class func createDefaultGradientImage(size: CGSize, layout:SKPickerLayout)->CGImage {
        let strokeWidth : CGFloat = 2
        let edgeSize : CGFloat = 8.0
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        
        guard bitmapContext != nil else {
            fatalError("Can not create buffer bitmap context for default gradient background")
        }

        let dark : CGFloat = 0.2
        let medium : CGFloat = 0.7
        let light : CGFloat = 1.0
        let bkcolor : CGFloat = 0.5
        let colorLocations : [CGFloat] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let colors: [CGFloat] = [dark, dark, dark, 1.0,
                                medium, medium, medium, 1.0,
                                light, light, light, 1.0,
                                medium, medium, medium, 1.0,
                                dark, dark, dark, 1.0]
        let gradientSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let colorGradient : CGGradient? = CGGradient(colorSpace: gradientSpace, colorComponents: colors, locations: colorLocations, count: 5)
        guard colorGradient != nil else {
            fatalError("Can not create gradient for default gradient background")
        }
        bitmapContext!.saveGState()
        
        bitmapContext!.beginPath()
        let pts : [CGPoint] = [CGPoint(x:0.0, y:edgeSize), CGPoint(x:0.0, y:size.height-edgeSize),
                              CGPoint(x:edgeSize, y:size.height), CGPoint(x:size.width-edgeSize, y:size.height),
                              CGPoint(x:size.width, y:size.height-edgeSize),  CGPoint(x:size.width, y:edgeSize),
                              CGPoint(x:size.width-edgeSize, y:0.0), CGPoint(x:edgeSize, y:0.0)]
        bitmapContext!.move(to:CGPoint(x:edgeSize, y:0.0))
        bitmapContext!.addLines(between: pts)
        bitmapContext!.closePath()
        bitmapContext!.setStrokeColor(red: bkcolor, green: bkcolor, blue: bkcolor, alpha: 1.0)
        bitmapContext!.setFillColor(red: bkcolor, green: bkcolor, blue: bkcolor, alpha: 1.0)
        bitmapContext!.drawPath(using:.fillStroke)
        
        bitmapContext!.restoreGState()

        bitmapContext!.saveGState()
        var rect : CGRect = CGRect(x:edgeSize, y:0, width: size.width-2.0*edgeSize, height: size.height)
        if layout == .horizontal {
            rect = CGRect(x:0.0, y:edgeSize, width: size.width, height: size.height-2.0*edgeSize)
        }

        bitmapContext!.addRect(rect)
        bitmapContext!.clip()
        var startPt: CGPoint = CGPoint(x:edgeSize, y:0.0)
        var endPt : CGPoint = CGPoint(x:edgeSize, y:size.height)
        if layout == .horizontal {
            startPt = CGPoint(x:0.0, y:edgeSize)
            endPt = CGPoint(x:size.width, y:edgeSize)
        }
        bitmapContext!.drawLinearGradient(colorGradient!, start: startPt, end: endPt, options:.drawsAfterEndLocation)
        
        bitmapContext!.restoreGState()
        
        bitmapContext!.setLineWidth(strokeWidth)
        bitmapContext!.setStrokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        var startx : CGFloat = 0.0
        var starty : CGFloat = size.height/2.0
        var endx : CGFloat = size.width
        var endy : CGFloat = size.height/2.0
        if layout == .horizontal {
            startx = size.width/2.0
            starty = 0.0
            endx = size.width/2.0
            endy = size.height
        }
        drawLine(context:bitmapContext!, start:CGPoint(x: startx, y: starty), end:CGPoint(x:endx, y:endy))

        let image : CGImage = bitmapContext!.makeImage()!
        return image
    }
    
    public class func createTextureFromImage(image: CGImage, size: CGSize, scale:CGFloat, layout:SKPickerLayout)->SKTexture {
        let texWidth : CGFloat = size.width
        let texHeight : CGFloat = size.height
        let drawSize = texHeight < texWidth ? texHeight : texWidth
        let imageWidth : CGFloat = CGFloat(image.width)
        let imageHeight : CGFloat = CGFloat(image.height)
        let imageRatio : CGFloat = imageWidth/imageHeight

        
        var drawWidth : CGFloat
        var drawHeight : CGFloat
        
        if layout == .veritcal {
            if 1.0 < imageRatio {
                drawWidth = drawSize*(scale <= 1.0 ? scale : 1.0)
                drawHeight = drawWidth/imageRatio
            }
            else {
                drawHeight = drawSize*(scale <= 1.0 ? scale : 1.0)
                drawWidth = drawHeight*imageRatio
            }
            
        }
        else {
            if imageRatio < 1.0 {
                drawHeight = drawSize*(scale <= 1.0 ? scale : 1.0)
                drawWidth = drawHeight * imageRatio
            }
            else {
                drawWidth = drawSize*(scale <= 1.0 ? scale : 1.0)
                drawHeight = drawWidth/imageRatio
            }
        }
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapContext : CGContext? = CGContext(data: nil, width: Int(texWidth), height: Int(texHeight), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: image.bitmapInfo.rawValue)!
        
        guard bitmapContext != nil else {
            fatalError("Can not create buffer bitmap context")
        }

        let cx = texWidth*0.5
        let cy = texHeight*0.5
        let drawRect : CGRect = CGRect(x: cx-drawWidth*0.5, y: cy-drawHeight*0.5, width: drawWidth, height: drawHeight)
        bitmapContext!.draw(image, in:drawRect)

        let bkImage : CGImage = bitmapContext!.makeImage()!
        let texture : SKTexture = SKTexture(cgImage: bkImage);
        return texture
    }
    
    private class func createColorImage(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, size: CGSize, layout:SKPickerLayout)->CGImage {
        let strokeWidth : CGFloat = 2
        let width : CGFloat = size.width
        let height : CGFloat = size.height

        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bmpContext : CGContext? = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        guard bmpContext != nil else {
            fatalError("Can not create buffer image context")
        }
        
        bmpContext!.setFillColor(red: red, green: green, blue: blue, alpha: alpha)
        bmpContext!.fill(CGRect(x: 0.0, y: 0.0, width: width, height: height))
        
        bmpContext!.setLineWidth(strokeWidth)
        bmpContext!.setStrokeColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        var startx : CGFloat = 0.0
        var starty : CGFloat = height/2.0
        var endx : CGFloat = width
        var endy : CGFloat = height/2.0
        if layout == .horizontal {
            startx = width/2.0
            starty = 0.0
            endx = width/2.0
            endy = height
        }
        drawLine(context:bmpContext!, start:CGPoint(x: startx, y: starty), end:CGPoint(x:endx, y:endy))
        let image : CGImage = bmpContext!.makeImage()!
        return image
    }

    private class func drawLine(context:CGContext, start:CGPoint, end:CGPoint) {
        context.beginPath()
        context.move(to:start)
        context.addLine(to: end)
        context.drawPath(using: .stroke)
    }
    
    private class func createTextImage(text : String, fontName: String)->CGImage {
#if os(OSX)
        let image : CGImage = createTextImageInternal(text : text, fontName: fontName, color: NSColor.black)
#else
        let image : CGImage = createTextImageInternal(text : text, fontName: fontName, color: UIColor.black)
#endif
        return image
    }

    private class func createColorTextImage(text : String, fontName: String, color:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat))->CGImage {
#if os(OSX)
        let fontColor : NSColor = NSColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        let image : CGImage = createTextImageInternal(text : text, fontName: fontName, color: fontColor)
#else
        let fontColor : UIColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
        let image : CGImage = createTextImageInternal(text : text, fontName: fontName, color: fontColor)
#endif
        return image
    }
    
    private class func createTextImageInternal(text : String, fontName: String, color: Any)->CGImage {
        let fCharspce : CGFloat = 0
        let fFontSize : CGFloat = 200
        let strokeWidth : CGFloat = 2
            
#if os(OSX)
        let fontColor : NSColor = color as! NSColor
        let aFont : NSFont = NSFont(name: fontName, size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:fontColor] as CFDictionary
#else
        let fontColor : UIColor = color as! UIColor
        let aFont : UIFont = UIFont(name: fontName, size: fFontSize)!
        let attr = [NSAttributedString.Key.font:aFont, NSAttributedString.Key.foregroundColor:fontColor] as CFDictionary
#endif
        // create the attributed string
        let textCF = CFAttributedStringCreate(nil, text as CFString, attr)!
        // create the line of text
        let line = CTLineCreateWithAttributedString(textCF)

        var ascent : CGFloat = 0.0
        var descent : CGFloat = 0.0
        var leading : CGFloat = 0.0
        
        let width : CGFloat = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))
        let height : CGFloat = CGFloat(ascent + descent)
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bmpContext : CGContext? = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent:8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue|CGImageAlphaInfo.premultipliedFirst.rawValue)!
        guard bmpContext != nil else {
            fatalError("Can not create label image context")
        }
        
        let sx : CGFloat = 0.0
        let sy : CGFloat = descent
        
        // set the line width to stroke the text with
        bmpContext!.setLineWidth(strokeWidth)
            bmpContext!.setTextDrawingMode(CGTextDrawingMode.fillStroke)
            bmpContext!.setCharacterSpacing(fCharspce)
        
        bmpContext!.textPosition = CGPoint(x: sx, y: sy)
        CTLineDraw(line, bmpContext!)
        let image : CGImage = bmpContext!.makeImage()!
        return image
    }
}
