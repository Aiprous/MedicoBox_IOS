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

class MyProfileViewController: UIViewController, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblBillingUserName: UILabel!
    @IBOutlet weak var lblDeliveryUserName: UILabel!
    @IBOutlet weak var btnCallUserName: UIButton!
    @IBOutlet weak var btnBillingUserName: UIButton!
    @IBOutlet weak var btnDeliveryUserName: UIButton!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var signupData : SignUpModelClass?
    var myProfileData = [SignUpModelClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItem(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetUserInfo()
        self.navigationController?.isNavigationBarHidden = false;

    }
    
   
    @IBAction func editProfileAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kEditProfileVC) as! EditProfileViewController
        if signupData != nil {
            Controller.userProfileData = signupData;
        }
        self.navigationController?.pushViewController(Controller, animated: true)
    }
   
    
    @IBAction func btnChangeAction(_ sender: Any) {

        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kSelectAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
        
    }
    
    @IBAction func editBillingAddressAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kEditBillingAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    //--------------------------------
    // MARK: - Get My Profile API Call
    //--------------------------------

    func GetUserInfo()  {

        let urlString = kKeyGetUserProfileData
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        print(responseDict);
                        let jsonString = responseDict.value(forKey: "response")as? String
                        
                        let jsonData = jsonString?.data(using: .utf8)!
                        let dictionary: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves)as! NSDictionary
                        print(dictionary as Any)
                        self.signupData = SignUpModelClass(signupModel: dictionary)
                        
                        let signup = SignUpModelClass(signupModel: dictionary )
                        self.myProfileData.append(signup)
                        
                        self.lblEmail.text = dictionary.value(forKey: "email")as? String;
                            self.lblUserName.text = dictionary.value(forKey: "firstname")as? String;
                        self.lblBillingUserName.text = dictionary.value(forKey: "firstname")as? String;
                        self.lblDeliveryUserName.text = dictionary.value(forKey: "firstname")as? String;
                        
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
