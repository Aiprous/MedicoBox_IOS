//
//  SignUpViewController.swift
//  MedicoBox
//
//  Created by SBC on 14/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import SVProgressHUD
import SDWebImage

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: DesignableUITextField!
    @IBOutlet weak var txtEmail: DesignableUITextField!
    @IBOutlet weak var txtMobile: DesignableUITextField!
    @IBOutlet weak var txtPassword: DesignableUITextField!
    @IBOutlet weak var txtConfirmPassword: DesignableUITextField!
    var signupData = [SignUpModelClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
       
        if ((self.txtName.text != nil) && (self.txtName.text?.isEmpty != true)) {
            
            if ((self.txtMobile.text != nil) && (self.txtMobile.text?.isEmpty != true)){
                
                if (self.txtMobile.text?.characters.count == 10)  {
                
                if ((self.txtEmail.text != nil) && (self.txtEmail.text?.isEmpty != true)) {
                    
                    if isValidEmailID(txtEmail: self.txtEmail.text!)   {
                    
                    if ((self.txtPassword.text != nil) && (self.txtPassword.text?.isEmpty != true)){
                        
                         if ((self.txtConfirmPassword.text != nil) && (self.txtConfirmPassword.text?.isEmpty != true)){
                        
                                self.callSignUpAPI();

                         }else{
                            
                            alertWithMessage(title: "Alert", message: "Enter Confirm Password", vc: self)
                        }
                     }else{
                        
                        alertWithMessage(title: "Alert", message: "Enter Password", vc: self)
                    }
                }else{
                    
                    alertWithMessage(title: "Alert", message: "Enter Valid Email Address", vc: self)
                    }
                }else{
                    
                    alertWithMessage(title: "Alert", message: "Enter Email Address", vc: self)
                    }
                
            }else{
                
                alertWithMessage(title: "Alert", message: "Enter Mobile number 10 digits", vc: self)
            }
                    
            }else{
                
                alertWithMessage(title: "Alert", message: "Enter Mobile Number", vc: self)
            }
        }
        else{
            
            alertWithMessage(title: "Alert", message: "Enter Name", vc: self)
        }
    
    }
    @IBAction func btnSignInAction(_ sender: Any) {
        

        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignInVC)

        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    
    //----------------------------------------------------
    // MARK: - UITextField Delegates All Other Methods Call
    //----------------------------------------------------

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtMobile{
            
            let maxlength = 10
            let currentString : String = textField.text! as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            let newString = (currentString as NSString).replacingCharacters(in: range, with: string) as NSString
            return allowed.isSuperset(of: characterset) && newString.length <= maxlength
            
        }
        return true;
        
    }
    
    
    
    //--------------------------
    // MARK: - Sign Up API Call
    //--------------------------
    
    func callSignUpAPI() {
        
        var paraDict = NSMutableDictionary()
        var customerArr = NSDictionary()
        
        customerArr = ["email":self.txtEmail.text!,"firstname":self.txtName.text!,"lastname":"Geet","store_id":"0"]
        paraDict =  ["customer": customerArr, "password": self.txtPassword.text!, "mobile": self.txtMobile.text!] as NSMutableDictionary
    
        let urlString =  kKeyRegisterAPI;
      
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Info XXX",
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {

                        self.navigationController?.popViewController(animated: true)
                        print(responseDict);
                        let logindata =  responseDict.value(forKey: "response")as? NSDictionary ?? [:]
                        let signup = SignUpModelClass(signupModel: logindata)
                        self.signupData.append(signup)
                        
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
}

