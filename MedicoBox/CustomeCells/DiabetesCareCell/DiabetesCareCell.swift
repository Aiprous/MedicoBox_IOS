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
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnLike: UIButton!
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
