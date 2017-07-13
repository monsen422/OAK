//
//  PieTableCell.swift
//  OAK
//
//  Created by Mac on 09/02/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class PieTableCell: UITableViewCell {
    
    
    @IBOutlet var lbl_name_outlet: UILabel!
    @IBOutlet var lbl_count_outlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
