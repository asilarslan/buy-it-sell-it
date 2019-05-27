//
//  ContactDetailsViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 20.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContactDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var contactDetail : ContactDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "contacts", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var selections = [Selection]()
                
                for selectionJson in json["items"].arrayValue {
                    selections.append(Selection(id: selectionJson["id"].intValue, display: selectionJson["display"].stringValue))
                }
                
                if selections.count > 0 {
                    self.contactDetail = ContactDetail(id: json["id"].intValue, type: json["type"].stringValue, name: json["name"].stringValue, display: json["display"].stringValue , items: selections, value: selections[0])
                    
                    self.tableView.reloadData()
                }
                
                
                
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "İletişim Bilgileri"
        }else{
            return "İletişim Tercihleri"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }else{
            if contactDetail != nil && contactDetail.items != nil {
                return contactDetail.items.count
            }else {
                return 0
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "contact_info", for: indexPath)as! ContactInfoTableViewCell
                cell.name.text = "Adı Soyadı"
                cell.value.text = "Asil Arslan"
                cell.selectionStyle = .none
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "contact_info", for: indexPath)as! ContactInfoTableViewCell
                cell.name.text = "Cep Telefonu"
                cell.value.text = "0123456789"
                cell.selectionStyle = .none
                
                return cell
            }
            
        }else{
            let item = contactDetail.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "contact_choose", for: indexPath)
            cell.textLabel?.text = item.display
            if contactDetail.value != nil && contactDetail.value.id == item.id {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            cell.selectionStyle = .none
            
            return cell
        } 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if contactDetail.items != nil {
            
            contactDetail.value = contactDetail.items[indexPath.row]
            tableView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add_ad_preview" {
            if let previewVC = segue.destination as? PreviewViewController {
                //                imagesPageVC.images = ad.images!
                
                var images = [UIImage]()
                images.append(#imageLiteral(resourceName: "example_ad_image"))
                images.append(#imageLiteral(resourceName: "example_ad_image"))
                images.append(#imageLiteral(resourceName: "example_ad_image"))
                images.append(#imageLiteral(resourceName: "example_ad_image"))
                
                let user = User(username: "Asil Arslan", profileImageUrl: "https://media-exp2.licdn.com/mpr/mpr/shrinknp_400_400/AAMAAgDGAAwAAQAAAAAAAAs1AAAAJGQ0ZjBhMWVlLTIwMWEtNDJlOC1hY2YxLWM4YmUzYmY2YzkzOQ.jpg")
                
                let ad = Ad(id: 1, images: images, name: "İlan 1", location: "İlan Konum", price: 123.4, adDescription: "asasadsad", contactType: 3, createdBy: user)
                
                previewVC.ad = ad
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
