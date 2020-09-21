//
//  RecipieData.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/19/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation

struct recipies: Decodable {
    let title: String
    let image: String
    let missedIngredientCount: Int
    let likes: Int
    let usedIngredientCount: Int
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case missedIngredientCount = "missedIngredientCount"
        case likes = "likes"
        case usedIngredientCount = "usedIngredientCount"
    }
}
