//
//  ProductDescriptionTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductionTitle: UILabel!
    @IBOutlet weak var lblProductionSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
