//
//  OrderPlacedThankYouViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

class OrderPlacedThankYouViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource , UIScrollViewDelegate{
    
    @IBOutlet weak var tblOrderItems: UITableView!
    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    
    @IBOutlet weak var mainViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: DesignableShadowView!
    @IBOutlet weak var bottomViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnAttachedPresription: UIButton!
    @IBOutlet weak var lblAddressView: UILabel!
   
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    var productsListArray =  NSArray();
    var flagViewWillAppear = "";

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
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblOrderItems.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblOrderItems.tableFooterView = footerView
        
        flagViewWillAppear = "true";


    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        callAPIGetProductsList()
        
        if(flagViewWillAppear == "true"){

            bottomViewHightConstraint.constant = 50;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
            self.prescriptionCollectionView.isHidden = true;

            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            flagViewWillAppear = "false";
            
        }else {
            
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.productsListArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "OrderItemsTableViewCell") as! OrderItemsTableViewCell
        
        let dictObj = self.productsListArray.object(at: indexPath.row) as! NSDictionary
        
        cellObj.lblTrasOrderItems.isHidden = true;
        cellObj.lblTitleOrderItems.text = (dictObj.value(forKey: "title") as? String)!;
        cellObj.lblPriceOrderItems.text =  "\u{20B9} " + (dictObj.value(forKey: "price") as? String)!;
        //         cellObj.lblMRPRateOrderItems.text =  (dictObj.value(forKey: "sale_price") as? String)!;
        //        cellObj.lblSubTitleOrderItems.text = (dictObj.value(forKey: "short_description") as? String)!;
        //        cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
        
        let URLstr =  (dictObj.value(forKey: "image") as? String)!
        let url = URL.init(string: URLstr )
        if url != nil
        {
            cellObj.imgOrderItems.sd_setImage(with: url! , completed: { (image, error, cacheType, imageURL) in
                
                cellObj.imgOrderItems.image = image
                
            })
        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:OrderItemsTableViewCell = tableView.cellForRow(at: indexPath) as! OrderItemsTableViewCell
        

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
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kMyOrdersVC)
        self.navigationController?.pushViewController(Controller!, animated: true)
       
        
    }
    
    @IBAction func btnAttachedPresriptionAction(_ sender: Any) {
        
        if(btnAttachedPresription.isSelected == false){
            
            bottomViewHightConstraint.constant = 207;
            collectionViewHightConstraint.constant = 147;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant + 157;
            self.prescriptionCollectionView.isHidden = false;
            self.btnAttachedPresription.isSelected = true;
            
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

            
        }else {
            
            bottomViewHightConstraint.constant = 50;
            collectionViewHightConstraint.constant = 0;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
            self.prescriptionCollectionView.isHidden = true;
            self.btnAttachedPresription.isSelected = false;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

        }
    }
    
    func callAPIGetProductsList() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["category_id": "38"] as NSMutableDictionary
        
        let urlString = BASEURL +  "/API/products.php"
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "bearer " + "KJF73RWHFI23R" ]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        self.productsListArray = (responseDict.value(forKey: "response") as? NSArray)!;
                        self.tblOrderItems.reloadData();
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    
}
