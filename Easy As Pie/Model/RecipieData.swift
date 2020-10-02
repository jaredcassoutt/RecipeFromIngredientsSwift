//
//  RecipieData.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/19/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation

struct recipes: Decodable {
    let id: Int
    let title: String
    let image: String
    let missedIngredientCount: Int
    let likes: Int
    let usedIngredientCount: Int
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case missedIngredientCount = "missedIngredientCount"
        case likes = "likes"
        case usedIngredientCount = "usedIngredientCount"
    }
}

struct recipe: Decodable {
    let title: String
    let image: String
    let readyInMinutes: Int
    let extendedIngredients: [extendedIngredients]
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
        case readyInMinutes = "readyInMinutes"
        case extendedIngredients = "extendedIngredients"
        
    }
}

struct extendedIngredients: Decodable {
    let original: String
    private enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
