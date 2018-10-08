//
//  OrderItemsTableViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgOrderItems: UIImageView!
    @IBOutlet weak var lblTitleOrderItems: UILabel!
    @IBOutlet weak var lblSubTitleOrderItems: UILabel!
    @IBOutlet weak var lblMRPRateOrderItems: UILabel!
    @IBOutlet weak var lblMRP: UILabel!
    @IBOutlet weak var lblTrasOrderItems: UILabel!
    @IBOutlet weak var lblPriceOrderItems: UILabel!

     @IBOutlet weak var logoOrderItems: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        strikeOnLabel()
    }
    
    func strikeOnLabel(){
        
        let price = 299.0
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "INR"
        let priceInINR = currencyFormatter.string(from: price as NSNumber)
        
        let attributedString = NSMutableAttributedString(string: priceInINR!)
        
        // Swift 4.2 and above
        //        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        // Swift 4.1 and below
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        self.lblMRPRateOrderItems.attributedText = attributedString
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
