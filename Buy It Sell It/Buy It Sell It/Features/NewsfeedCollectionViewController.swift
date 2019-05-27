//
//  NewsfeedCollectionViewController.swift
//  Facebook+Research
//
//  Created by Duc Tran on 3/20/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import SwiftyJSON
import SDWebImage
import FTImageSize

class NewsfeedCollectionViewController : UICollectionViewController
{
    var ads = [Ad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchPosts()
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
    
    func fetchPosts()
    {
        let path = Bundle.main.path(forResource: "features", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                
                
                let json = JSON(value)
                let advertisements = json["features"].arrayValue
                
                
                
                for adJson:JSON in advertisements {
                    
                    
//                    let userUrl = URL(string: (adJson["user"]["image"].stringValue))
//                    let userData = try? Data(contentsOf: userUrl!)
//                    let userImage = UIImage(data: userData!)
//                    let user = User(username: adJson["user"]["name"].stringValue, profileImage:userImage!)
                    
                    let user = User(username: adJson["user"]["name"].stringValue, profileImageUrl:adJson["user"]["image"].stringValue)
                    
                    var images = [String]()
                    for imageJson in adJson["images"].arrayValue{
                        
//                        let url = URL(string: imageJson.stringValue)
//                        let data = try? Data(contentsOf: url!)
//                        let image = UIImage(data: data!)
//                        images.append(image!)
                        images.append(imageJson.stringValue)
                    }
                    let ad = Ad(id: adJson["id"].intValue, imageUrls:images , name: adJson["name"].stringValue, location: adJson["location"].stringValue, price: adJson["price"].doubleValue, adDescription: adJson["description"].stringValue, contactType: adJson["contactType"].intValue, createdBy: user)
                    self.ads.append(ad)
                    
                }
                
                self.collectionView?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ad_detail_for_feature",
            let destination = segue.destination as? AdDetailViewController{
             let cell = sender as! PostCollectionViewCell
            let indexPath = collectionView?.indexPath(for: cell)
            let selectedData = ads[(indexPath?.row)!]
            destination.ad = selectedData
        }
    }
}

extension NewsfeedCollectionViewController
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
        cell.ad = self.ads[indexPath.item]
        return cell
    }
}

extension NewsfeedCollectionViewController : PinterestLayoutDelegate
{
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    {
        let ad = ads[indexPath.item]
        let photo = ad.images?.first
        
        let imageSize : CGSize = FTImageSize.getImageSizeFromImageURL((ad.imageUrls?.first)!, perferdWidth: width)
        
        return imageSize.height 


        
        if photo != nil {
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio: (photo?.size)!, insideRect: boundingRect)
            
            return rect.size.height
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    {
        let ad = ads[indexPath.item]
        let topPadding = CGFloat(8)
        let bottomPadding = CGFloat(12)
        let captionFont = UIFont.systemFont(ofSize: 15)
        let captionHeight = self.height(for: ad.adDescription!, with: captionFont, width: width)
        let profileImageHeight = CGFloat(36)
        let height = topPadding + captionHeight + topPadding + profileImageHeight + bottomPadding
            
        return height
    }
    
    func height(for text: String, with font: UIFont, width: CGFloat) -> CGFloat
    {
        let nsstring = NSString(string: text)
        let maxHeight = CGFloat(64.0)
        let textAttributes = [NSAttributedStringKey.font : font]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return ceil(boundingRect.height)
    }
}















