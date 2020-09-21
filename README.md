# RecipieFromIngredientsSwift

This is an app that allows the user to input ingredients, seperated by a single comma, in a UISearchBar. As the user enters these ingredients, a UITableView is populated with a list of recipies that utilize these ingredients. The list is populated 10 items at a time and additional items are added as the user scrolls to the bottom. Animations hide and show the UISearchBar to increase and decrease the UITableView, respectively.

The data for this project is obtained using the [Spoonacular API](https://spoonacular.com/food-api)

If you wish to clone this project and run on your own device:
  1. Navigate to the Networking.swift file
  2. Replace the apiKey property within the Networking Class with your own API Key using the link above.
  3. Enjoy!

![](appdemo.GIF)
