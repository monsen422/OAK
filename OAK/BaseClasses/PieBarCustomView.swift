//
//  PieBarCustomView.swift
//  OAK
//
//  Created by Mac on 14/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieBarCustomView: UIView {

    var arrayReference = NSMutableArray()
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if(DataManager.dataManagerSharedInstance.isMonthSelected)
        {
            arrayReference = DataManager.dataManagerSharedInstance.dataArray
        }
        else
        {
            arrayReference = DataManager.dataManagerSharedInstance.quaterArray
        }
        
        // Making bg Color of All View
        UIColor(hexString: "F2F2F2")?.setFill()
        UIRectFill(rect)
        
        
        let fullWidth = Double(rect.size.width)
        let currentObject = arrayReference[self.tag] as! jsonStandard
        let currentValue = Double(currentObject["count"] as! String)!
        //currentValue : 100 :: x : fullWidth
        let currentWidth = (fullWidth * currentValue)/100
        let currentX = self.calculatePreviousFrame(rect)
        //print("The INteger Value is :: \(currentValue)")
        let contentFrame = CGRect(origin: CGPoint(x: currentX, y: 0), size: CGSize(width: CGFloat(currentWidth), height: rect.size.height))
        UIColor(hexString: "DA844B")?.setFill()
        UIRectFill(contentFrame)
        
    }
    
    func calculatePreviousFrame(_ rect: CGRect) -> CGFloat
    {
        var returnValue:CGFloat = 0.0
        var totalCount = 0.0
        //for i in 0...self.tag
        var i=0
        while(i < self.tag)
        {
            let currentObject = arrayReference[i] as! jsonStandard
            let currentValue = Double(currentObject["count"] as! String)!
            totalCount = totalCount + currentValue
            
            i = i+1
        }
        
        if(self.tag == 0)
        {
            totalCount = 0.0
        }
        
        let fullWidth = Double(rect.size.width)
        let currentWidth = (fullWidth * totalCount)/100
        
        returnValue = CGFloat(currentWidth)
        return returnValue
        
    }
    

}
