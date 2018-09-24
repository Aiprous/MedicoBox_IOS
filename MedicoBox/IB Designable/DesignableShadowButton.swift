//
//  DesignableShadowButton.swift
//  Rabbit
//
//  Created by Mac on 30/01/18.
//  Copyright © 2018 connexis. All rights reserved.
//

import UIKit

@IBDesignable class DesignableShadowButton: UIButton {
    
    @IBInspectable var cornerradius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    @IBInspectable var shadowOffsetHight: CGFloat = 5
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpicity: CGFloat = 0.5
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerradius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = Float(shadowOpicity)
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHight)
        let shadowpath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowpath.cgPath
    }
    
    

}

