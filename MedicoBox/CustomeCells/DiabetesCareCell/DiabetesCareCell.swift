//
//  DiabetesCareCell.swift
//  MedicoBox
//
//  Created by SBC on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class DiabetesCareCell: UITableViewCell {

    @IBOutlet weak var lblTabletName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
     @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imageViewTablet: UIImageView!
    @IBOutlet weak var lblMRP: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblPrescriptionRequired: UILabel!
    
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
