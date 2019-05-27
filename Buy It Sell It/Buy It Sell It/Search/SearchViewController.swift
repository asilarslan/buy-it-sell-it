//
//  SearchViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 27.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories = [Category]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "categories", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let categories = json["categories"].arrayValue
                for subCategoryJson:JSON in categories {
                    //print("subJson: \(subCategoryJson)")
                    let category = Category(id: subCategoryJson["id"].intValue, icon: subCategoryJson["icon"].stringValue, name: subCategoryJson["name"].stringValue,numberOfItems:subCategoryJson["number_of_items"].intValue,  categoryDescription: subCategoryJson["description"].stringValue, categories: [])
                    self.addCategories(category: category, jsonCategories: subCategoryJson["childs"].arrayValue)
                    self.categories.append(category)
                    self.printCategory(category: category)
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func addCategories(category:Category,jsonCategories: [JSON]){
        
        for subCategoryJson:JSON in jsonCategories {
            let subCategory = Category(id: subCategoryJson["id"].intValue, icon: subCategoryJson["icon"].stringValue, name: subCategoryJson["name"].stringValue,numberOfItems:subCategoryJson["number_of_items"].intValue, categoryDescription: subCategoryJson["description"].stringValue,category:category, categories: [])
           category.categories.append(subCategory)
            addCategories(category: subCategory,jsonCategories: subCategoryJson["childs"].arrayValue)
        }
    }
    
    
    func printCategory(category:Category){
        print(category.name)
        for subCategory in category.categories {
            printCategory(category: subCategory)
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            
            return 1
        }else{
            
            return categories.count
        }
        
        
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath)as! SearchTableViewCell
            
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "category_cell", for: indexPath)as! CategoryTableViewCell
        
        let category = categories[indexPath.row]
        cell.icon.image = UIImage(named: category.icon)
        cell.name.text = category.name
        cell.categoryDescription.text = category.categoryDescription
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "show_sub_search_categories",
            let destination = segue.destination as? SubSearchViewController,
            let index = tableView.indexPathForSelectedRow?.row
        {
            destination.parentCategory = categories[index]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
