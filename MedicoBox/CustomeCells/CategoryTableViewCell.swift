//
//  CategoryTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 05/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
