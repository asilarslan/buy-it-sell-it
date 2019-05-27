//
//  AdDetailViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class AdDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var adImagesHeaderView: AdImagesHeaderView!
    
    var ad : Ad!
    
    var suggestionsAdvertisements = [Ad]()
    
    struct Storyboard {
        static let showImagesPageVC = "AdImagesPageViewController"
        static let adDetailCell = "AdDetailCell"
        static let productDetailCell = "AdDetailsCell"
        static let suggestionCell = "SuggestionCell"
        static let buyButtonCell = "MessageButtonCell"
        static let callButtonCell = "CallButtonCell"
        static let messageAndCallButtonCell = "MessageAndCallButtonCell"
    }

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
                    
//                    let userUrl = URL(string: (adJson["user"]["image"].stringValue))
//                    let userData = try? Data(contentsOf: userUrl!)
//                    let userImage = UIImage(data: userData!)
//                    let user = User(username: adJson["user"]["name"].stringValue, profileImage:userImage!)
                    
                    
                    let user = User(username: adJson["user"]["name"].stringValue, profileImageUrl:(adJson["user"]["image"].stringValue))
                    
                    var images = [String]()
                    for imageJson in adJson["images"].arrayValue{
//                        let url = URL(string: imageJson.stringValue)
//                        let data = try? Data(contentsOf: url!)
//                        let image = UIImage(data: data!)
                        images.append(imageJson.stringValue)
                    }
                    let ad = Ad(id: adJson["id"].intValue, imageUrls:images , name: adJson["name"].stringValue, location: adJson["location"].stringValue, price: adJson["price"].doubleValue, adDescription: adJson["description"].stringValue, createdBy: user)
                    self.suggestionsAdvertisements.append(ad)
                    
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showImagesPageVC {
            if let imagesPageVC = segue.destination as? AdImagesViewController {
//                imagesPageVC.images = ad.images!
                imagesPageVC.imageUrls = ad.imageUrls!
                imagesPageVC.pageViewControllerDelegate = adImagesHeaderView
            }
        }
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 0 - shoe detail cell
        // 1 - buy button
        // 2 - shoe full details button cell
        // 3 - you might like this cell
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.adDetailCell, for: indexPath) as! AdDetailTableViewCell
            cell.adNameLabel.text = ad.name
            cell.adDescriptionLabel.text = ad.adDescription
            cell.selectionStyle = .none
            
            return cell
        } else if indexPath.row == 1 {
            if ad.contactType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buyButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if ad.contactType == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.callButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if ad.contactType == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.messageAndCallButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buyButtonCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productDetailCell, for: indexPath)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.suggestionCell, for: indexPath) as! SuggestionTableViewCell
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if indexPath.row == 3 {
            if let cell = cell as? SuggestionTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                cell.collectionView.isScrollEnabled = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return CGFloat((self.suggestionsAdvertisements.count / 2 ) == 0 ? 185 : (self.suggestionsAdvertisements.count / 2 )  * 185 + 68) 
//            return self.tableView.bounds.width + 68
        } else {
            return UITableViewAutomaticDimension
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



// MARK: - UICollectionViewDataSource

extension AdDetailViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.suggestionsAdvertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.suggestionCell, for: indexPath) as! SuggestionCollectionViewCell
//        let shoes = Shoe.fetchShoes()
//        cell.image = shoes[indexPath.item].images?.first
        cell.imageView.sd_setImage(with: URL(string: (suggestionsAdvertisements[indexPath.item].imageUrls?.first)!), placeholderImage: UIImage(named: "placeholder.png"))//.image = suggestionsAdvertisements[indexPath.item].images?.first
        return cell
    }
    
}

extension AdDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        let itemWidth = (collectionView.bounds.width - 5.0) / 2.0
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
