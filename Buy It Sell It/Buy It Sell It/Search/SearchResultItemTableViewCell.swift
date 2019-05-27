//
//  SearchResultItemTableViewCell.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 28.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultItemTableViewCell: UITableViewCell {
    
    @IBOutlet var adImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var price: UILabel!
    
    
    var ad: Ad! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        adImage.sd_setImage(with: URL(string: (ad.imageUrls?.first)!), placeholderImage: UIImage(named: "placeholder.png"))
        name.text = ad.name
        location.text = ad.location
        price.text = String(ad.price)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}
