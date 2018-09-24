//
//  MedicoCollectionViewCell.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class MedicoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerMedico: DesignableShadowView!
    
    @IBOutlet weak var lblTitleMedico: UILabel!
    
    @IBOutlet weak var lblSubTitleMedico: UILabel!
    @IBOutlet weak var imgMedico: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
