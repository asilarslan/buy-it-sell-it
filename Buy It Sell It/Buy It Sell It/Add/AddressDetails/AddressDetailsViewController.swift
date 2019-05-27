//
//  AddressDetailsViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 15.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,SelectionItemDelegate  {
    
    func selectedItem(index: Int, item: Selection) {
        let addressDetail = addressDetails[index]
        addressDetail.value = item.display
        addressDetails[index] = addressDetail
        tableView.reloadData()
    }
    
    @IBOutlet var tableView: UITableView!
    var addressDetails = [AddressDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "address", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let addressElements = json["address"].arrayValue
                for addressElementJson:JSON in addressElements {
                    if addressElementJson["type"].stringValue == "selection" {
                        var selections = [Selection]()
                        for selectionJson in addressElementJson["items"].arrayValue {
                            selections.append(Selection(id: selectionJson["id"].intValue, display: selectionJson["display"].stringValue))
                        }
                        let adDetail = AddressDetail(id: addressElementJson["id"].intValue, type: addressElementJson["type"].stringValue, name: addressElementJson["name"].stringValue, display: addressElementJson["display"].stringValue , items: selections)
                        
                        self.addressDetails.append(adDetail)
                    }
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
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
        
        return addressDetails.count
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let addressDetail = addressDetails[indexPath.row]
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "address_selection_item", for: indexPath)as! AddressDetailTableViewCell
            cell.name.text = addressDetail.display
            cell.value.text = addressDetail.value
            cell.selectionStyle = .none
        
            return cell
      
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressDetail = addressDetails[indexPath.row]
        
        if addressDetail.type == "selection" {
            
            if addressDetail.items != nil {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "SelectItemTableViewController") as! SelectItemTableViewController
                newViewController.delegate = self
                newViewController.index = indexPath.row
                newViewController.items = addressDetail.items
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
