//
//  DesignableShadowView.swift
//  Rabbit
//
//  Created by Mac on 29/01/18.
//  Copyright © 2018 connexis. All rights reserved.
//

import UIKit

@IBDesignable class DesignableShadowView: UIView {
    
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
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
