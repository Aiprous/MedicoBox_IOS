//
//  DeliveryAddressTableCell.swift
//  MedicoBox
//
//  Created by SBC on 27/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class DeliveryAddressTableCell: UITableViewCell {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var menuOptionView: DesignableShadowView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnMenuOption: UIButton!
    @IBOutlet weak var btnAddressSelect: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
