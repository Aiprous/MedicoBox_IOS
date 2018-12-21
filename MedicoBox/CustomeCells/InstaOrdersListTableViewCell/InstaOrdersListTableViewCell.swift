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
    
    @IBOutlet weak var lblOrderName: UILabel!
    @IBOutlet weak var bottomCellView: UIView!
    @IBOutlet weak var topHeaderCellView: UIView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblInstaOrderCount: UILabel!
//    var headerTitle = String()

    @IBOutlet weak var btnPtoductDetail: UIButton!
    
    @IBOutlet weak var btnAddToCart: DesignableButton!
    
    @IBOutlet weak var btnShareWishlist: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
       
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView
//        bottomCellView.clipsToBounds = true
//        bottomCellView.layer.cornerRadius = 10
//        bottomCellView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
//        topHeaderCellView.clipsToBounds = true
//        topHeaderCellView.layer.cornerRadius = 10
//        topHeaderCellView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var headerTitle: String {
        get {
            return lblInstaOrderTitle.text!
        }
        set(headerTitle) {
            lblInstaOrderTitle.text = headerTitle
        }
    }
    
//    func setHeaderTitle(_ headerTitle: String?) {
//        lblInstaOrderTitle.text = headerTitle
//    }
    
//    func headerTitle() -> String? {
//        return lblInstaOrderTitle.text!
//    }
//
  
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds: CGRect = self.bounds.insetBy(dx: 5, dy: 0)
        selectedBackgroundView?.frame = bounds
        selectedBackgroundView?.backgroundColor = UIColor.clear

    }
}

