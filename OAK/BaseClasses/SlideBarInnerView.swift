//
//  SlideBarInnerView.swift
//  OAK
//
//  Created by Mac on 20/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class SlideBarInnerView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        print("Bismillah, Inside The Draw rect of Inner View")
        
        let eachPortion = rect.size.width/CGFloat(DataManager.dataManagerSharedInstance.colorsArray.count)
        var i = 0
        while(i < DataManager.dataManagerSharedInstance.colorsArray.count)
        {
            // Setting Color
            let portionFrame = CGRect(origin: CGPoint(x: (eachPortion * CGFloat(i)), y: 0), size: CGSize(width: eachPortion, height:rect.size.height))
            UIColor(hexString: DataManager.dataManagerSharedInstance.colorsArray[i])?.setFill()
            UIRectFill(portionFrame)
            
            if(i != 0)
            {
                // Setting White View
                let whitePortionFrame = CGRect(origin: CGPoint(x: (eachPortion * CGFloat(i)), y: 0), size: CGSize(width: 1.0, height:rect.size.height))
                UIColor.white.setFill()
                UIRectFill(whitePortionFrame)
            }
            
            i+=1
        }
        
        let superView = self.superview as! SliderBarViewUmair
        self.layer.cornerRadius = superView.barHeight/2
        self.clipsToBounds = true
    }
 

}
