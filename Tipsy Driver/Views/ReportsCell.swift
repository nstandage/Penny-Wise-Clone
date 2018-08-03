//
//  ReportsCell.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 8/3/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class ReportsCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
