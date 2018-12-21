//
//  ForgotPasswordFromMobileNoViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class ForgotPasswordFromMobileNoViewController: UIViewController {
    
@IBOutlet weak var txtMobileNumber: UITextField!
    var isComeforVerifyOTP: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtMobileNumber.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
        self.navigationItem.hidesBackButton = true;
//        txtMobileNumber.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func  textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtMobileNumber{
            
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
    }
    
    // MARK:- Text Field Delegate methods
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        if text?.utf16.count == 10{
            switch textField {
                
            case txtMobileNumber:
                txtMobileNumber.resignFirstResponder()

            default:
                break;
            }
        }else{
            
        }
    }

    @IBAction func btnProceedAction(_ sender: Any) {
        if ((self.txtMobileNumber.text != nil) && (self.txtMobileNumber.text?.isEmpty != true)){
            
            if (self.txtMobileNumber.text?.count == 10)  {
                
                if (isValidMobileNo(mobileNo: self.txtMobileNumber.text!))  {
                         callLoginWithTokenAPI()
                }else{
                    alertWithMessage(title: "Alert", message: "Please enter valid 10 digits mobile number", vc: self)
                }
            }else{
                
                alertWithMessage(title: "Alert", message: "Please enter 10 digit mobile number", vc: self)
            }
            
        }else{
            
            alertWithMessage(title: "Alert", message: "Please enter mobile number", vc: self)
        }
    }
    
    func callLoginWithTokenAPI() {
        
        let urlString =  kKeyLoginOTP;
        print(urlString)
        SVProgressHUD.show()
         let paraDict =  ["mobile": self.txtMobileNumber.text]
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
                      
                            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kVerifyOTPVC) as! VerifyOTPViewController
                            Controller.isComeforVerifyOTP = self.isComeforVerifyOTP
                            Controller.mobileNumber = self.txtMobileNumber.text
                      self.navigationController?.pushViewController(Controller, animated: true)
                    
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
