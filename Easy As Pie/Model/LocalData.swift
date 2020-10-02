//
//  LocalData.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/20/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation
class LocalData {
    struct recipies {
        static var recipieList = [Recipie]()
        static var counter = 0
    }
    struct selected {
        static var recipeID = 0
        static var recipeInfo = DetailedRecipe(title: "", image: "", readyInMinutes: 0, extendedIngredients: [String]())
    }
}
