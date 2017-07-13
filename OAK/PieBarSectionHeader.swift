//
//  PieBarSectionHeader.swift
//  OAK
//
//  Created by Mac on 14/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieBarSectionHeader: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var view_dropDownCOntainer_outlet: RozeeUIView!
    @IBOutlet var selectionLabel_outlet: UILabel!
    
    @IBAction func DropDownBtnPressed_Action(_ sender: UIButton)
    {
        if(sender.tag == 1)
        {
            DataManager.dataManagerSharedInstance.isMonthSelected = true
            selectionLabel_outlet.text = "MONTHLY"
        }
        else if(sender.tag == 2)
        {
            DataManager.dataManagerSharedInstance.isMonthSelected = false
            selectionLabel_outlet.text = "QUATERLY"
        }
        self.openDropDown(sender)
        
        NotificationCenter.default.post(name: Notification.Name("PieBarDropDownChanged"), object: nil)
    }
    
    @IBAction func openDropDown(_ sender: UIButton)
    {
        if view_dropDownCOntainer_outlet.isHidden
        {
            view_dropDownCOntainer_outlet.isHidden = false
        }
        else
        {
            view_dropDownCOntainer_outlet.isHidden = true
        }
    }
    

}
