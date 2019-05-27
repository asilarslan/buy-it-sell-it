//
//  PostCell.swift
//  Facebook+Research
//
//  Created by Duc Tran on 3/20/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import SDWebImage

class PostCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postImageViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var ad: Ad! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
//        profileImageView.image = ad.createdBy.profileImage
        profileImageView.sd_setImage(with: URL(string: (ad.createdBy.profileImageUrl)!), placeholderImage: UIImage(named: "placeholder.png"))
        profileImageView.layer.cornerRadius = 3.0
        profileImageView.layer.masksToBounds = true
        
        usernameLabel.text = ad.createdBy.username
        timeAgoLabel.text = ad.location
        captionLabel.text = ad.name
        
        postImageView.sd_setImage(with: URL(string: (ad.imageUrls?.first)!), placeholderImage: UIImage(named: "placeholder.png"))

        postImageView.layer.cornerRadius = 5.0
        postImageView.layer.masksToBounds = true
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
    {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            // - change the image height
            postImageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
}

class PostCell: UITableViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postStatsLabel: UILabel!
    
    var post: Post! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        profileImageView.image = post.createdBy.profileImage
        usernameLabel.text = post.createdBy.username
        timeAgoLabel.text = post.location
        captionLabel.text = post.description
        postImageView.image = post.image
        postStatsLabel.text = "\(post.price!) Likes     \(post.numberOfComments!) Comments     \(post.numberOfShares!) Shares"
    }
}








