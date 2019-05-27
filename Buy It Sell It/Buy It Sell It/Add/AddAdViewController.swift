//
//  AddAdViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddAdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var buttonBack: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var categories = [Category]()
    var selectedCategories = [Category]()
    var selectedCategory : Category!
    
    @IBOutlet var labelSelectedCategories: UILabel!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewCategory: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelSelectedCategories.lineBreakMode = .byWordWrapping
        labelSelectedCategories.numberOfLines = 0;

        let path = Bundle.main.path(forResource: "categories", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let categories = json["categories"].arrayValue
                for subCategoryJson:JSON in categories {
                    let category = Category(id: subCategoryJson["id"].intValue, icon: subCategoryJson["icon"].stringValue, name: subCategoryJson["name"].stringValue,numberOfItems:subCategoryJson["number_of_items"].intValue, categoryDescription: subCategoryJson["description"].stringValue, categories: [])
                    self.addCategories(category: category, jsonCategories: subCategoryJson["childs"].arrayValue)
                    self.categories.append(category)
                }
                self.selectedCategories = self.categories
                self.tableView.reloadData()
                self.buttonBackEnableDisable()
                
            case .failure(let error):
                print(error)
            }
        }
        
       

    }
    
    func addCategories(category:Category,jsonCategories: [JSON]){
        
        for subCategoryJson:JSON in jsonCategories {
            let subCategory = Category(id: subCategoryJson["id"].intValue, icon: subCategoryJson["icon"].stringValue, name: subCategoryJson["name"].stringValue,numberOfItems:subCategoryJson["number_of_items"].intValue, categoryDescription: subCategoryJson["description"].stringValue, category: category, categories: [])
            category.categories.append(subCategory)
            addCategories(category: subCategory,jsonCategories: subCategoryJson["childs"].arrayValue)
        }
    }
    
    @IBAction func buttonBackTapped(_ sender: Any) {
        
        
        if selectedCategory.category != nil {
            selectedCategory = selectedCategory.category
            selectedCategories = selectedCategory.categories
            tableView.reloadData()
            
            labelCategoryTitle()
            buttonBackEnableDisable()
            
        }else{
            
            UIView.animate(withDuration: 0.0, animations: {
                
                
                self.viewSearch.alpha = 1.0
                self.viewCategory.alpha = 0
                
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: 0.0){
                    
                    self.viewSearch.isHidden = false
                    self.viewCategory.isHidden = true
                    
                    
                    self.selectedCategory = nil
                    self.selectedCategories = self.categories
                    self.tableView.reloadData()
                    self.labelCategoryTitle()
                    self.buttonBackEnableDisable()
                    
                }
            })
        }
        
    }
    
    func buttonBackEnableDisable(){
        if selectedCategory != nil {
            buttonBack.title = "Geri"
            buttonBack.isEnabled = true
        }else{
            buttonBack.title = ""
            buttonBack.isEnabled = false
        }

    }
    
    
    func labelCategoryTitle(){
        if selectedCategory != nil {
            var tempSelectedCategory = selectedCategory
            var tempSelectedCategories = [Category]()
            while tempSelectedCategory != nil {
                tempSelectedCategories.append(tempSelectedCategory!)
                tempSelectedCategory = tempSelectedCategory?.category
            }
            
            var labelSelectedCategories = ""
            for tempSelectedCategory in tempSelectedCategories.reversed() {
                if tempSelectedCategories.last?.name != tempSelectedCategory.name {
                    labelSelectedCategories = labelSelectedCategories + " > "
                }
                labelSelectedCategories = labelSelectedCategories + tempSelectedCategory.name
                
            }
            
            self.labelSelectedCategories.text = labelSelectedCategories
            
        }else{
            self.labelSelectedCategories.text = ""
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
            
            return selectedCategories.count
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_header", for: indexPath)as! AddHeaderTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        
        let category = selectedCategories[indexPath.row]
        if category.category == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_item", for: indexPath)as! AddCategoryTableViewCell
        
            cell.icon.image = UIImage(named: category.icon)
            cell.name.text = category.name
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "add_sub_item", for: indexPath)as! AdSubCategoryTableViewCell

            cell.name.text = category.name
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            
            
            if selectedCategory == nil {
                
                
                UIView.animate(withDuration: 0.0, animations: {
                    
                    
                    self.viewCategory.alpha = 1.0
                    self.viewSearch.alpha = 0
                    
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: 0){
                        
                        self.viewSearch.isHidden = true
                        self.viewCategory.isHidden = false
                        
                        self.selectedCategory = self.selectedCategories[indexPath.row]
                        self.selectedCategories = self.selectedCategory.categories
                        self.tableView.reloadData()
                        self.labelCategoryTitle()
                        self.buttonBackEnableDisable()
                    }
                })
            }else{
                
                
                
                if selectedCategories[indexPath.row].categories.count == 0 {
                    
                    self.viewCategory.alpha = 0
                    self.viewSearch.alpha = 1.0
                    
                    self.viewSearch.isHidden = false
                    self.viewCategory.isHidden = true
                    
                    self.selectedCategory = nil
                    self.selectedCategories = self.categories
                    self.tableView.reloadData()
                    self.labelCategoryTitle()
                    self.buttonBackEnableDisable()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "AddAdDetailsViewController")
                    self.navigationController?.pushViewController(controller, animated: true)
                }else{
                    selectedCategory = selectedCategories[indexPath.row]
                    selectedCategories = selectedCategory.categories
                    tableView.reloadData()
                    labelCategoryTitle()
                    buttonBackEnableDisable()
                }
            }
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
