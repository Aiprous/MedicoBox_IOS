//
//  BillingAddressVC.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class BillingAddressVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,  UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var tblAddressField: UITableView!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnOffice: UIButton!
    @IBOutlet weak var btnHome : UIButton!
    let arrayofText:NSArray = ["Name","Phone*","Flat Number, Building Name*","Street / Road Name", "Landmark","Pincode*","State","City"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Register cell for tableview
        tblAddressField.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        tblAddressField.estimatedRowHeight = 65
        tblAddressField.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblAddressField.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblAddressField.tableFooterView = footerView
        
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        self.navigationController?.isNavigationBarHidden = false;
        
        btnOffice.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnHome.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
        btnOther.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        tblAddressField.frame = CGRect(x: tblAddressField.frame.origin.x, y: tblAddressField.frame.origin.y, width: tblAddressField.frame.size.width, height: (CGFloat(65*arrayofText.count)));
        //
        //        self.view.setNeedsUpdateConstraints()
    }
    
    
    func getTextFeildValuesFromTableView() ->[String:String]?{
        var values = [String:String]()
        for (index, value) in arrayofText.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = tblAddressField.cellForRow(at: indexPath) as? AddressTableViewCell else{
                return nil
            }
            if let text = cell.textField.text {
                values[value as! String] = text
                //                values[value] = text
            }
        }
        return values
    }
    
    func validateForm() -> Bool {
        let arrayofValues:[String:String] = getTextFeildValuesFromTableView() ?? [:]
        if !arrayofValues.isEmpty {
            if (arrayofValues["Name"] != nil) && (arrayofValues["Name"]?.isEmpty)!{
                print("Name is Empty")
                alertWithMessage(title: "Alert", message: "Please enter name", vc: self)
                return false;
            }else if (arrayofValues["Phone*"] != nil) && (arrayofValues["Phone*"]?.isEmpty)!{
                print("Phone* is Empty")
                alertWithMessage(title: "Alert", message: "Please enter Phone", vc: self)
                return false
            }else if ( arrayofValues["Phone*"]?.count != 10){
                print("Please enter valid 10 digit mobile number")
                alertWithMessage(title: "Alert", message: "Please enter valid 10 digit phone number", vc: self)
                return false
            }else if (arrayofValues["Flat Number, Building Name*"] != nil) && (arrayofValues["Flat Number, Building Name*"]?.isEmpty)!{
                print("Flat Number, Building Name* is Empty")
                alertWithMessage(title: "Alert", message: "Please enter flat number, building name", vc: self)
                return false
            }else if (arrayofValues["Street / Road Name"] != nil) && (arrayofValues["Street / Road Name"]?.isEmpty)!{
                print("Street / road name is Empty")
                alertWithMessage(title: "Alert", message: "Please enter street / road name", vc: self)
                return false
            }else if (arrayofValues["Landmark"] != nil) && (arrayofValues["Landmark"]?.isEmpty)!{
                print("Landmark is Empty")
                alertWithMessage(title: "Alert", message: "Please enter landmark", vc: self)
                return false
            }else if (arrayofValues["Pincode*"] != nil) && (arrayofValues["Pincode*"]?.isEmpty)!{
                print("Pincode is Empty")
                alertWithMessage(title: "Alert", message: "Please enter pincode", vc: self)
                return false
            }else if (arrayofValues["State"] != nil) && (arrayofValues["State"]?.isEmpty)!{
                print("State is Empty")
                alertWithMessage(title: "Alert", message: "Please enter state", vc: self)
                return false
            }else if (arrayofValues["City"] != nil) && (arrayofValues["City"]?.isEmpty)!{
                print("City is Empty")
                alertWithMessage(title: "Alert", message: "Please enter city", vc: self)
                return false
            }else{
                return true
            }
        }
        return false
    }
    
    
    //MARK: - Textfield delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 10
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = tblAddressField.cellForRow(at: indexPath) as? AddressTableViewCell
        if  textField == cell?.textField {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
       
        
        return true
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        if validateForm() {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayofText.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
        
        cellObj.textField.text = ""
        cellObj.textField.placeholder = arrayofText[indexPath.row] as? String
        if (arrayofText[indexPath.row] as? String == "Phone*") || (arrayofText[indexPath.row] as? String == "Pincode*") {
            cellObj.textField.keyboardType = .numberPad
        }
        
        cellObj.textField.delegate = self;
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 65
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func btnHomeAction(_ sender: Any) {
        
        if(btnHome.isSelected == false){
            
            btnHome.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnOffice.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnOther.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnHome.isSelected  = true;
            
            
        }else {
            
            btnHome.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            self.btnHome.isSelected = false;
            
            
        }
    }
    
    @IBAction func btnOfficeAction(_ sender: Any) {
        
        if(btnOffice.isSelected == false){
            
            btnOffice.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnHome.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnOther.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnOffice.isSelected  = true;
            
            
        }else {
            
            btnOffice.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            self.btnOffice.isSelected = false;
            
            
        }
        
    }
    
    @IBAction func btnOtherAction(_ sender: Any) {
        
        if(btnOther.isSelected == false){
            
            btnOther.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnHome.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnOffice.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnOther.isSelected  = true;
            
            
        }else {
            
            btnOther.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            self.btnOther.isSelected = false;
            
            
        }
        
    }
    
}
