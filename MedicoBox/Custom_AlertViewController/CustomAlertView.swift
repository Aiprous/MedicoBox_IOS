//
//  CustomAlertView.swift
//  CustomAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CustomAlertView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertTextField: UITextField!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var wishListArray: NSArray?
    var selectedwishListArray: NSMutableArray?
    @IBOutlet weak var tblWishList: UITableView!
    var delegate: CustomAlertViewDelegate?
    var selectedOption = "First"
    var productId: String?
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        alertTextField.becomeFirstResponder()
        self.tblWishList.register(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertTableViewCell")
        tblWishList.delegate = self
        tblWishList.dataSource = self
        tblWishList.estimatedRowHeight = 44
         self.getInstaOrderListAPI();
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
     //Save button action
    @IBAction func onTapCancelButton(_ sender: Any) {
        //Save button action
        alertTextField.resignFirstResponder()
        self.saveProductToWishListAPI()
        delegate?.saveButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        alertTextField.resignFirstResponder()
        
//        delegate?.okButtonTapped(selectedOption: selectedOption, textFieldValue: alertTextField.text!)
        if self.alertTextField.text != "" {
            createWishListAPI()
        }
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("First option")
            selectedOption = "First"
            break
        case 1:
            print("Second option")
            selectedOption = "Second"
            break
        default:
            break
        }
    }
    //MARK:- Table View Delegate And DataSource
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.selectedwishListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell") as! AlertTableViewCell
         let dict = self.selectedwishListArray![indexPath.row] as! NSMutableDictionary
        cellObj.lblWishlistName.text = (dict.value(forKey: "wishlist_name") as! String)
        cellObj.btnSelectWishlist.tag = indexPath.row;
        cellObj.btnSelectWishlist.addTarget(self, action: #selector(btnSelectWishlistAction(button:)), for: UIControlEvents.touchUpInside);
        if (dict.value(forKey: "selectedFlag") != nil && (dict.value(forKey: "selectedFlag") as! Bool)) {
            cellObj.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-selected"), for: .normal)
        }else{
            cellObj.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-empty"), for: .normal)
        }
        
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @objc func btnSelectWishlistAction(button: UIButton) {
        let position: CGPoint = button.convert(.zero, to: self.tblWishList)
        let indexPath = self.tblWishList.indexPathForRow(at: position)
        let cell:AlertTableViewCell = tblWishList.cellForRow(at: indexPath!) as! AlertTableViewCell
        
         var dict = self.selectedwishListArray![button.tag] as! NSMutableDictionary
        
        if !(dict.value(forKey: "selectedFlag") as! Bool) {
            cell.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-selected"), for: .normal)
//            button.isSelected = true;
            dict.setValue(true, forKey: "selectedFlag")

        }else {
            cell.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-empty"), for: .normal)
//            button.isSelected = false;
             dict.setValue(false, forKey: "selectedFlag")
        }
    }
    
    //--------------------------------
    // MARK: - InstOrder List API Call
    //--------------------------------
    
    func getInstaOrderListAPI() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["user_id": "226"] as NSMutableDictionary
        //        https://user8.itsindev.com/medibox/API/get_user_wishlist_products.php
        
        let urlString = BASEURL + "/API/get_user_wishlist_products.php"
        
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                
                        if responseDict.value(forKey: "response") != nil {
                            
                            if let val = responseDict.value(forKey: "response") as? NSArray {
                               self.wishListArray = val;
                                self.selectedwishListArray = [];
                                for dict in self.wishListArray! {
                                    var dict1:NSMutableDictionary = (dict as! NSDictionary).mutableCopy() as! NSMutableDictionary
                                    dict1.setObject(false, forKey: "selectedFlag" as NSCopying)
                                    self.selectedwishListArray?.add(dict1)
                                }
                            }else{
                                self.showToast(message : responseDict.value(forKey: "response")as! String)
                            }
                            
                            
                        }
                       self.tblWishList.reloadData();
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    //--------------------------------
    // MARK: - Add Wishlist API Call
    //--------------------------------
    
    func createWishListAPI() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["user_id": "226", "wishlist_name": self.alertTextField.text ?? ""] as NSMutableDictionary
        //        https://user8.itsindev.com/medibox/API/create_wishlist.php
        
        let urlString = BASEURL + "/API/create_wishlist.php"
        
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        if responseDict.value(forKey: "response") != nil {
                            self.getInstaOrderListAPI();
                            self.alertTextField.text = ""
                        }
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    //--------------------------------
    // MARK: - InstOrder List API Call
    //--------------------------------
    
    func saveProductToWishListAPI() {
        
        var paraDict = NSMutableDictionary()
//        {
//            "user_id": 184,
//            "wishlist_name_id":65,
//            "item_id": 66
//        }
        
       
        for dict in selectedwishListArray ?? []{
            if ((dict as AnyObject).value(forKey: "selectedFlag") as! Bool) {
             paraDict =  ["user_id": "226", "wishlist_name_id" : (dict as AnyObject).value(forKey: "wishlist_name_id") as! String, "item_id": productId ?? ""] as NSMutableDictionary
            }
        }
       
        //        https://user8.itsindev.com/medibox/API/add_item_wishlist.php
        
        let urlString = BASEURL + "/API/add_item_wishlist.php"
        
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        if responseDict.value(forKey: "response") != nil {
                            
//                            self.wishListArray = responseDict.value(forKey: "response") as? NSDictionary
//                            self.selectedwishListArray = [];
//                            for dict in self.wishListArray! {
//                                var dict1:NSMutableDictionary = (dict as! NSDictionary).mutableCopy() as! NSMutableDictionary
//                                dict1.setObject(false, forKey: "selectedFlag" as NSCopying)
//                                self.selectedwishListArray?.add(dict1)
                                self.showToast(message : responseDict.value(forKeyPath: "response.msg") as! String)
                            print(responseDict.value(forKeyPath: "response.msg") as! String)
//                            }
                        }
                        self.tblWishList.reloadData();
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
}
