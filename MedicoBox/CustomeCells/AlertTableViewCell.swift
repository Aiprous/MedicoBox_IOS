//
//  AlertTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 17/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

    @IBOutlet weak var lblWishlistName: UILabel!
    @IBOutlet weak var btnSelectWishlist: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
