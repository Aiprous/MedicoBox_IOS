//
//  ProductsPharmacistTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class ProductsPharmacistTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var lblProductStatus: UILabel!
    @IBOutlet weak var lblProductQtyConfirmed: UILabel!
    @IBOutlet weak var lblProductQtyPending: UILabel!
    @IBOutlet weak var lblProductQtySold: UILabel!
    @IBOutlet weak var lblProductEarnedAmount: UILabel!
    @IBOutlet weak var btnProductDelete: UIButton!
    @IBOutlet weak var btnProductEdit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
