//
//  Networking.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/19/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import Foundation

class Networking {
    
    let apiKey = ""
    
    func fetchRecipes(ingredients: String, loadNumber: Int, success:@escaping (_ data:[recipes])->(),failure:@escaping (_ error:Error)->()) {
        //api call to get list of recipe data to display in UITableView
        let ingredientsArray = ingredients.components(separatedBy: ",")
        var appendedString = ""
        for ingredient in ingredientsArray {
            appendedString = appendedString+"\(ingredient),+"
        }
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(appendedString.dropLast(2))&number=\(loadNumber)&apiKey=\(apiKey)"
        print(urlString)
        //create a url
        if let url = URL(string: urlString) {
            //create URLSession
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([recipes].self, from: safeData)
                        print(decodedData)
                        success(decodedData)
                    }
                    catch {
                        print(error)
                    }
                }
            }
            //Start task
            task.resume()
        }
    }
    
    
    
    func fetchRecipeData(id: String, success:@escaping (_ data:recipe)->(),failure:@escaping (_ error:Error)->()) {
        let urlString = "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=\(apiKey)"
        print(urlString)
        //create a url
        if let url = URL(string: urlString) {
            //create URLSession
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(recipe.self, from: safeData)
                        print(decodedData)
                        success(decodedData)
                    }
                    catch {
                        print(error)
                    }
                }
            }
            //Start task
            task.resume()
        }
    }
}
