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
    
    @IBOutlet weak var txtLastName: UITextField!
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
             if ((self.txtLastName.text != nil) && (self.txtLastName.text?.isEmpty != true)) {
            if ((self.txtMobile.text != nil) && (self.txtMobile.text?.isEmpty != true)){
                
                if (self.txtMobile.text?.count == 10)  {
                    
                  if (isValidMobileNo(mobileNo: self.txtMobile.text!))  {
                    
                if ((self.txtEmail.text != nil) && (self.txtEmail.text?.isEmpty != true)) {
                    
                    if isValidEmailID(txtEmail: self.txtEmail.text!)   {
                    
                    if ((self.txtPassword.text != nil) && (self.txtPassword.text?.isEmpty != true)){
                        if (isValidPassword(txtPass: self.txtPassword.text!)) {
                         if ((self.txtConfirmPassword.text != nil) && (self.txtConfirmPassword.text?.isEmpty != true) && (self.txtPassword.text == self.txtConfirmPassword.text)){
                        
                                self.callSignUpAPI();

                         }else{
                            
                            alertWithMessage(title: "Alert", message: "Password and confirm password was not matched", vc: self)
                        }
                        }else{
                            alertWithMessage(title: "Alert", message: "Password should contains one uppercase, lowercase, special character, number & should be greater than 7 character ", vc: self)
                        }
                     }else{
                        
                        alertWithMessage(title: "Alert", message: "Please enter password", vc: self)
                    }
                }
                }else{
                    
                    alertWithMessage(title: "Alert", message: "Please enter email address", vc: self)
                    }
                  }else{
                    alertWithMessage(title: "Alert", message: "Please enter valid 10 digits mobile number", vc: self)
                    }
            }else{
                
                alertWithMessage(title: "Alert", message: "Please enter 10 digit mobile number", vc: self)
            }
                    
            }else{
                
                alertWithMessage(title: "Alert", message: "Please enter mobile number", vc: self)
            }
    
        }else{
             alertWithMessage(title: "Alert", message: "Please enter last name", vc: self)
        }
        }else{
            
            alertWithMessage(title: "Alert", message: "Please enter name", vc: self)
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
        var customAttributes = Dictionary<String, String>()
        
      
        
//        customAttributes.setValue(self.txtMobile.text!, forKey: "mobile_number")
       
      /*  Requried prameters
            {
                "customer": {
                    "email": "peters3@mitash.com",
                    "firstname": "Peter",
                    "lastname": "S",
                    "store_id": 1,
                    "customAttributes": [
                    {
                    "attributeCode": "mobile_number",
                    "value": "7665665657"
                    }
                    ]
                },
                "password": "Peter.s@888"
        }*/
        customAttributes["attributeCode"] = "mobile_number"
        customAttributes["value"] = self.txtMobile.text!
        var arrayCustom = Array<Any>()
        arrayCustom.append(customAttributes)
        
        customerArr = ["email":self.txtEmail.text!, "firstname":self.txtName.text!, "lastname":self.txtLastName.text!, "store_id":"1", "customAttributes": arrayCustom]
        paraDict =  ["customer": customerArr, "password": self.txtPassword.text!] as NSMutableDictionary
    
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
                        if let jsonString = responseDict.value(forKey: "response")as? String {
                            
                            let jsonData = jsonString.data(using: .utf8)!
                            let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as! Dictionary<String, Any>
                            
                            if  let _ = jsonDict! ["firstname"] as? String {
                     self.navigationController?.popViewController(animated: true)
//                        print(responseDict);
//                        let logindata =  responseDict.value(forKey: "response")as? NSDictionary ?? [:]
//                        let signup = SignUpModelClass(signupModel: logindata)
//                        self.signupData.append(signup)
                            }else{
                                
                                print(jsonDict!["message"] as? String ?? "" )
                                self.showToast(message : jsonDict!["message"] as? String ?? "" )
                            }
                      }
                  }
                }
            })
        }
    }
}

