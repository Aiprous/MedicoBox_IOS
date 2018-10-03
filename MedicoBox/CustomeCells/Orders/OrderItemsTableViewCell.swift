//
//  OrderItemsTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOrderItems: UIImageView!
    @IBOutlet weak var lblTitleOrderItems: UILabel!
    @IBOutlet weak var lblSubTitleOrderItems: UILabel!
    @IBOutlet weak var lblMRPRateOrderItems: UILabel!
    @IBOutlet weak var lblPriceOrderItems: UILabel!

     @IBOutlet weak var logoOrderItems: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
