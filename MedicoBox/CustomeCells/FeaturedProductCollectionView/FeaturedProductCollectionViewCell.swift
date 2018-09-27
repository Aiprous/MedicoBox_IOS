//
//  FeaturedProductCollectionViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Foundation
class FeaturedProductCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var containerFeaturedProducts: UIView!
    @IBOutlet weak var lblTitleFeaturedProducts: UILabel!
    @IBOutlet weak var imgFeaturedProducts: UIImageView!
    
    @IBOutlet weak var lblOfferFeaturedProducts: UILabel!
    @IBOutlet weak var lblOfferPriceFeaturedProducts: UILabel!
    @IBOutlet weak var lblPriceFeaturedProducts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//         self.lblOfferFeaturedProducts.text = "\u{20B9}" + " 299.0 "
        self.lblPriceFeaturedProducts.text = "\u{20B9}" + " 199.0 "

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
        self.lblOfferFeaturedProducts.attributedText = attributedString
      
    }
}
