//
//  SuggestionTableViewCell.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
