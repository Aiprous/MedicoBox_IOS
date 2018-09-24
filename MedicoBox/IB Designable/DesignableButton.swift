//
//  DesignableButton.swift
//  Rabbit
//
//  Created by connexis on 22/11/17.
//  Copyright © 2017 connexis. All rights reserved.
//

import UIKit

 @IBDesignable class DesignableButton: UIButton {
    
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
   /*
        @IBInspectable var leftImg: UIImage? = nil {
            didSet {
                /* reset title */
                setAttributedTitle()
            }
        }
        
        @IBInspectable var rightImg: UIImage? = nil {
            didSet {
                /* reset title */
                setAttributedTitle()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setAttributedTitle()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setAttributedTitle()
        }
     
        private func setAttributedTitle() {
            var attributedTitle = NSMutableAttributedString()
            
            /* Attaching first image */
            if let leftImg = leftImg {
                let leftAttachment = NSTextAttachment(data: nil, ofType: nil)
                leftAttachment.image = leftImg
                let attributedString = NSAttributedString(attachment: leftAttachment)
                let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
                
                if let title = self.currentTitle {
                    mutableAttributedString.append(NSAttributedString(string: title))
                }
                attributedTitle = mutableAttributedString
            }
            
            /* Attaching second image */
            if let rightImg = rightImg {
                let leftAttachment = NSTextAttachment(data: nil, ofType: nil)
                leftAttachment.image = rightImg
                let attributedString = NSAttributedString(attachment: leftAttachment)
                let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
                attributedTitle.append(mutableAttributedString)
            }
            
            /* Finally, lets have that two-imaged button! */
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        let availableSpace = UIEdgeInsetsInsetRect(bounds, contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }*/
    }


