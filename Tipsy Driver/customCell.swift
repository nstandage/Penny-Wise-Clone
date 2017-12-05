//
//  customCell.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/29/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hourlyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
