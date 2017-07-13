//
//  OverLayViewUmair.swift
//  OAK
//
//  Created by Mac on 19/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class OverLayViewUmair: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        print("In Draw Function of OverLay View");
        
        /*
        let aPath2 = UIBezierPath()
        aPath2.move(to: CGPoint(x:self.frame.size.width/2, y:0))
        aPath2.addLine(to: CGPoint(x:self.frame.size.width/2, y:self.frame.size.height))
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        aPath2.close()
        //If you want to stroke it with a red color
        UIColor.brown.set()
        aPath2.stroke()
        //If you want to fill it as well
        aPath2.fill()
 */
        let aPath2 = UIBezierPath()
        aPath2.lineWidth = 2
        aPath2.move(to: CGPoint(x:0, y:self.frame.size.height))
        
        var i=0
        while(i < DataManager.dataManagerSharedInstance.x_axis_Points.count)
        {
            aPath2.addLine(to: CGPoint(x: (DataManager.dataManagerSharedInstance.x_axis_Points[i] - DataManager.dataManagerSharedInstance.valueX), y: DataManager.dataManagerSharedInstance.y_Axis_points_final[i]))
            i+=1
        }
        aPath2.addLine(to: CGPoint(x:self.frame.size.width-1, y:self.frame.size.height))
        aPath2.close()
        UIColor(hexString: DataManager.dataManagerSharedInstance.dotColorString)?.set()
        aPath2.stroke()
        aPath2.fill(with: CGBlendMode.lighten, alpha: 0.2)
        //aPath2.fill()
        
        /*
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.setFillColor(UIColor(hexString: DataManager.dataManagerSharedInstance.fillColorString) as! CGColor)
        ctx!.setStrokeColor(UIColor(hexString: DataManager.dataManagerSharedInstance.dotColorString) as! CGColor)
        */
    }
    

}
