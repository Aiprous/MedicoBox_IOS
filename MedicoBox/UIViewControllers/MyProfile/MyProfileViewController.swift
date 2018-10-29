//
//  MyProfileViewController.swift
//  MedicoBox
//
//  Created by SBC on 01/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class MyProfileViewController: UIViewController {
    
    
    var signupData : SignUpModelClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setNavigationBarItem()
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetUserInfo()
        
    }
    
    //    func getCustomerInfo() {
    //        SVProgressHUD.show()
    //          signupData = customerInfo.callLoginWithTokenAPI()
    //    }
    
    @IBAction func editProfileAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kEditProfileVC) as! EditProfileViewController
        if signupData != nil {
            Controller.userProfileData = signupData;
        }
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    //MARK: - API Call
    
    func GetUserInfo()  {
        
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/customers/me"
        
        print(urlString)
        
        SVProgressHUD.show()
        
        let param = [String: Any] ()
        
        CustomerInfo .dataTask_GET(Foundation.URL(string: urlString)!, method: .get, param: param) { (response) in
            
            SVProgressHUD.dismiss()
            switch response{
                
            case .success(let dictionary as [String: Any]):
                
                print(dictionary)
                
                if (dictionary["id"] != nil) {
                    self.signupData = SignUpModelClass(signupModel: dictionary)
                }else{
                    print(dictionary["message"] ?? "")
                    self.showToast(message : dictionary["message"] as! String)
                }
                break
            case .failure( _):
                break
            default:
                break
            }
        }
    }
    
}
