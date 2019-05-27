//
//  SearchResultViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 28.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchResultViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    var advertisements = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "advertisements", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let advertisements = json["advertisements"].arrayValue
                for adJson:JSON in advertisements {
                    
                    //let userUrl = URL(string: (adJson["user"]["image"].stringValue))
                    //let userData = try? Data(contentsOf: userUrl!)
                    //let userImage = UIImage(data: userData!)
//                    let user = User(username: adJson["user"]["name"].stringValue, profileImage:userImage!)
                    
                    
                    let user = User(username: adJson["user"]["name"].stringValue, profileImageUrl:(adJson["user"]["image"].stringValue))
                    
//                    var images = [UIImage]()
//                    for imageJson in adJson["images"].arrayValue{
//                        let url = URL(string: imageJson.stringValue)
//                        let data = try? Data(contentsOf: url!)
//                        let image = UIImage(data: data!)
//                        images.append(image!)
//                    }
                    var images = [String]()
                    for imageJson in adJson["images"].arrayValue{
                        images.append(imageJson.stringValue)
                    }
                    let ad = Ad(id: adJson["id"].intValue, imageUrls:images , name: adJson["name"].stringValue, location: adJson["location"].stringValue, price: adJson["price"].doubleValue, adDescription: adJson["description"].stringValue, contactType: adJson["contactType"].intValue, createdBy: user)
                    self.advertisements.append(ad)
                    
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
            
        return advertisements.count
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "search_result_item", for: indexPath)as! SearchResultItemTableViewCell
        
        let ad = advertisements[indexPath.row]
//        cell.adImage.image = ad.images?.first
//        cell.name.text = ad.name
//        cell.location.text = ad.location
//        cell.price.text = String(ad.price)
        
        cell.ad = ad
        
        cell.selectionStyle = .none
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ad_detail",
            let destination = segue.destination as? AdDetailViewController,
            let index = tableView.indexPathForSelectedRow?.row
        {
            destination.ad = advertisements[index]
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
