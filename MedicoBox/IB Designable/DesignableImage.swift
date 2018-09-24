//
//  DesignableImage.swift
//  TranspooDriver
//
//  Created by Mac on 23/03/18.
//  Copyright © 2018 Geetanjali Basakare. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImage: UIImageView {
        
        @IBInspectable var borderWidth: CGFloat = 0.0{
            didSet{
                self.layer.borderWidth = self.borderWidth
            }
            
        }
        @IBInspectable var borderColor: UIColor = UIColor.clear{
            didSet{
                self.layer.borderColor = self.borderColor.cgColor
            }
            
        }
        @IBInspectable var cornerRadius: CGFloat = 0{
            didSet{
                self.layer.cornerRadius = self.cornerRadius
            }
        }
}
    

