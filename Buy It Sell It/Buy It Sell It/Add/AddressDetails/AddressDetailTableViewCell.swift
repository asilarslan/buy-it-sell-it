//
//  AddressDetailTableViewCell.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 15.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import UIKit

class AddressDetailTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
