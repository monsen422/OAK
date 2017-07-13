//
//  RangeSlider.swift
//  OAK
//
//  Created by MobileDev on 9/14/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {

    let trackLayer = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    let lowerTrackLayer = LowerSliderTrackLayer()
    let upperTrackLayer = UpperSliderTrackLayer()
    
    var previousLocation = CGPoint()
    
    var minimumValue: Double = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue: Double = 1.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerValue: Double = 0.1 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var upperValue: Double = 0.9 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerTrackColor :UIColor = UIColor(red: 205/255, green: 86/255, blue: 71/255, alpha: 1.0){
        didSet{
            
        }
    }
    var upperTrackColor :UIColor = UIColor(red: 68/255, green: 171/255, blue: 145/255, alpha: 1.0){
        didSet{
            
        }
    }
    
    var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var thumbTintColor: UIColor = UIColor.white {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        
        
        //let trackLayer2 = RangeSliderTrackLayer2(frame: CGRectMake(0, 10, self.frame.width, 11))
        
        layer.addSublayer(trackLayer)
        
        //self.addSubview(trackLayer2)
        
        lowerTrackLayer.rangeSlider = self
        lowerTrackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerTrackLayer)
        
        upperTrackLayer.rangeSlider = self
//        upperTrackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperTrackLayer)
        
        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
        
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    func reset(){
        lowerValue = 0.1
        upperValue = 0.9
    }
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = CGRect(x: 0, y: bounds.height / 3, width: bounds.width, height: 13)
        
        //trackLayer.cornerRadius = trackLayer.frame.size.height/2//rangeSlider.frame.size.height/2
        //trackLayer.clipsToBounds = true
        
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - ((thumbWidth+6) / 2.0), y: 4, width: thumbWidth-15, height: thumbWidth-5)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - ((thumbWidth-42) / 2.0), y: 2.5,
                                       width: thumbWidth-15, height: thumbWidth-5)
        upperThumbLayer.setNeedsDisplay()
        
        lowerTrackLayer.frame = CGRect(x: 0, y: bounds.height / 3, width: lowerThumbCenter - (thumbWidth/2-5), height: 13)
        lowerTrackLayer.setNeedsDisplay()
        upperTrackLayer.frame = CGRect(x: upperThumbCenter + (thumbWidth/2), y: bounds.height / 3, width: bounds.width - upperThumbCenter - (thumbWidth/2), height: 13)
        upperTrackLayer.setNeedsDisplay()

        
        CATransaction.commit()
    }
    
    func positionForValue(_ value: Double) -> Double {
        let widthDouble = Double(thumbWidth)
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        let lowerHitFrame:CGRect = CGRect(x: lowerThumbLayer.frame.minX - 25, y: lowerThumbLayer.frame.minY, width: lowerThumbLayer.frame.width + 50, height: lowerThumbLayer.frame.height)
        let upperHitFrame:CGRect = CGRect(x: upperThumbLayer.frame.minX - 25, y: upperThumbLayer.frame.minY, width: upperThumbLayer.frame.width + 50, height: upperThumbLayer.frame.height)
        
        
        // Hit test the thumb layers
        //if lowerThumbLayer.frame.contains(previousLocation) {
        if lowerHitFrame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperHitFrame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    func boundValue(_ value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - bounds.height)
        
        previousLocation = location
        // 2. Update the values
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
            
            //Update value
            NotificationCenter.default.post(name: NSNotification.Name("UPDATE_LOWER"), object: nil, userInfo: ["value":lowerValue])
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
            
             NotificationCenter.default.post(name: NSNotification.Name("UPDATE_UPPER"), object: nil, userInfo: ["value":upperValue])
        }
        
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        sendActions(for: .valueChanged)
        
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    

}
