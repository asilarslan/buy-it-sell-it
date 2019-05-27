//
//  AdDetailsViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 1.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AdDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var adDetails = [AdDetail]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "ad_details", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let adDetails = json["ad_details"].arrayValue
                for adDetailJson:JSON in adDetails {
                    let adDetail = AdDetail(id: adDetailJson["id"].intValue, display: adDetailJson["name"].stringValue, value: adDetailJson["value"].stringValue)
                    self.adDetails.append(adDetail)
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
        // #warning Incomplete implementation, return the number of rows
       return adDetails.count
    
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ad_details_item", for: indexPath)as! AdDetailsTableViewCell
        let adDetail = adDetails[indexPath.row]
        cell.name.text = adDetail.display
        cell.value.text = adDetail.value
        cell.selectionStyle = .none
        return cell
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
