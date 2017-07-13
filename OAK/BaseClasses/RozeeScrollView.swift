//
//  RozeeScrollView.swift
//  SeekerSwift1
//
//  Created by Mac on 09/01/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class RozeeScrollView: UIScrollView {

    
    // MARK: Variables
    public var contentHeight:CGFloat = 0.0
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        self.reloadMySelf()
    }
    
    // MARK: Custom Function
    /*
    private func reloadMySelf() ->Void
    {
        var theYFrame:CGFloat = 0
        //let subView = self.subviews
        let contentView = self.viewWithTag(786)
        let subView = contentView?.subviews
        print("Total SubView Count \(subView?.count)")
        for view in subView!
        {
            
            // Negation check of UIImageView is here because
            // In UIScrollView there are 2 UIIMageViews by default for horizontal and vertocle ScrollBars
            if(!(view is UIImageView))
            {
                // Casting the UIView to RozeeScrollChild
                let subView:RozeeScrollChild = view as! RozeeScrollChild
                
                // Check If Its Visible or Not
                if(subView.isVisible)
                {
                    // Fetching the Frame and setting its Y value + updating theYFrame variable
                    var frameOfSubview = subView.frame
                    frameOfSubview.origin.y = theYFrame
                    theYFrame = theYFrame + frameOfSubview.size.height
                    subView.frame = frameOfSubview
                    
                    // As Its Visible == true, making it unhidden
                    subView.isHidden = false
                }
                else
                {
                    // If Its Visible == false don't set its frame, and make it hidden
                    subView.isHidden = true
                }
                
            }
        }
    
    
        
        // Setting Content Height
        self.contentHeight = theYFrame
        
        // Setting ContentSize
        let myFrame = self.frame
        self.contentSize = CGSize(width: myFrame.size.width, height: contentHeight)
    }
 */
    
    private func reloadMySelf() ->Void
    {
        var theYFrame:CGFloat = 0
        let subView = self.subviews
        print("Total SubView Count \(subView.count)")
        for view in subView
        {
            
            // Negation check of UIImageView is here because
            // In UIScrollView there are 2 UIIMageViews by default for horizontal and vertocle ScrollBars
            if(!(view is UIImageView))
            {
                // Casting the UIView to RozeeScrollChild
                if view is RozeeScrollView
                {
                    let subView:RozeeScrollChild = view as! RozeeScrollChild
                    
                    // Check If Its Visible or Not
                    if(subView.isVisible)
                    {
                        // Fetching the Frame and setting its Y value + updating theYFrame variable
                        var frameOfSubview = subView.frame
                        frameOfSubview.origin.y = theYFrame
                        theYFrame = theYFrame + frameOfSubview.size.height
                        subView.frame = frameOfSubview
                        
                        // As Its Visible == true, making it unhidden
                        subView.isHidden = false
                    }
                    else
                    {
                        // If Its Visible == false don't set its frame, and make it hidden
                        subView.isHidden = true
                    }
                }
                
            }
        }
        
        // Setting Content Height
        self.contentHeight = theYFrame
        
        // Setting ContentSize
        let myFrame = self.frame
        self.contentSize = CGSize(width: myFrame.size.width, height: contentHeight)
    }
    
    public func changeVisibility(child:RozeeScrollChild , visibilityStatus:Bool) ->Void
    {
        child.isVisible = visibilityStatus
        self.reloadMySelf()
    }
    
    public func changeVisibility(childTag:Int , visibilityStatus:Bool) ->Void
    {
        let subView = self.viewWithTag(childTag) as! RozeeScrollChild
        subView.isVisible = visibilityStatus
        self.reloadMySelf()
    }

}
