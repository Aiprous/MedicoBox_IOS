//
//  InstaOrdersListTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 24/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class InstaOrdersListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInstaOrderTitle: UILabel!
    @IBOutlet weak var btnOptions: UIButton!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnAddItem: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
