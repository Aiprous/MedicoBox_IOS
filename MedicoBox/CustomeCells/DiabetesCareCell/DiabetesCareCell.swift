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
        strikeOnLabel()
    }
    
    func strikeOnLabel(){
        
        let price = 150.0
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "INR"
        let priceInINR = currencyFormatter.string(from: price as NSNumber)
        
        let attributedString = NSMutableAttributedString(string: priceInINR!)
        
        // Swift 4.2 and above
        //        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        // Swift 4.1 and below
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        self.lblDiscount.attributedText = attributedString
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
