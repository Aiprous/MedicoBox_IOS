//
//  SelectAddressViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SelectAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblAddress: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register cell for tableview
        tblAddress.register(UINib(nibName: "DeliveryAddressTableCell", bundle: nil), forCellReuseIdentifier: "DeliveryAddressTableCell")
        tblAddress.estimatedRowHeight = 225
        tblAddress.separatorStyle = .none
        //show navigationbar with back button
        self.setNavigationBarItemBackButton()
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
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.row % 2 == 0 {
//            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: PRODUCT_DETAIL_A_VCID)
//            self.navigationController?.pushViewController(Controller, animated: true)
//        }else{
//            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: PRODUCT_DETAIL_B_VCID)
//            self.navigationController?.pushViewController(Controller, animated: true)
//        }
        
    }

}