//
//  SelectAddressViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SelectAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?

    @IBOutlet weak var tblAddress: UITableView!
    
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
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DeliveryAddressTableCell") as! DeliveryAddressTableCell
        cellObj.lblAddress.text = "Flat No 104, A Wing \nGreen Olive Apartments,\nHinjawadi \nPune - 411057\n Maharashtra \nIndia"
        
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
        
        let phoneNumber = 7584882272;
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    /*@objc func btnAddressSelectAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblAddress)
        let indexPath = self.tblAddress.indexPathForRow(at: position)
        let cell:DeliveryAddressTableCell = tblAddress.cellForRow(at: indexPath!) as! DeliveryAddressTableCell
    
        
    }
    */

}
