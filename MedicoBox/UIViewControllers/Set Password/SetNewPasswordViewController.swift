//
//  SetNewPasswordViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class SetNewPasswordViewController: UIViewController {

    @IBOutlet weak var txtVerificationCode: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    var mobileNumber: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtVerificationCode.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
         txtNewPassword.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationItem.hidesBackButton = true;
//        txtVerificationCode.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
  /*  func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtVerificationCode{
            
            let maxlength = 4
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            txtNewPassword.becomeFirstResponder()
            return newString!.length <= maxlength
            
        } else if textField == self.txtNewPassword{
            
            let maxlength = 10
            let legnth = textField.text?.count
            let currentString : String = textField.text! as String
            var newString = (currentString as NSString).replacingCharacters(in: range, with: string) as? NSString
            //            let newString : String = currentString.replacingCharacters(in: range , with: string) as String
            let allowed =  CharacterSet.decimalDigits
            let characterset = CharacterSet(charactersIn: string)
            return newString!.length <= maxlength
            
        }
        return true;
    }*/
    
    
    // MARK:- Text Field Delegate methods
    
    @objc func textFieldDidChange(textField: UITextField){
        
     /*   let text = textField.text
        if text?.utf16.count == 10{
            switch textField {
                
            case txtVerificationCode:
                txtNewPassword.becomeFirstResponder()
                
            case txtNewPassword:
                txtNewPassword.resignFirstResponder()

            default:
                break;
            }
        }else{
            
        }*/
    }
 

    @IBAction func btnSetPasswordAction(_ sender: Any) {
        if ((self.txtVerificationCode.text != nil) && (self.txtVerificationCode.text?.isEmpty != true)){
            if (isValidPassword(txtPass: self.txtVerificationCode.text!)) {
                if ((self.txtNewPassword.text != nil) && (self.txtNewPassword.text?.isEmpty != true) && (self.txtVerificationCode.text == self.txtNewPassword.text)){
                    self.setNewPasswordAPI()
                }else{
                    
                    alertWithMessage(title: "Alert", message: "Password and confirm password was not matched", vc: self)
                }
            }else{
                alertWithMessage(title: "Alert", message: "Password should contains one uppercase, lowercase, special character, number & should be greater than 7 character ", vc: self)
            }
        }else{
            
            alertWithMessage(title: "Alert", message: "Please enter password", vc: self)
        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.createMenuView()
    }
    
    func setNewPasswordAPI() {
        
        let urlString =  kKeySetNewPassword;
        print(urlString)
        SVProgressHUD.show()
        /*   {
         "mobile": 7665665657,
         "password": "joykpas",
         "confirm_password": "joykpas"
         }*/
        let paraDict =  ["password": self.txtVerificationCode.text! , "mobile": self.mobileNumber, "confirm_password": self.txtVerificationCode.text! ]
        
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
                                print(responseDict)
                                let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignInVC)
                               self.navigationController?.pushViewController(Controller, animated: true)
                                
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
