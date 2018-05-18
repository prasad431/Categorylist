//
//  CustomTableViewCell.swift
//  Categorylist
//
//  Created by Prasad on 16/05/18.
//  Copyright © 2018 HeadInfotech. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var idlabel: UILabel!
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var pricelabel: UILabel!
    @IBOutlet var sizelabel: UILabel!
    @IBOutlet var colorlabel: UILabel!
    @IBOutlet var orderCountLabel: UILabel!
    @IBOutlet var shareCountLabel: UILabel!
    @IBOutlet var viewCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
