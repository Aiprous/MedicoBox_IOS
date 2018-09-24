//
//  SubCell.swift
//  MedicoBox
//
//  Created by SBC on 20/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SubCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
