//
//  CartViewController.swift
//  MedicoBox
//
//  Created by SBC on 29/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        lblMrpTotalOrder.text = "\u{20B9}" + " 350.00"
        lblPriceDiscountOrder.text = "- "  + "\u{20B9}" + " 35.00"
//        lblShippingChargesOrder.text =  "0"
        lblTotalSavedOrder.text = "\u{20B9}" + " 30.00"
        lblAmountPaidOrder.text = "\u{20B9}" + " 350.00"
        itemTableView.register(UINib(nibName: "CartOrderSummaryTableCell", bundle: nil), forCellReuseIdentifier: "CartOrderSummaryTableCell")
        itemTableView.estimatedRowHeight = 65
        itemTableView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: itemTableView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        itemTableView.tableFooterView = footerView
        
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pinApplyAction(_ sender: Any) {
    }
    
    
    @IBAction func uploadPrescriptionAction(_ sender: Any) {
        
        let Controller = kCartStoryBoard.instantiateViewController(withIdentifier: kCartOrderSummaryVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
  
    @IBAction func btnContinueAction(_ sender: Any) {
        
        let Controller = kCartStoryBoard.instantiateViewController(withIdentifier: kCartOrderSummaryVC)
        self.navigationController?.pushViewController(Controller, animated: true)
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
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "CartOrderSummaryTableCell") as! CartOrderSummaryTableCell
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}
