//
//  ItemInformationTableViewCell.swift
//  Easy As Pie
//
//  Created by Jared Cassoutt on 10/1/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import UIKit

class ItemInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cookTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
