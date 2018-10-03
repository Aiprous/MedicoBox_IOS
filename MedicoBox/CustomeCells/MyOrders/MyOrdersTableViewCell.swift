//
//  MyOrdersTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 01/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrderID: UILabel!
      @IBOutlet weak var lblOrderDate: UILabel!
      @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
