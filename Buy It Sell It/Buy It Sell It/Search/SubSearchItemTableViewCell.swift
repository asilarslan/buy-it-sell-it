//
//  SubSearchItemTableViewCell.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 28.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import UIKit

class SubSearchItemTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var numberOfItems: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
