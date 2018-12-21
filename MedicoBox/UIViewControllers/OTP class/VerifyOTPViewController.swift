//
//  VerifyOTPViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class VerifyOTPViewController: UIViewController{//,UITextFieldDelegate {
    
    @IBOutlet weak var txtOne: UITextField!
    @IBOutlet weak var txtTwo: UITextField!
    @IBOutlet weak var txtThree: UITextField!
    @IBOutlet weak var txtFour: UITextField!
    var isComeforVerifyOTP: Bool?
    var mobileNumber: String?
    
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
//        txtOne.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtOne{
            
            let maxlength = 1
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
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
        
        if (!(self.txtOne.text?.isEmpty)! && !(self.txtTwo.text?.isEmpty)! && !(self.txtThree.text?.isEmpty)! && !(self.txtFour.text?.isEmpty)!){
        self.callLoginWithTokenAPI()
        }else{
             alertWithMessage(title: "Alert", message: "Please enter four digit verification code", vc: self)
        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.createMenuView()
    }

    
    func callLoginWithTokenAPI() {
        
        let urlString =  kKeyVerifyOTP;
        print(urlString)
        SVProgressHUD.show()
        /*    {
                "mobile": 7665665657,
                "otp" : 643801
        }*/
        let paraDict =  ["otp": self.txtOne.text! + self.txtTwo.text! + self.txtThree.text! + self.txtFour.text!, "mobile": self.mobileNumber]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .post, parameters: paraDict as Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict = resposeData.result.value  as? NSDictionary  {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        if let jsonDict = responseDict.value(forKey: "response") as? NSDictionary {
                            
                            if  jsonDict.value(forKey: "status") as? String == "success" {
                                self.showToast(message : jsonDict.value(forKey:"message") as? String ?? "" )
                                if self.isComeforVerifyOTP ?? false {
                                    kAppDelegate.createMenuView()

                                }else{
                                    let Controller = self.storyboard?.instantiateViewController(withIdentifier: kSetNewPasswordVC) as! SetNewPasswordViewController
                                   Controller.mobileNumber = self.mobileNumber
                                    self.navigationController?.pushViewController(Controller, animated: true)
                                }
                                
                                //                        kAppDelegate.createMenuView()
                                print(responseDict)
                                
                            }else{
                                
                                print(jsonDict.value(forKey: "message") as? String ?? "" )
                                self.showToast(message : jsonDict.value(forKey:"message") as? String ?? "" )
                            }
                        }
                    }
                    
                }
            })
        }
    }
}
