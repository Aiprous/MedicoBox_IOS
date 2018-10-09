//
//  OrderPlacedThankYouViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderPlacedThankYouViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var tblOrderItems: UITableView!
    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    @IBOutlet weak var lblAddressView: UILabel!
   
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        //show navigationbar with back button
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        
        lblMrpTotalOrder.text = "\u{20B9}" + " 350.00"
        lblPriceDiscountOrder.text = "- "  + "\u{20B9}" + " 35.00"
        lblShippingChargesOrder.text =  "0"
        lblTotalSavedOrder.text = "\u{20B9}" + " 30.00"
        lblAmountPaidOrder.text = "\u{20B9}" + " 350.00"
        
        lblAddressView.text = "Flat No 104, A Wing \nGreen Olive Apartments,\nHinjawadi \nPune - 411057\nMaharashtra \nIndia"
        
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
            cellObj.lblSubTitleOrderItems.text = "box of 450 gm Powder"
            cellObj.lblPriceOrderItems.text = "\u{20B9}" + " 200.00"
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            cellObj.lblTrasOrderItems.isHidden = true;
//            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")

        }
        else if(indexPath.row == 1){
            
            cellObj.lblTitleOrderItems.text = "Combiflam Lcy Hot Fast Pain Relief Spray"
            cellObj.lblSubTitleOrderItems.text = "bottle of 35 gm Spray"
            cellObj.lblPriceOrderItems.text = "\u{20B9}" + " 92.00"
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            cellObj.lblTrasOrderItems.isHidden = true;
//            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            
        }
        else if(indexPath.row == 2){
            
            cellObj.lblTitleOrderItems.text = "Horicks Lite Badam Jar 450 gm"
            cellObj.lblSubTitleOrderItems.text = "box of 450 gm Powder"
            cellObj.lblPriceOrderItems.text = "\u{20B9}" + " 200.00"
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            cellObj.lblTrasOrderItems.isHidden = true;

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
    
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        numberCount = 1;
        return numberCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
        // get a reference to our storyboard cell
        let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionCollectionViewCell", for: indexPath as IndexPath) as! PrescriptionCollectionViewCell
        
        return cellObj;
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 112, height: 133)
        
    }
    @IBAction func btnGoToMyOrdersAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
        
    }
    
}
