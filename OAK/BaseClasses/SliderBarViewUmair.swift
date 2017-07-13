//
//  SliderBarViewUmair.swift
//  OAK
//
//  Created by Mac on 20/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class SliderBarViewUmair: UIView {
    
    var innerSlideView:SlideBarInnerView!
    let sideAlignMent:CGFloat = 20
    let barHeight:CGFloat = 15
    let belowAlignMent:CGFloat = 8
    
    let cubeWidth:CGFloat = 20.0
    let cubeSliderOverLay:CGFloat = 4.0
    
    var minView:UIView!
    var minLabel:UILabel!
    
    var maxView:UIView!
    var maxLabel:UILabel!

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // 1. Make BG White
        self.setBackGroundCOlorWhite()
        
        // 2. Add InnerView inside mySelf. Its the Scroller View
        self.createInnerSlideView()
        
        // 3. Create Min View
        self.CreateMinimumCube()
        
        // 4. Create Max View
        self.CreateMaximumCube()
        
        // 5. Adding pan Gesture on MinView
        self.ApplyPanGestureOnMinView()
        
        // 6. Adding pan Gesture on MaxView
        self.ApplyPanGestureOnMaxView()
        
    }
    
    func setBackGroundCOlorWhite() ->Void
    {
        UIColor.white.setFill()
        UIRectFill(self.bounds)
    }
    
    func createInnerSlideView() ->Void
    {
        innerSlideView = SlideBarInnerView(frame:CGRect(origin: CGPoint(x: sideAlignMent, y: self.bounds.size.height - barHeight - belowAlignMent), size: CGSize(width: self.bounds.size.width - (sideAlignMent*2), height: barHeight)))
        self.addSubview(innerSlideView)
    }
    
    func CreateMinimumCube() -> Void
    {
        // Set Frame of MinView
        let xValue = (innerSlideView.frame.size.width * DataManager.dataManagerSharedInstance.minValueSLider)/100
        let minFrame = CGRect(origin: CGPoint(x: (sideAlignMent + xValue - cubeWidth/2), y: 0), size: CGSize(width: cubeWidth, height: self.bounds.size.height))
        minView = UIView(frame:minFrame)
        minView.backgroundColor = UIColor.clear
        
        // Create and Add Cube View on It
        let yValueOfCube = self.bounds.size.height - barHeight - belowAlignMent - cubeSliderOverLay
        let uponSliderFrame = CGRect(origin: CGPoint(x: cubeSliderOverLay, y: yValueOfCube), size: CGSize(width: cubeWidth-(cubeSliderOverLay * 2), height: barHeight + (cubeSliderOverLay*2)))
        let rozeeMinView = RozeeUIView(frame:uponSliderFrame)
        rozeeMinView.backgroundColor = UIColor(hexString: "d8d8d8")
        rozeeMinView.borderHeight = 1
        rozeeMinView.borderColorType = 4
        minView.addSubview(rozeeMinView)
        
        // Creating and Adding label on It
        let labelFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cubeWidth, height: yValueOfCube))
        minLabel = UILabel(frame: labelFrame)
        minLabel.text = String(describing: Int(DataManager.dataManagerSharedInstance.minValueSLider))
        minLabel.font = minLabel.font.withSize(10)
        minLabel.adjustsFontSizeToFitWidth = true
        minLabel.textAlignment = NSTextAlignment.center
        minView.addSubview(minLabel)
        
        self.addSubview(minView)
    }
    
    func CreateMaximumCube() -> Void
    {
        // Set Frame of MinView
        let xValue = (innerSlideView.frame.size.width * DataManager.dataManagerSharedInstance.maxValueSLider)/100
        let minFrame = CGRect(origin: CGPoint(x: (sideAlignMent + xValue - cubeWidth/2), y: 0), size: CGSize(width: cubeWidth, height: self.bounds.size.height))
        maxView = UIView(frame:minFrame)
        maxView.backgroundColor = UIColor.clear
        
        // Create and Add Cube View on It
        let yValueOfCube = self.bounds.size.height - barHeight - belowAlignMent - cubeSliderOverLay
        let uponSliderFrame = CGRect(origin: CGPoint(x: cubeSliderOverLay, y: yValueOfCube), size: CGSize(width: cubeWidth-(cubeSliderOverLay * 2), height: barHeight + (cubeSliderOverLay*2)))
        let rozeeMinView = RozeeUIView(frame:uponSliderFrame)
        rozeeMinView.backgroundColor = UIColor(hexString: "d8d8d8")
        rozeeMinView.borderHeight = 1
        rozeeMinView.borderColorType = 4
        maxView.addSubview(rozeeMinView)
        
        // Creating and Adding label on It
        let labelFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: cubeWidth, height: yValueOfCube))
        maxLabel = UILabel(frame: labelFrame)
        maxLabel.text = String(describing: Int(DataManager.dataManagerSharedInstance.maxValueSLider))
        maxLabel.font = maxLabel.font.withSize(10)
        maxLabel.adjustsFontSizeToFitWidth = true
        maxLabel.textAlignment = NSTextAlignment.center
        maxView.addSubview(maxLabel)
        
        self.addSubview(maxView)
        
        
        
    }
    
    
    func ApplyPanGestureOnMinView() ->Void
    {
        let panRec = UIPanGestureRecognizer()
        panRec.addTarget(self, action: #selector(draggedView_Min))
        minView.isUserInteractionEnabled = true
        minView.addGestureRecognizer(panRec)
    }
    
    func draggedView_Min(sender:UIPanGestureRecognizer)
    {
        let translation = sender.translation(in: self)
        var currentFrame = minView.frame
        let maxFrameX = maxView.frame.origin.x - cubeWidth/2
        if((currentFrame.origin.x + translation.x) > sideAlignMent && (currentFrame.origin.x + translation.x) < maxFrameX)
        {
            currentFrame.origin.x = currentFrame.origin.x + translation.x
            minView.frame = currentFrame
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
        
        self.UpdateTheLabelValue_Min()
        
        if(DataManager.dataManagerSharedInstance.controllerTabNumber == 5)
        {
            var userInfo:[String : String] = [String : String]()
            let minLabeltext:String = self.minLabel.text!
            let maxLabeltext:String = self.maxLabel.text!
            userInfo["min"] = minLabeltext
            userInfo["max"] = maxLabeltext
            NotificationCenter.default.post(name: NSNotification.Name("AwsomeSliderMoved"), object: nil, userInfo: userInfo)
        }
    }
    
    func UpdateTheLabelValue_Min() -> Void
    {
        var xValue = (innerSlideView.frame.size.width * DataManager.dataManagerSharedInstance.minValueSLider)/100
        xValue = sideAlignMent + xValue - cubeWidth/2
        let newValue = (100 * (minView.frame.origin.x - sideAlignMent + cubeWidth/2)) / innerSlideView.frame.size.width
        
        DataManager.dataManagerSharedInstance.minValueSLider = newValue
        minLabel.text = String(describing: Int(DataManager.dataManagerSharedInstance.minValueSLider))
    }
    
    func ApplyPanGestureOnMaxView() ->Void
    {
        let panRec = UIPanGestureRecognizer()
        panRec.addTarget(self, action: #selector(draggedView_Max))
        maxView.isUserInteractionEnabled = true
        maxView.addGestureRecognizer(panRec)
    }
    
    func draggedView_Max(sender:UIPanGestureRecognizer)
    {
        //print("Bismillah")
        
        let translation = sender.translation(in: self)
        var currentFrame = maxView.frame
        let mixFrameX = minView.frame.origin.x + cubeWidth
        let maxFrameXValue = innerSlideView.frame.size.width
        if((currentFrame.origin.x + translation.x) > mixFrameX && (currentFrame.origin.x + translation.x) < maxFrameXValue)
        {
            currentFrame.origin.x = currentFrame.origin.x + translation.x
            maxView.frame = currentFrame
            sender.setTranslation(CGPoint(x: 0, y: 0), in: self)
        }
        
        self.UpdateTheLabelValue_Max()
        
        if(DataManager.dataManagerSharedInstance.controllerTabNumber == 5)
        {
            var userInfo:[String : String] = [String : String]()
            let minLabeltext:String = self.minLabel.text!
            let maxLabeltext:String = self.maxLabel.text!
            userInfo["min"] = minLabeltext
            userInfo["max"] = maxLabeltext
            NotificationCenter.default.post(name: NSNotification.Name("AwsomeSliderMoved"), object: nil, userInfo: userInfo)
        }
 
    }
    
    func UpdateTheLabelValue_Max() -> Void
    {
        var xValue = (innerSlideView.frame.size.width * DataManager.dataManagerSharedInstance.maxValueSLider)/100
        xValue = sideAlignMent + xValue - cubeWidth/2
        let newValue = (100 * (maxView.frame.origin.x - sideAlignMent + cubeWidth/2)) / innerSlideView.frame.size.width
        
        DataManager.dataManagerSharedInstance.maxValueSLider = newValue
        maxLabel.text = String(describing: Int(DataManager.dataManagerSharedInstance.maxValueSLider))
    }

}
