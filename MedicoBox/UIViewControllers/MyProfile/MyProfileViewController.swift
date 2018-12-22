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
    
    @IBOutlet weak var deliveryViewHightContraint: NSLayoutConstraint!
    @IBOutlet weak var billingViewHightContraint: NSLayoutConstraint!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
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
    @IBOutlet weak var billingView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    var userID = String();
    var addressArray = NSArray();
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
        self.navigationController?.isNavigationBarHidden = false;
        self.btnEdit.setTitle("Add", for: .normal);
        self.billingView.isHidden = true;
        self.billingViewHightContraint.constant = 0;
        self.btnChange.setTitle("Add", for: .normal);
        self.deliveryView.isHidden = true;
        self.deliveryViewHightContraint.constant = 0;
        UIView.animate(withDuration: 0.5) {
            self.view.updateConstraints()
            self.view.layoutIfNeeded()
        }
        GetUserInfo()
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view .endEditing(true)
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSearchVC)
        self.navigationController?.pushViewController(Controller, animated: true)
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
    
    @IBAction func  btnProfileCallAction(sender: UIButton) {
        
        print(sender.currentTitle)
        //        callNumber(phoneNumber:sender.titleLabel!.text!);
    }
    
    @IBAction func  btnBillingAddressCallAction(sender: UIButton) {
        
        //        callNumber(phoneNumber:sender.titleLabel!.text!);
    }
    @IBAction func  btnDeliveryAddressCallAction(sender: UIButton) {
        
        //        callNumber(phoneNumber:sender.titleLabel!.text!);
    }
    
    
    //--------------------------------
    // MARK: - Get My Profile API Call
    //--------------------------------
    
    func GetUserInfo()  {
        
        if Connectivity.isConnectedToInternet {
            
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
                            let response = responseDict.value(forKey: "response")as? NSDictionary ?? [:];
                            if((response.value(forKey: "status")as! String) == "success"){
                                
                                let dictionary =  response.value(forKey: "data")as? NSDictionary ?? [:];
                                self.signupData = SignUpModelClass(signupModel: dictionary)
                                let signup = SignUpModelClass(signupModel: dictionary)
                                self.myProfileData.append(signup)
                                kAppDelegate.setLoginUserData(loginUserData: self.signupData!);
                                self.lblEmail.text = dictionary.value(forKey: "email")as? String;
                                self.lblUserName.text = (dictionary.value(forKey: "firstname")as? String ?? "") + " " + (dictionary.value(forKey: "lastname")as? String ?? "");
                                let custom_attributes = (dictionary.value(forKey: "custom_attributes")as? NSArray ?? [])
                                let attribute_code = custom_attributes.value(forKey: "attribute_code")as? String ?? ""
                                if(attribute_code == "mobile_number"){
                                    let value = custom_attributes.value(forKey: "value")as? String ?? ""
                                    self.btnCallUserName.setTitle(value, for: .normal);
                                }
                                self.userID = String(dictionary.value(forKey: "id")as? Int ?? 0);
                                self.GetBillingAddressAPI();
                            }else{
                                
                            }
                        }
                        else{
                            
                            //                        print(responseDict.value(forKey: "message")as! String)
                            //                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                        }
                    }
                })
            }
        }else {
            
            self.alertWithMessage(title: "Message", message: "Please check internet connection", vc: self)
            
        }
    }
    
    //--------------------------------------
    // MARK: - Get Billing Address API Call
    //--------------------------------------
    
    func GetBillingAddressAPI()  {
        
        if Connectivity.isConnectedToInternet {
            
            var paraDict = NSMutableDictionary()
            paraDict =  ["user_id": self.userID] as NSMutableDictionary
            let urlString = BASEURL + "/API/customer-addresses.php"
            print(urlString, paraDict)
            SVProgressHUD.show()
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Cache-Control": "no-cache",
                "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
            
            Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: nil).responseJSON { (resposeData) in
                
                DispatchQueue.main.async(execute: {() -> Void in
                    SVProgressHUD.dismiss()
                    if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                        
                        if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                        {
                            print(responseDict);
                            let response = responseDict.value(forKey: "response")as? NSDictionary ?? [:];
                            if((response.value(forKey: "status")as! String) == "success"){
                                
                                let dictionary =  response.value(forKey: "address")as? NSArray ?? [];
                                self.addressArray = dictionary;
                                for dictObjAddress in dictionary {
                                    
                                    if(((dictObjAddress as AnyObject).value(forKey: "default_billing")as? Int ?? 0) == 1) {
                                        
                                        self.billingViewHightContraint.constant = 185;
                                        UIView.animate(withDuration: 0.5) {
                                            self.view.updateConstraints()
                                            self.view.layoutIfNeeded()
                                        }
                                        self.billingView.isHidden = false;
                                        self.btnEdit.setTitle("Edit", for: .normal);
                                        let street = ((dictObjAddress as AnyObject).value(forKey: "street")as? NSArray ?? []);
                                        let region = ((dictObjAddress as AnyObject).value(forKey: "region")as? NSDictionary ?? [:]);
                                        var country = ((dictObjAddress as AnyObject).value(forKey: "country_id")as? String ?? "")
                                        if(country == "IN"){
                                            country = "India";
                                        }
                                        let StreetName = (street.object(at: 0)as? String ?? "");
                                        let city = ((dictObjAddress as AnyObject).value(forKey: "city")as? String ?? "");
                                        let postcode = ((dictObjAddress as AnyObject).value(forKey: "postcode")as? String ?? "");
                                        let regionName = (region.value(forKey: "region")as? String ?? "");
                                        self.lblBillingAddress.text  =  StreetName  + " , " + city + " , " + regionName + " , \n" + country  + ",\n" + postcode
                                        self.lblBillingUserName.text = ((dictObjAddress as AnyObject).value(forKey: "firstname")as? String ?? "") + " " + ((dictObjAddress as AnyObject).value(forKey: "lastname")as? String ?? "")
                                        self.btnBillingUserName.setTitle(((dictObjAddress as AnyObject).value(forKey: "telephone")as? String ?? ""), for: .normal);
                                        
                                    }else if (((dictObjAddress as AnyObject).value(forKey: "default_shipping")as? Int ?? 0) == 1){
                                        
                                        self.deliveryViewHightContraint.constant = 175;
                                        UIView.animate(withDuration: 0.5) {
                                            self.view.updateConstraints()
                                            self.view.layoutIfNeeded()
                                        }
                                        self.deliveryView.isHidden = false;
                                        self.btnChange.setTitle("Change", for: .normal);
                                        let street = ((dictObjAddress as AnyObject).value(forKey: "street")as? NSArray ?? []);
                                        let region = ((dictObjAddress as AnyObject).value(forKey: "region")as? NSDictionary ?? [:]);
                                        var country = ((dictObjAddress as AnyObject).value(forKey: "country_id")as? String ?? "")
                                        if(country == "IN"){
                                            country = "India";
                                        }
                                        let StreetName = (street.object(at: 0)as? String ?? "");
                                        let city = ((dictObjAddress as AnyObject).value(forKey: "city")as? String ?? "");
                                        let postcode = ((dictObjAddress as AnyObject).value(forKey: "postcode")as? String ?? "");
                                        let regionName = (region.value(forKey: "region")as? String ?? "");
                                        self.lblDeliveryAddress.text  =  StreetName  + " , " + city + " , " + regionName + " , \n" + country  + ",\n" + postcode
                                        self.lblDeliveryUserName.text = ((dictObjAddress as AnyObject).value(forKey: "firstname")as? String ?? "") + " " + ((dictObjAddress as AnyObject).value(forKey: "lastname")as? String ?? "")
                                        self.btnDeliveryUserName.setTitle(((dictObjAddress as AnyObject).value(forKey: "telephone")as? String ?? ""), for: .normal);
                                        
                                    }
                                }
                            }
                        }
                        else{
                            //                        print(responseDict.value(forKey: "message")as! String)
                            //                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                        }
                    }else {
                        
                        self.btnEdit.setTitle("Add", for: .normal);
                        self.billingView.isHidden = true;
                        self.billingViewHightContraint.constant = 0;
                        self.btnChange.setTitle("Add", for: .normal);
                        self.deliveryView.isHidden = true;
                        self.deliveryViewHightContraint.constant = 0;
                        UIView.animate(withDuration: 0.5) {
                            self.view.updateConstraints()
                            self.view.layoutIfNeeded()
                        }
                    }
                })
            }
        }else {
            
            self.alertWithMessage(title: "Message", message: "Please check internet connection", vc: self)
            
        }
        
    }
    /*
     //--------------------------------------
     // MARK: - Get Shipping Address API Call
     //--------------------------------------
     
     func GetShippingAddressAPI()  {
     
     if Connectivity.isConnectedToInternet {
     
     let urlString = BASEURL + "/index.php/rest/V1/customers/me/shippingAddress"
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
     
     if(responseDict == nil){
     
     self.btnChange.setTitle("Add", for: .normal);
     self.deliveryView.isHidden = true;
     
     }else {
     
     self.deliveryViewHightContraint.constant = 175;
     UIView.animate(withDuration: 0.5) {
     self.view.updateConstraints()
     self.view.layoutIfNeeded()
     }
     self.deliveryView.isHidden = false;
     var street = (responseDict.value(forKey: "street")as? NSArray ?? []);
     let region = (responseDict.value(forKey: "region")as? NSDictionary ?? [:]);
     var country = (responseDict.value(forKey: "country_id")as? String ?? "")
     if(country == "IN"){
     country = "India";
     }
     let StreetName = (street.object(at: 0)as? String ?? "");
     let city = (responseDict.value(forKey: "city")as? String ?? "");
     let postcode = (responseDict.value(forKey: "postcode")as? String ?? "");
     let regionName = (region.value(forKey: "region")as? String ?? "");
     self.lblDeliveryAddress.text  = StreetName  + " , " + city + " , " + regionName + " , \n" + country  + ",\n " + postcode
     self.btnChange.setTitle("Change", for: .normal);
     self.lblDeliveryUserName.text = (responseDict.value(forKey: "firstname")as? String ?? "") + " " + (responseDict.value(forKey: "lastname")as? String ?? "")
     self.btnDeliveryUserName.setTitle((responseDict.value(forKey: "telephone")as? String ?? ""), for: .normal);
     }
     }
     else{
     
     print(responseDict.value(forKey: "message")as! String)
     self.showToast(message : responseDict.value(forKey: "message")as! String)
     }
     }else {
     
     self.btnChange.setTitle("Add", for: .normal);
     self.deliveryView.isHidden = true;
     self.deliveryViewHightContraint.constant = 0;
     UIView.animate(withDuration: 0.5) {
     self.view.updateConstraints()
     self.view.layoutIfNeeded()
     }
     }
     })
     }
     }else {
     
     self.alertWithMessage(title: "Message", message: "Please check internet connection", vc: self)
     
     }
     
     }*/
    
}
