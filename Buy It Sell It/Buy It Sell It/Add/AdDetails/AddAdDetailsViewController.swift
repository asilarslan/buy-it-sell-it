//
//  AddAdDetailsViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 1.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol SelectionItemDelegate {
    func selectedItem(index:Int, item:Selection)
}

class AddAdDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,SelectionItemDelegate {
    func selectedItem(index: Int, item: Selection) {
        let adDetail = adDetails[index]
        adDetail.value = item.display
        adDetails[index] = adDetail
        tableView.reloadData()
    }
    
   
    
    
    @IBOutlet var tableView: UITableView!
    var adDetails = [AdDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "create_ad", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let adElements = json["create_ad_elements"].arrayValue
                for adElementJson:JSON in adElements {
                    if adElementJson["type"].stringValue == "selection" {
                        var adSelections = [Selection]()
                        for adSelectionJson in adElementJson["items"].arrayValue {
                            adSelections.append(Selection(id: adSelectionJson["id"].intValue, display: adSelectionJson["display"].stringValue))
                        }
                        let adDetail = AdDetail(id: adElementJson["id"].intValue, type: adElementJson["type"].stringValue, name: adElementJson["name"].stringValue, display: adElementJson["display"].stringValue , items: adSelections)
                        
                        self.adDetails.append(adDetail)
                    }else{
                        let adDetail = AdDetail(id: adElementJson["id"].intValue, type: adElementJson["type"].stringValue, name: adElementJson["name"].stringValue, display: adElementJson["display"].stringValue)
                        
                        self.adDetails.append(adDetail)
                    }
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return adDetails.count
        
        
    }
   
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let adDetail = adDetails[indexPath.row]
        
        if adDetail.type == "selection" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ad_selection_item", for: indexPath)as! AdSelectionTableViewCell
            cell.name.text = adDetail.display
            cell.value.text = adDetail.value
            cell.selectionStyle = .none
            
            
            return cell
        }else{
            if adDetail.name == "title" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ad_title_item", for: indexPath)as! AdTitleTableViewCell
                cell.name.text = adDetail.display
                cell.value.text = adDetail.value
                cell.selectionStyle = .none
                return cell
            }else if adDetail.name == "description" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ad_description_item", for: indexPath)as! AdDescriptionTableViewCell
                cell.name.text = adDetail.display
                cell.value.text = adDetail.value
                cell.selectionStyle = .none
                return cell
            }else if adDetail.name == "price" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ad_price_item", for: indexPath)as! AdPriceTableViewCell
                cell.name.text = adDetail.display
                cell.value.text = adDetail.value
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ad_input_item", for: indexPath)as! AdInputTableViewCell
                cell.name.text = adDetail.display
                cell.value.text = adDetail.value
                cell.selectionStyle = .none
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let adDetail = adDetails[indexPath.row]
        
        if adDetail.type == "selection" {
            
            if adDetail.items != nil {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectItemTableViewController") as! SelectItemTableViewController
                newViewController.delegate = self
                newViewController.index = indexPath.row
                newViewController.items = adDetail.items
                self.navigationController?.pushViewController(newViewController, animated: true)
                
            }
            
            
         }
        
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
