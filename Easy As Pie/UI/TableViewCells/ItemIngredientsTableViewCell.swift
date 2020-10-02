//
//  ItemIngredientsTableViewCell.swift
//  Easy As Pie
//
//  Created by Jared Cassoutt on 10/1/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import UIKit

class ItemIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
