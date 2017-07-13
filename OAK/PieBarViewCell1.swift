//
//  PieBarViewCell.swift
//  OAK
//
//  Created by Mac on 14/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieBarViewCell1: UITableViewCell {
    
    
    @IBOutlet var lbl_name_outlet: UILabel!
    @IBOutlet var lbl_count_outlet: UILabel!
    @IBOutlet var view_barView_outlet: PieBarCustomView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
