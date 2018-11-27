//
//  EditBillingAddressVC.swift
//  MedicoBox
//
//  Created by SBC on 23/11/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class EditBillingAddressVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        self.setNavigationBarItemBackButton()
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
    
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kOrderSummaryVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
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
