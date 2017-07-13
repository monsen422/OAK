//
//  MonthDetailCell.swift
//  OAK
//
//  Created by Mac on 12/03/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class MonthDetailCell: UITableViewCell {
    
    
    @IBOutlet var lbl_catName: UILabel!
    @IBOutlet var view_barViewMonths: HorizontalMonthsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
