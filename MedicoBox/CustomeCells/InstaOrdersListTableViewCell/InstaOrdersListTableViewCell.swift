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
    @IBOutlet weak var bottomCellView: UIView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnCheckboxCell: UIButton!
    @IBOutlet weak var btnSelectAll: UIButton!
    
    @IBOutlet weak var lblInstaOrderCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds: CGRect = self.bounds.insetBy(dx: 5, dy: 0)
        selectedBackgroundView?.frame = bounds
    }
}
