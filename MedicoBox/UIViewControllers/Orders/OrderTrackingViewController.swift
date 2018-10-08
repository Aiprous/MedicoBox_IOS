//
//  OrderTrackingViewController.swift
//  MedicoBox
//
//  Created by SBC on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderTrackingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblOrderItems: UITableView!
    @IBOutlet weak var lblPriceOrder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tblOrderItems.separatorStyle = .none
    self.setNavigationBarItemBackButton()
       
        lblPriceOrder.text = "\u{20B9}" + " 350.00"

        self.navigationController?.isNavigationBarHidden = false;
        self.tblOrderItems.register(UINib(nibName: "OrderItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderItemsTableViewCell")
        tblOrderItems.delegate = self
        tblOrderItems.dataSource = self
        tblOrderItems.estimatedRowHeight = 130
        tblOrderItems.separatorStyle = .singleLine
        tblOrderItems.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "OrderItemsTableViewCell") as! OrderItemsTableViewCell
        
        //        cellObj.lblOrderPrice.text = "\u{20B9}" + " 278.00"
        
        if(indexPath.row == 0){
            
            cellObj.lblTitleOrderItems.text = "Horicks Lite Badam Jar 450 gm"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblPriceOrderItems.underline()
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            //            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            
        }
        else if(indexPath.row == 1){
            
            cellObj.lblTitleOrderItems.text = "Combiflam Lcy Hot Fast Pain Relief Spray"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblPriceOrderItems.underline()
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            //            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            
        }
        else if(indexPath.row == 2){
            
            cellObj.lblTitleOrderItems.text = "Horicks Lite Badam Jar 450 gm"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.lblPriceOrderItems.underline()
//            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")

        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 98
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:OrderItemsTableViewCell = tableView.cellForRow(at: indexPath) as! OrderItemsTableViewCell
        
        //        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kOrderCancelVC)
        //        self.navigationController?.pushViewController(Controller!, animated: true)
        //
    }
   
    @IBAction func btnCancelOrderAction(_ sender: Any) {
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kOrderCancelVC)
        self.navigationController?.pushViewController(Controller!, animated: true)
    }
}
