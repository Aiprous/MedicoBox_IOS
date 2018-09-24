//
//  DesignableView.swift
//  Rabbit
//
//  Created by connexis on 22/11/17.
//  Copyright © 2017 connexis. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
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
