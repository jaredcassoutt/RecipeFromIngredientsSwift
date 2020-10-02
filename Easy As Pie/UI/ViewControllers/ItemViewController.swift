//
//  ItemViewController.swift
//  Easy As Pie
//
//  Created by Jared Cassoutt on 9/30/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recipeTableView: UITableView!
    var id = LocalData.selected.recipeID

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipe(id: id)
        recipeTableView.tableFooterView = UIView()
    }
//MARK:- Helper Functions
    
    func loadRecipe(id: Int) {
        //loads recipies to populate tableview
        LocalData.selected.recipeInfo = DetailedRecipe(title: "", image: "", readyInMinutes: 0, extendedIngredients: [String]())
        Networking().fetchRecipeData(id:String(id), success: { (decodedData) in
            var ingredientsArray = [String]()
            for ingredient in decodedData.extendedIngredients {
                ingredientsArray.append(ingredient.original)
            }
            LocalData.selected.recipeInfo = DetailedRecipe(title: decodedData.title, image: decodedData.image, readyInMinutes: decodedData.readyInMinutes, extendedIngredients: ingredientsArray)
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
//MARK:- Ingredients Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + LocalData.selected.recipeInfo.extendedIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //this cell simply displays the image of the recepe
            let cell = (tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as! ItemImageTableViewCell)
            guard let url = URL(string: LocalData.selected.recipeInfo.image) else {return cell}
            UIImage.getAt(url: url) { image in
                cell.itemImage.image = image
            }
            return cell
        }
        else if indexPath.row == 1 {
            //this is the second cell and has information such as the title and cook time
            let cell = (tableView.dequeueReusableCell(withIdentifier: "Information", for: indexPath) as! ItemInformationTableViewCell)
            cell.title.text = LocalData.selected.recipeInfo.title
            cell.cookTime.text = "Cook Time: \(LocalData.selected.recipeInfo.readyInMinutes) minutes"
            return cell
        }
        else {
            //these are the cells that contain each ingredient for the recipe and the amount that will be used
            let cell = (tableView.dequeueReusableCell(withIdentifier: "Ingredient", for: indexPath) as! ItemIngredientsTableViewCell)
            cell.ingredient.text = " - \(LocalData.selected.recipeInfo.extendedIngredients[indexPath.row-2])"
            return cell
        }
    }
}
