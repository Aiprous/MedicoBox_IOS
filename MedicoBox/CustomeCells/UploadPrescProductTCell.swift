//
//  UploadPrescProductTCell.swift
//  MedicoBox
//
//  Created by SBC on 20/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class UploadPrescProductTCell: UITableViewCell {

    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblInstaOrderCount: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblMRP: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
