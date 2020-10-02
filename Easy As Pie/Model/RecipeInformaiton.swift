//
//  File.swift
//  Easy As Pie
//
//  Created by Jared Cassoutt on 10/1/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation

class DetailedRecipe {
    let title: String
    let image: String
    let readyInMinutes: Int
    let extendedIngredients: [String]
    init (title: String, image: String, readyInMinutes: Int, extendedIngredients: [String]) {
        self.title = title
        self.image = image
        self.readyInMinutes = readyInMinutes
        self.extendedIngredients = extendedIngredients
    }
}
