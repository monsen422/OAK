//
//  Bar.swift
//  OAK
//
//  Created by MobileDev on 9/13/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit

class Bar: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(0.5)
        context?.setStrokeColor(UIColor.white.cgColor)
        let rectangle = CGRect(x: 0,y: 0,width: frame.size.width,height: frame.size.height)
        context?.addRect(rectangle)
        context?.strokePath()
    }
    

}
