//
//  TransactionListTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class TransactionListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTransactionID: UILabel!
    @IBOutlet weak var lblTransactionDate: UILabel!
    
    @IBOutlet weak var lblTransactionCommentMsg: UILabel!
    
    @IBOutlet weak var lblTransactionAmount: UILabel!
    
    @IBOutlet weak var btnTransViewDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
