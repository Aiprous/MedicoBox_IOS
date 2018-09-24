//
//  FeaturedProductCollectionViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class FeaturedProductCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var containerFeaturedProducts: UIView!
    @IBOutlet weak var lblTitleFeaturedProducts: UILabel!
    @IBOutlet weak var imgFeaturedProducts: UIImageView!
    
    @IBOutlet weak var lblOfferFeaturedProducts: UILabel!
    
    @IBOutlet weak var lblPriceFeaturedProducts: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
