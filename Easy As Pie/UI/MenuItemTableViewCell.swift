//
//  MenuItemTableViewCell.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/20/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLikes: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var menuMissingIngredients: UILabel!
    
    
    override func awakeFromNib() {
        menuImage.layer.cornerRadius = 10
        background.layer.cornerRadius = 10
        background.layer.masksToBounds = true
        //setting shadow for each cell
        background.layer.shadowColor = UIColor.label.cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        background.layer.shadowRadius = 3.0
        background.layer.shadowOpacity = 0.25
        background.layer.masksToBounds = false
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
