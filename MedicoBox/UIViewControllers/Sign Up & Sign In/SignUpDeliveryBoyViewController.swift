//
//  SignUpDeliveryBoyViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SignUpDeliveryBoyViewController: UIViewController , UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var tblSignUpDeliveryBoy: UITableView!
    
    let arrayofText:NSArray = ["First name","Last name","Contact number 1", "Contact number 2", "Email ID","Name of pharmacy","Address line 1", "Address line 2","City", "State","Country","Pincode","Pharmacist registration number", "Drug license number","Message"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell for tableview
        tblSignUpDeliveryBoy.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        tblSignUpDeliveryBoy.estimatedRowHeight = 65
        tblSignUpDeliveryBoy.separatorStyle = .none
        
        
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
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
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

}
