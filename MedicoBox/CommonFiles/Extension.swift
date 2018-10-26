//
//  Extension.swift
//  Cab Booking
//
//  Created by Solutionner Software on 12/07/17.
//  Copyright © 2017 Solutionner Software. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    func changeFontName()
    {
        self.font = UIFont(name: "OpenSans-Regular", size: 17)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10);
        
    }
    
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        
        // print(textRect)
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        
    }
    
    public func isEmpty() -> Bool {
    
    return ((self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! > 0)
       
    }
    public func isValidPhoneNumberCount() -> Bool {
        
        return (self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! >= 10
    }
    public func isValidOTP() -> Bool {
        
        return (self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! >= 1
    }
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)

    }
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension String{
    
    func removeNil() -> String {
        
        if self != "nil" {
            return self
        }
        
        return ""
    }
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        
        self.layer.cornerRadius = self.layer.cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowOpacity = 18
        self.layer.shadowOffset = CGSize(width: -1, height: 0.5)
        self.layer.shadowRadius = 0.5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.masksToBounds = false
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = self.layer.cornerRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.masksToBounds = false
      
    }
    // OUTPUT 3
        func ViewdropShadow() {
            
            self.layer.masksToBounds = false
            self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
            self.layer.shadowRadius = 0.5
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 8.0
            
        }
    
}
extension UIButton {
    
    /// Makes the ``imageView`` appear just to the right of the ``titleLabel``.
    func alignImageRight() {
        if let titleLabel = self.titleLabel, let imageView = self.imageView {
            // Force the label and image to resize.
            titleLabel.sizeToFit()
            imageView.sizeToFit()
            imageView.contentMode = .scaleAspectFit
            
            // Set the insets so that the title appears to the left and the image appears to the right.
            // Make the image appear slightly off the top/bottom edges of the button.
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -1 * imageView.frame.size.width,
                                                bottom: 0, right: imageView.frame.size.width)
            self.imageEdgeInsets = UIEdgeInsets(top: 4, left: titleLabel.frame.size.width,
                                                bottom: 4, right: -1 * titleLabel.frame.size.width)
        }
    }
}

extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+hh:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-80, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.85)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.numberOfLines = 5
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    public func alertWithMessage(title : String , message : String ,  vc : Any)  {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        (vc as? UIViewController)?.present(alert, animated: true, completion: nil)
        
    }

   public func isValidEmailID(txtEmail : String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: txtEmail) {
            return true
        }
        else{
            return false
        }
    }
    
   public func isValidName(txtName: String) -> Bool {
        
        let firstNameRegex = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
        let firstNameTest = NSPredicate(format: "SELF MATCHES %@", firstNameRegex)
        
        let result = firstNameTest.evaluate(with: txtName)
        if result == false {
            return false
        }
        
        return result
        
    }
    
   public func isValidMobileNo(mobileNo : String) -> Bool {
        
        let noRegex = "[0-9]{6,14}$"
        let noTest = NSPredicate(format: "SELF MATCHES %@", noRegex)
        
        let result = noTest.evaluate(with: mobileNo)
    
        if result == false {
            
            return false
        }
        return result
        
    }

}
extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: text.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
