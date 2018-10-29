//
//  CartItemTableCell.swift
//  MedicoBox
//
//  Created by SBC on 29/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class CartItemTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTabletName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imageViewTablet: UIImageView!
    @IBOutlet weak var lblMRP: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
