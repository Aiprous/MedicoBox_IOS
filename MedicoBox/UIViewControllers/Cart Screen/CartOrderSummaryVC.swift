//
//  CartOrderSummaryVC.swift
//  MedicoBox
//
//  Created by SBC on 29/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class CartOrderSummaryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource , UISearchBarDelegate {
    var searchBar :UISearchBar?

    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    
    @IBOutlet weak var bottomView: DesignableShadowView!
    @IBOutlet weak var bottomViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var mainViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnAttachedPresription: UIButton!
    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblFreeshipping: UILabel!
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    var flagViewWillAppear = "";

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        lblMrpTotalOrder.text = "\u{20B9}" + " 350.00"
        lblPriceDiscountOrder.text = "- "  + "\u{20B9}" + " 35.00"
        //        lblShippingChargesOrder.text =  "0"
        lblTotalSavedOrder.text = "\u{20B9}" + " 30.00"
        lblAmountPaidOrder.text = "\u{20B9}" + " 350.00"
        
         self.lblFreeshipping.text = "Free shipping for orders above " + "\u{20B9}" + " 500"
        itemTableView.register(UINib(nibName: "CartOrderSummaryTableCell", bundle: nil), forCellReuseIdentifier: "CartOrderSummaryTableCell")
        itemTableView.estimatedRowHeight = 120
        itemTableView.separatorStyle = .singleLine
         itemTableView.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: itemTableView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        itemTableView.tableFooterView = footerView
        
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;        self.navigationController?.isNavigationBarHidden = false;
        
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        flagViewWillAppear = "true";

//        self.mainViewHightConstraint.constant = -157;

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;

        if(flagViewWillAppear == "true"){

            bottomViewHightConstraint.constant = 50;
            flagViewWillAppear = "false";
            
        }else {
            
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func confirmOrderAction(_ sender: Any) {
        let Controller = kCartStoryBoard.instantiateViewController(withIdentifier: kPaymentDetailVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func changeDeliveryAddressAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kSelectAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
        
    }
    
    @IBAction func editBillingAddressAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kEditBillingAddressVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnAttachedPresriptionAction(_ sender: Any) {
        
        if(btnAttachedPresription.isSelected == false){
            
            bottomViewHightConstraint.constant = 207;
            collectionViewHightConstraint.constant = 147;
//            self.mainViewHightConstraint.constant = +157;
            self.prescriptionCollectionView.isHidden = false;
            self.btnAttachedPresription.isSelected = true;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }else {
            
            bottomViewHightConstraint.constant = 50;
//            self.mainViewHightConstraint.constant = -157;
            collectionViewHightConstraint.constant = 0;
            self.prescriptionCollectionView.isHidden = true;
            self.btnAttachedPresription.isSelected = false;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }        }
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
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "CartOrderSummaryTableCell") as! CartOrderSummaryTableCell
        
        cellObj.lblPriceOrderItems.text = "\u{20B9}" + " 278.00"
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
}
