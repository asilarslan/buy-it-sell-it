//
//  SubSearchViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 28.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit

class SubSearchViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var parentCategory:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = parentCategory.name

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            return parentCategory.categories.count
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sub_search_header", for: indexPath)as! SubSearchHeaderTableViewCell
            cell.title.text = "Tüm \"" + parentCategory.name + "\" İlanları "
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sub_search_item", for: indexPath)as! SubSearchItemTableViewCell
        let category = parentCategory.categories[indexPath.row]
            cell.title.text = category.name
        cell.numberOfItems.text = "(" + String(category.numberOfItems) + ")"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
             if self.parentCategory.categories[indexPath.row].categories.count > 0 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "SubSearchViewController") as? SubSearchViewController
                controller?.parentCategory = parentCategory.categories[indexPath.row]
              
                self.navigationController?.pushViewController(controller!, animated: true)
             }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController")
                self.navigationController?.pushViewController(controller, animated: true)
            }
           
            
           
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if  segue.identifier == "show_sub_to_sub_search_categories",
//            let destination = segue.destination as? SubSearchViewController,
//            let index = tableView.indexPathForSelectedRow?.row
//        {
//            destination.parentCategory = parentCategory.categories[index]
//        }else if  segue.identifier == "show_search_result_for_last",
//            let destination = segue.destination as? SearchResultViewController,
//            let index = tableView.indexPathForSelectedRow?.row
//        {
//        }
//
//
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
