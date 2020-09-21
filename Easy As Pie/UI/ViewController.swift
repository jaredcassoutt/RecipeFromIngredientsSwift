//
//  ViewController.swift
//  Easy As Pie
//
//  Created by Jared cassoutt on 9/19/20.
//  Copyright © 2020 Jared Cassoutt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var recipieTableView: UITableView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var IngredientsSearchBar: UISearchBar!
    @IBOutlet weak var searchHeight: NSLayoutConstraint!
    let randomRecipieCategories = ["chicken", "sugar", "salt", "milk", "bread"]
    
    override func viewDidLoad() {
        hideKeyboardWithTouch()
        setUpSearchBar()
        loadRecipies(ingredients: randomRecipieCategories.randomElement()!, loadNumber: 10)
        super.viewDidLoad()
    }
    
//MARK: - UI Setup Methods

    func setUpSearchBar() {
        //sets search text color and cancel button color to white
        let textFieldInsideSearchBar = IngredientsSearchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        let appearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    func hideSearchBar() {
        //animates a disapearing of searchbar which shrinks the gradient view
        UIView.animate(withDuration: 0.35) {
            self.searchHeight.constant = 6
            self.IngredientsSearchBar.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func showSearchBar() {
        //animates apearing of searchbar which increase the gradient view height
        UIView.animate(withDuration: 0.35) {
            self.searchHeight.constant = 56
            self.IngredientsSearchBar.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    
    
// MARK: - TableView
    
    //The following section activates a scroll animation that hides and shows the search bar
    var lastContentOffset: CGFloat = 0
    var timeScrollingBegan: Date?
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timeScrollingBegan = Date()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == recipieTableView {
            if self.lastContentOffset < scrollView.contentOffset.y {
                hideSearchBar()
                dismisKeyboard()
                
            }
            else if self.lastContentOffset > scrollView.contentOffset.y {
                showSearchBar()
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == recipieTableView {
             timeScrollingBegan = nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalData.recipies.recipieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "Menu Item", for: indexPath) as! MenuItemTableViewCell)
        cell.menuTitle.text = LocalData.recipies.recipieList[indexPath.row].title
        cell.menuLikes.text = "\(LocalData.recipies.recipieList[indexPath.row].likes)"
        cell.menuMissingIngredients.text = "Missing Ingredients: \(LocalData.recipies.recipieList[indexPath.row].likes)"
        guard let url = URL(string: LocalData.recipies.recipieList[indexPath.row].image) else {return cell}
        UIImage.getAt(url: url) { image in
            cell.menuImage.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //displays new recipies as user scrolls down until item 100 is reached
        tableView.addLoading(indexPath) {
            self.loadRecipies(ingredients: self.randomRecipieCategories.randomElement()!, loadNumber: self.findLoadNumber(loadNumber: LocalData.recipies.counter))
            tableView.stopLoading()
        }
    }

    
    // MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //new recipies populate based on ingredients typed
        LocalData.recipies.recipieList = [Recipie]()
        self.loadRecipies(ingredients: searchText, loadNumber: 10)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //new recipies populate and keyboard resigns when searched
        LocalData.recipies.recipieList = [Recipie]()
        self.loadRecipies(ingredients: searchBar.text ?? "", loadNumber: 10)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchBar shows cancel button when editing
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //when cancel button is clicked the recipie list resets to items with a random ingredient, the table is reloaded, the text is eliminated and the searchbar is no longer being edited so keyboard is dismissed
        LocalData.recipies.recipieList = [Recipie]()
        self.loadRecipies(ingredients: randomRecipieCategories.randomElement()!, loadNumber: 10)
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
    
//MARK: - Helper Methods
    
    func findLoadNumber(loadNumber: Int) -> Int {
        //helps to find the number of items to load
        if loadNumber < 100{
            LocalData.recipies.counter = LocalData.recipies.counter+10
            return loadNumber+10
        }
        return 100
    }
    
    func loadRecipies(ingredients: String, loadNumber: Int) {
        //loads recipies to populate tableview
        Networking().fetchRecipies(ingredients: ingredients, loadNumber: loadNumber, success: { (decodedData) in
            LocalData.recipies.recipieList = [Recipie]()
            for recipie in decodedData {
                LocalData.recipies.recipieList.append(Recipie(title: recipie.title, image: recipie.image, missedIngredientCount: recipie.missedIngredientCount, likes: recipie.likes, usedIngredientCount: recipie.usedIngredientCount))
            }
            LocalData.recipies.counter = LocalData.recipies.recipieList.count
            DispatchQueue.main.async {
                self.recipieTableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
}

//MARK: - Extensions

extension UIImage {
    //helper function to access online images from api
    public static func getAt(url: URL, success: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let newData = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    success(UIImage(data: newData))
                }
            } else {
                DispatchQueue.main.async {
                    success(nil)
                }
            }
        }
    }

}

extension UIViewController {
    //hides the keyboard when user clicks outside the keybaord
    func hideKeyboardWithTouch() {
        let touch: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismisKeyboard))
        touch.cancelsTouchesInView = false
        view.addGestureRecognizer(touch)
    }
    @objc func dismisKeyboard() {
        view.endEditing(true)
    }
}

extension UITableView{
    //displays an loading indicator when bottom of UITableView is reached so new data can be loaded and appended
    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil{
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.isHidden = false
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            activityIndicatorView.isHidden = true
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }else{
            return activityIndicatorView
        }
    }
    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
        indicatorView().isHidden = false
    }
    func stopLoading(){
        indicatorView().stopAnimating()
        indicatorView().isHidden = true
    }
}
