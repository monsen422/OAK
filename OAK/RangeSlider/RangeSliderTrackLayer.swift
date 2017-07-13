//
//  RangeSliderTrachLayer.swift
//  OAK
//
//  Created by MobileDev on 9/14/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            /*let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            CGContextAddPath(ctx, path.CGPath)
            
            // Fill the track
            CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            // Fill the highlighted range
            CGContextSetFillColorWithColor(ctx, slider.trackHighlightTintColor.CGColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))*/
            
            let cornerRadius = bounds.height  / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            (ctx).fillPath()
            
            let colors = [
                hexStringToUIColor("#CF5647"), hexStringToUIColor("#D36C48"), hexStringToUIColor("#DA844B"), hexStringToUIColor("#DF9E4E"), hexStringToUIColor("#E6B84F"), hexStringToUIColor("#D6C257"), hexStringToUIColor("#B1BA64"), hexStringToUIColor("#8BB672"), hexStringToUIColor("#66B182"), hexStringToUIColor("#44AB91")]
            var posX = 0
            let itemW = IS_IPAD ?  Int(51) : Int(30)
            for i in  0...colors.count-1{
                ctx.setFillColor(colors[i].cgColor)
                let rect = CGRect(x: CGFloat(posX) + 0.5, y: 0.0, width: CGFloat(itemW) - 0.5, height: 18)
                ctx.fill(rect)
                posX += Int(itemW)
            }
            
        }
    }
    

}
