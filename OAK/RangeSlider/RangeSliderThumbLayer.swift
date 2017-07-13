//
//  RangeSliderThumbLayer.swift
//  OAK
//
//  Created by MobileDev on 9/14/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit
import QuartzCore
class RangeSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            let thumbFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.gray
            ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
            ctx.setFillColor(hexStringToUIColor("#D8D8D8").cgColor)
            ctx.addPath(thumbPath.cgPath)
            (ctx).fillPath()
            
            // Outline
            ctx.setStrokeColor(shadowColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(thumbPath.cgPath)
            ctx.strokePath()
            
            if highlighted {
                ctx.setFillColor(hexStringToUIColor("#D8D8D8").cgColor)
                ctx.addPath(thumbPath.cgPath)
                (ctx).fillPath()
            }
            
        }
    }
}
