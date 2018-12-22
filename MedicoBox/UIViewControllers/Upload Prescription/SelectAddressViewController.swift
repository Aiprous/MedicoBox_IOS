//
//  SelectAddressViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class SelectAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var tblAddress: UITableView!
    var addressArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register cell for tableview
        tblAddress.register(UINib(nibName: "DeliveryAddressTableCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressTableCell")
        tblAddress.estimatedRowHeight = 225
        tblAddress.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblAddress.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblAddress.tableFooterView = footerView
        
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        GetBillingAddressAPI()
    }
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view .endEditing(true)
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSearchVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func addNewAddressAction(_ sender: Any) {
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kBillingAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    @IBAction func continueBtnAction(_ sender: Any) {
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kOrderSummaryVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.addressArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DeliveryAddressTableCell") as! DeliveryAddressTableCell
        let dictObjAddress = self.addressArray.object(at: indexPath.row)as! NSDictionary;
        let street = (dictObjAddress.value(forKey: "street")as? NSArray ?? []);
        let region = (dictObjAddress.value(forKey: "region")as? NSDictionary ?? [:]);
        var country = (dictObjAddress.value(forKey: "country_id")as? String ?? "");
        if(country == "IN"){
            country = "India";
        }
        let StreetName = (street.object(at: 0)as? String ?? "");
        let city = (dictObjAddress.value(forKey: "city")as? String ?? "");
        let postcode = (dictObjAddress.value(forKey: "postcode")as? String ?? "");
        let regionName = (region.value(forKey: "region")as? String ?? "");
        cellObj.lblAddress.text  =  StreetName  + " , " + city + " , " + regionName + " , \n" + country  + ",\n" + postcode
        cellObj.lblUserName.text = (dictObjAddress.value(forKey: "firstname")as? String ?? "") + " " + (dictObjAddress.value(forKey: "lastname")as? String ?? "")
        cellObj.btnCall.setTitle((dictObjAddress.value(forKey: "telephone")as? String ?? ""), for: .normal);
        
        cellObj.menuOptionView.isHidden = true;
        
        cellObj.btnMenuOption.tag = indexPath.row;
        cellObj.btnMenuOption.addTarget(self, action: #selector(btnMenuOptionAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnEdit.tag = indexPath.row;
        cellObj.btnEdit.addTarget(self, action: #selector(btnEditAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnDelete.tag = indexPath.row;
        cellObj.btnDelete.addTarget(self, action: #selector(btnDeleteAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnCall.tag = indexPath.row;
        cellObj.btnCall.addTarget(self, action: #selector(btnCallAction(button:)), for: UIControlEvents.touchUpInside);
        //        cellObj.btnAddressSelect.tag = indexPath.row;
        //        cellObj.btnAddressSelect.addTarget(self, action: #selector(btnAddressSelectAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:DeliveryAddressTableCell = tableView.cellForRow(at: indexPath) as! DeliveryAddressTableCell
        cell.btnAddressSelect.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell:DeliveryAddressTableCell = tableView.cellForRow(at: indexPath) as! DeliveryAddressTableCell
        cell.btnAddressSelect.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        
    }
    
    @objc func btnMenuOptionAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblAddress)
        let indexPath = self.tblAddress.indexPathForRow(at: position)
        let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
        
        cell.menuOptionView.isHidden = false;
    }
    
    @objc func btnEditAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblAddress)
        let indexPath = self.tblAddress.indexPathForRow(at: position)
        let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
        cell.menuOptionView.isHidden = true;
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kEditBillingAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @objc func btnDeleteAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblAddress)
        let indexPath = self.tblAddress.indexPathForRow(at: position)
        let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
        
        cell.menuOptionView.isHidden = true;
        
    }
    
    @objc func btnCallAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblAddress)
        let indexPath = self.tblAddress.indexPathForRow(at: position)
        let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
        let dictObjAddress = self.addressArray.object(at: indexPath!.row)as! NSDictionary;
        callNumber(phoneNumber:(dictObjAddress.value(forKey: "telephone")as? String ?? ""));
    }
    
    /*@objc func btnAddressSelectAction(button: UIButton) {
     
     let position: CGPoint = button.convert(.zero, to: self.tblAddress)
     let indexPath = self.tblAddress.indexPathForRow(at: position)
     let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
     
     
     }
     */
    
    
    //--------------------------------------
    // MARK: - Get Billing Address API Call
    //--------------------------------------
    
    func GetBillingAddressAPI()  {
        
        if Connectivity.isConnectedToInternet {
            let data =  kAppDelegate.getLoginUserData()
            var paraDict = NSMutableDictionary()
            paraDict =  ["user_id":data.id] as NSMutableDictionary
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
                                self.tblAddress.reloadData();
                                
                            }else {
                                
                                self.tblAddress.isHidden = true;
                                UIView.animate(withDuration: 0.5) {
                                    self.view.updateConstraints()
                                    self.view.layoutIfNeeded()
                                }
                            }
                        }
                    }else {
                        
                        self.tblAddress.isHidden = true;
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
    
}
