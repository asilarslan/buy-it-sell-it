//
//  AdImageViewController.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit
import SDWebImage

class AdImageViewController: UIViewController {
    
    var imageUrl:String? {
        didSet {
            if imageView != nil {
              imageView.sd_setImage(with: URL(string: imageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
            }
            
        }
    }
    @IBOutlet var imageView: UIImageView!
    var image : UIImage? {
                didSet {
                    if self.imageView != nil {
                        self.imageView.image = image
                    }
                }
            }
//    var imageString: String? {
//        didSet {
//            URLSession.shared.dataTask(with: NSURL(string: imageString!)! as URL, completionHandler: { (data, response, error) -> Void in
//                
//                if error != nil {
//                    print(error)
//                    return
//                }
//                DispatchQueue.main.async(execute: { () -> Void in
//                    let image = UIImage(data: data!)
//                    self.image = image
//                    if self.imageView != nil {
//                        self.imageView.image = image
//                    }
//                })
//                
//            }).resume()
////            let url = URL(string: imageString!)
////            Image.default.downloadImage(with: url!, options: [], progressBlock: nil) {
////                (image, error, url, data) in
////                self.image = image
////            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageUrl != nil {
            imageView.sd_setImage(with: URL(string: imageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
        if image != nil {
            imageView.image = image
        }
        
    }
}


