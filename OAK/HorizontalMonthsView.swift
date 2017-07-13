//
//  HorizontalMonthsView.swift
//  OAK
//
//  Created by Mac on 12/03/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class HorizontalMonthsView: UIView {

    var arrayIndex:Int!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        let items = DataManager.dataManagerSharedInstance.swiftDictMonths["items"]! as! Dictionary<String,AnyObject?>
        let labels = items.keys.sorted()
        let dataMonth = items[labels[self.arrayIndex]] as! Array<Dictionary<String,AnyObject?>>
        
        let currentData = dataMonth[DataManager.dataManagerSharedInstance.tagOfMonth]
        let real_value =  currentData["real_value"] as? String
        let value = Int(real_value!)!
        
        print("---  -----   -----   ------  \(value)    -----   -----   ------  -----")
        
        //100 : self.width :: 70 : x
        let widthPercentage = (CGFloat(value) * self.frame.size.width)/100
        
        let rect:CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: widthPercentage, height: self.frame.size.height))
        let colorString = currentData["color"] as? String
        UIColor(hexString: colorString!)?.setFill()
        UIRectFill(rect)
        
        
    }
    

}
