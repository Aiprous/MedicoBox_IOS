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

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    @IBOutlet weak var btnUploadTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblFreeshipping: UILabel!
    @IBOutlet weak var priceViewHightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var cartTblView: DesignableShadowView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    @IBOutlet weak var lblItems: UILabel!
    
    var productsListArray =  NSArray();
    var cartArray = NSArray();
    var productItem_Id = "";
    var sku_id = "";
    var qty = "";
    var MRPTotal:Int =  0;
    var DiscountTotal:Int =  0;
    var AmountPaid:Int =  0;
    var TotalSaved:Int =  0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false;
         searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItem(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        
        self.MRPTotal = 0;
        self.DiscountTotal =  0;
        self.AmountPaid = 0;
        self.TotalSaved = 0;
        
        self.lblFreeshipping.text = "Free shipping for orders above " + "\u{20B9}" + " 500"
        itemTableView.register(UINib(nibName: "CartItemTableCell", bundle: nil), forCellReuseIdentifier: "CartItemTableCell")
        itemTableView.estimatedRowHeight = 65
        itemTableView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: itemTableView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        itemTableView.tableFooterView = footerView
        
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        self.callAPIGetCartData()
        
        if(kKeyCartCount == "0"){
            
            self.cartTblView.isHidden = true;
            self.btnUploadTopLayoutConstraint.constant = 20;
            self.priceViewHightLayoutConstraint.constant = 191;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            self.lblItems.isHidden = true;
        }else {
            
            self.cartTblView.isHidden = false;
            self.lblItems.isHidden = false;

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pinApplyAction(_ sender: Any) {
    }
    
    
    @IBAction func uploadPrescriptionAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kUploadPrescriptionVC)
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
        
        cellObj.lblTabletName.text = (dictObj.value(forKey: "name") as? String ?? "")!;
        cellObj.lblSku.text = (dictObj.value(forKey: "sku") as? String ?? "")!;
        cellObj.lblDescription.text = (dictObj.value(forKey: "short_description") as? String ?? "")!;
        let ID = (dictObj.value(forKey: "item_id") as? Int ?? 0)!
        cellObj.lblID.text = String(ID);
        let qty = ((dictObj as AnyObject).value(forKey: "qty") as? Int ?? 0)!;
        cellObj.lblProductQty.text = String(qty);
        
      
        if(dictObj.value(forKey: "sale_price")as? String ??
            "" == ""){
            
            cellObj.lblMRP.text =  "\u{20B9} " + (dictObj.value(forKey: "price")  as? String ?? "");
             cellObj.lblDiscount.text =  "\u{20B9} " + (dictObj.value(forKey: "price")  as? String ?? "");
            
        }else {
            
            let price = Float(dictObj.value(forKey: "price")as? String ?? "")
            cellObj.lblMRP.text =  "\u{20B9} " + (dictObj.value(forKey: "sale_price")  as? String ?? "");
            
            //strikeOnLabel
            let strikePrice = price
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencyCode = "INR"
            let priceInINR = currencyFormatter.string(from: strikePrice! as NSNumber)
            let attributedString = NSMutableAttributedString(string: priceInINR!)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
            cellObj.lblDiscount.attributedText = attributedString;
            
        }
        
        cellObj.btnPlus.tag = indexPath.row;
        cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnMinus.tag = indexPath.row;
        cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnDelete.tag = indexPath.row;
        cellObj.btnDelete.addTarget(self, action: #selector(btnDeleteAction(button:)), for: UIControlEvents.touchUpInside);
     
        cellObj.selectionStyle = .none
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
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        i = i + 1;
        cell.lblProductQty.text = String(i);
        
        for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_Id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.itemTableView)
        let indexPath = self.itemTableView.indexPathForRow(at: position)
        let cell:CartItemTableCell = itemTableView.cellForRow(at: indexPath!) as! CartItemTableCell
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        
        if( i > 1 ){
            
            i = i - 1;
            cell.btnMinus.isEnabled = true;
            cell.lblProductQty.text = String(i);
            
        }else {
            
            i = 1
            cell.btnMinus.isEnabled = false;
            cell.lblProductQty.text = String(i);
            
        }
        
        for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_Id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }
        
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
        
        let urlString = kKeyGetCartDataAPI;
        print(urlString)
        SVProgressHUD.show()
        
//        "X-Requested-With": "XMLHttpRequest",
        
        let headers: HTTPHeaders = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "postman-token": "651f0777-5b24-7c94-a4e5-cd200b0b06a7",
            "authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        if((responseDict.value(forKey: "res")) != nil){
                            
                            self.productsListArray = (responseDict.value(forKey: "res") as? NSArray ?? [])!;
                            self.cartArray = self.productsListArray;
                            
                            for dictObjCart in self.productsListArray {
                                
                                //Calculate Total MRP price
                                let price = ((dictObjCart as AnyObject).value(forKey: "price")as? String ?? "");
                                var sale_price = ((dictObjCart as AnyObject).value(forKey: "sale_price")as? String ?? "");
                                let qty = ((dictObjCart as AnyObject).value(forKey: "qty")as? Int ?? 0);

                                self.MRPTotal = self.MRPTotal + (price as NSString).integerValue * qty;
                                self.lblMrpTotalOrder.text = "\u{20B9} " + String(self.MRPTotal)
                                
                                //Calculate Total Discount price
                                if(sale_price == ""){
                                    sale_price = price;
                                }
                                self.DiscountTotal = self.DiscountTotal + ((dictObjCart as AnyObject).value(forKey: "discount")  as? Int ?? 0) * qty
                                self.lblPriceDiscountOrder.text = "\u{20B9} " + String(self.DiscountTotal)
                                
                                //Calculate Total Paid price
                                self.AmountPaid = self.AmountPaid + (sale_price as NSString).integerValue * qty
                                self.lblAmountPaidOrder.text =  "\u{20B9} " + String(self.AmountPaid)
                                
                                //Calculate Total Saved price
                                self.TotalSaved = self.DiscountTotal
                                self.lblTotalSavedOrder.text = "\u{20B9} " + String(self.TotalSaved)
                            }
                            
                            kKeyCartCount = String((self.productsListArray.count) as? Int ?? 0);
                            
                            if(kKeyCartCount == "0"){
                                
                                self.cartTblView.isHidden = true;
                                self.lblItems.isHidden = true;
                                self.btnUploadTopLayoutConstraint.constant = 20;
                                self.priceViewHightLayoutConstraint.constant = 191;
                                
                                UIView.animate(withDuration: 0.5) {
                                    self.view.updateConstraints()
                                    self.view.layoutIfNeeded()
                                }                            }else {
                                
                                self.cartTblView.isHidden = false;
                                self.lblItems.isHidden = false;
                            }
                            print(responseDict);
                            self.itemTableView.reloadData()
                            self.viewDidLoad();
                            
                        }else {
                            
                            self.showToast(message: "Your cart is empty. Please add items in your cart ")
                            self.itemTableView.reloadData()
                            self.viewDidLoad();
                            self.scrollView.isHidden = true;
//                            self.cartTblView.isHidden = true;
//                            self.lblItems.isHidden = true;
//                            self.btnUploadTopLayoutConstraint.constant = 20;
//                            self.priceViewHightLayoutConstraint.constant = 191;
//
                            
                        }
                  
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
        
        let urlString = kKeyDeleteCartAPI  + productItem_Id
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
                        let str = resposeData.result.value as? String ?? "";
                        print(str);
                        self.viewDidLoad();
                        self.callAPIGetCartData()

                    }
                    else{
                        
                      
                }
            })
        }
    }
    
    
    //--------------------------------
    // MARK: - Edit Cart  API Call
    //--------------------------------
    
    func callAPIEditCart() {
        
        var paraDict = NSMutableDictionary()
        var cartArr = NSDictionary()
        cartArr = ["quote_id":kKeyUserCartID,"item_id":self.productItem_Id,"qty":self.qty]
        paraDict =  ["cart_item": cartArr] as NSMutableDictionary
        let urlString =  kKeyEditCartAPI + productItem_Id
        print(urlString, paraDict)
        SVProgressHUD .show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .put, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
            SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        self.callAPIGetCartData()
                        print(responseDict);
                        self.viewDidLoad();
                        
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
