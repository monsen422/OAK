//
//  LowerSliderTrackLayer.swift
//  OAK
//
//  Created by MobileDev on 9/28/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//
import UIKit
import QuartzCore

class LowerSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let cornerRadius = bounds.height / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            //let lowerWidth = CGFloat(slider.positionForValue(slider.lowerValue))
            ctx.setFillColor(slider.lowerTrackColor.cgColor)
            let rect = CGRect(x: 0, y: 0.0, width: bounds.width, height: bounds.height)
            ctx.fill(rect)
            self.masksToBounds = true
        }
    }

}
