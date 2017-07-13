//
//  RangeSliderTrackLayer2.swift
//  OAK
//
//  Created by MobileDev on 9/15/16.
//  Copyright © 2016 MobileDev. All rights reserved.
//

import UIKit

class RangeSliderTrackLayer2: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var colors:[UIColor] =  [UIColor.red]{
        didSet {
            setNeedsLayout()
        }
    }
    var sliderButtons: [UIButton] = []
    var stars: Int = 11
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        colors = [
            hexStringToUIColor("#CF5647"), hexStringToUIColor("#D36C48"), hexStringToUIColor("#DA844B"), hexStringToUIColor("#DF9E4E"), hexStringToUIColor("#E6B84F"), hexStringToUIColor("#D6C257"), hexStringToUIColor("#B1BA64"), hexStringToUIColor("#8BB672"), hexStringToUIColor("#66B182"), hexStringToUIColor("#44AB91"), hexStringToUIColor("#44AB91"), hexStringToUIColor("#49AA91")]
        for index in 0...11 {
            let button = UIButton()
            button.backgroundColor = colors[index];
            
            button.adjustsImageWhenHighlighted = false
            
            sliderButtons += [button]
            addSubview(button)
        }
        
    }
 
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: 42, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in sliderButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (42))
            button.frame = buttonFrame
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    

}
