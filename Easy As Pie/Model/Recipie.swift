//
//  Recipie.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/20/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation
class Recipie {
    let title: String
    let image: String
    let missedIngredientCount: Int
    let likes: Int
    let usedIngredientCount: Int
    init(title: String, image: String, missedIngredientCount: Int, likes: Int, usedIngredientCount: Int) {
        self.title = title
        self.image = image
        self.missedIngredientCount = missedIngredientCount
        self.likes = likes
        self.usedIngredientCount = usedIngredientCount
    }
}
