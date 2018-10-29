//
//  CartViewController.swift
//  MedicoBox
//
//  Created by SBC on 29/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemTableView: UITableView!
    
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    
    var productsListArray =  NSArray();
    var cartArray = NSArray();
    var productItem_Id = "";
    var sku_id = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        lblMrpTotalOrder.text = "\u{20B9}" + " 350.00"
        lblPriceDiscountOrder.text = "- "  + "\u{20B9}" + " 35.00"
//        lblShippingChargesOrder.text =  "0"
        lblTotalSavedOrder.text = "\u{20B9}" + " 30.00"
        lblAmountPaidOrder.text = "\u{20B9}" + " 350.00"
        
        itemTableView.register(UINib(nibName: "CartItemTableCell", bundle: nil), forCellReuseIdentifier: "CartItemTableCell")
        itemTableView.estimatedRowHeight = 65
        itemTableView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: itemTableView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        itemTableView.tableFooterView = footerView
        
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        self.callAPIGetCartData()
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
        return productsListArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "CartItemTableCell") as! CartItemTableCell
        
        let dictObj = self.productsListArray.object(at: indexPath.row) as! NSDictionary
        
        cellObj.lblTabletName.text = (dictObj.value(forKey: "name") as? String)!;
        cellObj.lblSku.text = (dictObj.value(forKey: "sku") as? String)!;
        //        cellObj.lblDescription.text = (dictObj.value(forKey: "short_description") as? String)!;
        let ID = (dictObj.value(forKey: "item_id") as? Int)!
        cellObj.lblID.text = String(ID);
        cellObj.lblMRP.text =  "\u{20B9} " + String((dictObj.value(forKey: "price") as? Int)!) + ".00";
        let qty = (dictObj as AnyObject).value(forKey: "qty")as? Int;
        cellObj.lblProductQty.text = String(qty!);
        cellObj.btnPlus.tag = indexPath.row;
        cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnMinus.tag = indexPath.row;
        cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnDelete.tag = indexPath.row;
        cellObj.btnDelete.addTarget(self, action: #selector(btnDeleteAction(button:)), for: UIControlEvents.touchUpInside);

        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.itemTableView)
        let indexPath = self.itemTableView.indexPathForRow(at: position)
        let cell:CartItemTableCell = itemTableView.cellForRow(at: indexPath!) as! CartItemTableCell
        
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.itemTableView)
        let indexPath = self.itemTableView.indexPathForRow(at: position)
        let cell:CartItemTableCell = itemTableView.cellForRow(at: indexPath!) as! CartItemTableCell
        
    }
    
    @objc func btnDeleteAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.itemTableView)
        let indexPath = self.itemTableView.indexPathForRow(at: position)
        let cell:CartItemTableCell = itemTableView.cellForRow(at: indexPath!) as! CartItemTableCell
        
        self.productItem_Id = cell.lblID.text!
        self.callAPIGetCartItemDelete()
        self.itemTableView.reloadData()
    }
    
    //--------------------------------
    // MARK: - Get Cart Data API Call
    //--------------------------------
    
    func callAPIGetCartData() {
        
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/carts/mine"
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        self.productsListArray = (responseDict.value(forKey: "items") as? NSArray)!;
                        print(responseDict);
                        self.itemTableView.reloadData()
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    
    
    //--------------------------------
    // MARK: - Get Cart Data API Call
    //--------------------------------
    
    func callAPIGetCartItemDelete() {
        
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/carts/mine/items/" + productItem_Id
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        let str = resposeData.result.value as? String;
                        print(str);
                    }
                    else{
                        
                      
                }
            })
        }
    }
    
    
}
