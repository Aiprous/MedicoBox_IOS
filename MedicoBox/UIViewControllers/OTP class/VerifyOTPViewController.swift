//
//  VerifyOTPViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class VerifyOTPViewController: UIViewController{//,UITextFieldDelegate {
    
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        txtTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        txtThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        txtFour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationItem.hidesBackButton = true;
        txtOne.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtOne{
            
            let maxlength = 1
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            txtTwo.becomeFirstResponder()
            return newString!.length <= maxlength
            
        }
        else if textField == self.txtTwo{
            
            let maxlength = 1
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            txtThree.becomeFirstResponder()
            return newString!.length <= maxlength
            
        }
        else if textField == self.txtThree{
            
            let maxlength = 1
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            txtFour.becomeFirstResponder()
            return newString!.length <= maxlength
            
        }
        else if textField == self.txtFour{
            
            let maxlength = 1
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            txtFour.resignFirstResponder()
            return newString!.length <= maxlength
            
        }
        return true;
        
    }
    
    // MARK:- Text Field Delegate methods
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        if text?.utf16.count == 1{
            switch textField {
                
            case txtOne:
                txtTwo.becomeFirstResponder()
                
            case txtTwo:
                txtThree.becomeFirstResponder()
                
            case txtThree:
                txtFour.becomeFirstResponder()
                
            case txtFour:
                txtFour.resignFirstResponder()
                
            default:
                break
            }
            
        }else{
            
        }
    }
    
    
    @IBAction func proceedBtnAction(_ sender: Any) {
        self.createMenuView()
    }
    
    //    Pragma Mark: create menu
    fileprivate func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        
        let nvc: UINavigationController = UINavigationController(rootViewController: homeViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.homeViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = homeViewController as? SlideMenuControllerDelegate
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }

    
}
