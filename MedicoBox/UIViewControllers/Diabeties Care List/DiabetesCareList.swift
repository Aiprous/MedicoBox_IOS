//
//  DiabetesCareList.swift
//  MedicoBox
//
//  Created by SBC on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

class DiabetesCareList: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var diabetesTblView: UITableView!
    
    var productsListArray =  NSArray();
    var cartArray = NSArray();
    var category_id : NSString?
    var product_Id = "";
    var sku_id = "";
    var productItem_id = "";
    var qty = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        
        // Do any additional setup after loading the view.
        diabetesTblView.register(UINib(nibName: "DiabetesCareCell", bundle: nil), forCellReuseIdentifier: "DiabetesCareCell")
        diabetesTblView.estimatedRowHeight = 130
        diabetesTblView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: diabetesTblView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        diabetesTblView.tableFooterView = footerView
        self.callAPIGetProductsList()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.isNavigationBarHidden = false;
        self.callAPIGetCartData()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- SearchBar Delegate And DataSource
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view .endEditing(true)
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSearchVC)
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
        return self.productsListArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DiabetesCareCell") as! DiabetesCareCell
        
        let dictObj = self.productsListArray.object(at: indexPath.row) as! NSDictionary
        
        if dictObj.value(forKey: "wishlist") as? String == "1" {
            cellObj.btnLike.setImage(#imageLiteral(resourceName: "heart-active"), for: .normal)
        }else{
            cellObj.btnLike.setImage(#imageLiteral(resourceName: "heart-inactive"), for: .normal)
        }
        
        cellObj.lblTabletName.text = (dictObj.value(forKey: "title") as? String ?? "")!;
        cellObj.lblSku.text = (dictObj.value(forKey: "sku") as? String ?? "")!;
        cellObj.lblDescription.text = (dictObj.value(forKey: "short_description") as? String ?? "")!;
        cellObj.lblID.text = (dictObj.value(forKey: "id") as? String ?? "")!;
        cellObj.lblPrescriptionRequired.text =  (dictObj.value(forKey: "prescription_required") as? String ?? "")!
        
        if(dictObj.value(forKey: "discount") as? String != "0"){
            
             cellObj.lblOffer.isHidden = false;
             cellObj.lblOffer.text =  (dictObj.value(forKey: "discount") as? String ?? "")! + "% OFF ";
        }else {
            
            cellObj.lblOffer.isHidden = true;
            
        }
        if(dictObj.value(forKey: "sale_price") as? String == ""){
            
             cellObj.lblMRP.text =  "\u{20B9} " + (dictObj.value(forKey: "price") as? String ?? "")!;
            cellObj.lblDiscount.text =  "\u{20B9} " + (dictObj.value(forKey: "price") as? String ?? "")!;
            
        }else {
            
             cellObj.lblMRP.text =  "\u{20B9} " + (dictObj.value(forKey: "sale_price") as? String ?? "")!;
            let price:Float = Float(dictObj.value(forKey: "price") as? String ?? "")!;
            //strikeOnLabel
            let strikePrice = price
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencyCode = "INR"
            let priceInINR = currencyFormatter.string(from: strikePrice as NSNumber)
            let attributedString = NSMutableAttributedString(string: priceInINR!)
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
            cellObj.lblDiscount.attributedText = attributedString;
            
        }
        
        cellObj.btnLike.tag = indexPath.row;
        cellObj.btnLike.addTarget(self, action: #selector(btnLikeAction(button:)), for: UIControlEvents.touchUpInside);
        
        let URLstr =  (dictObj.value(forKey: "image") as? String ?? "")!
        let url = URL.init(string: URLstr )
        if url != nil
        {
            cellObj.imageViewTablet.sd_setImage(with: url! , completed: { (image, error, cacheType, imageURL) in
                cellObj.imageViewTablet.image = image
            })
        }
        
        cellObj.cartView.isHidden = true;
        cellObj.btnAdd.isHidden = false;
        cellObj.btnAdd.tag = indexPath.row;
        cellObj.btnAdd.addTarget(self, action: #selector(btnAddAction(button:)), for: UIControlEvents.touchUpInside);
        
//        self.cartArray = (UserDefaults.standard.object(forKey: "CartArray")as? NSArray)!
        
        if(self.cartArray.count != 0){
            
            for dictObjCart in self.cartArray {
                
                if(((dictObj.value(forKey: "title") as? String ?? "")! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && ((dictObj.value(forKey: "sku") as? String ?? "")! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                    
                    let qty = (dictObjCart as AnyObject).value(forKey: "qty")as? Int ?? 0;
                    cellObj.lblProductQty.text = String(qty);
                    cellObj.btnAdd.isHidden = true;
                    cellObj.cartView.isHidden = false;
                    cellObj.btnPlus.tag = indexPath.row;
                    cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
                    cellObj.btnMinus.tag = indexPath.row;
                    cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
                    break;
                }
            }
        }
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension   //130;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:DiabetesCareCell = tableView.cellForRow(at: indexPath) as! DiabetesCareCell
        let id = cell.lblID.text!
        let ProductQty = cell.lblProductQty.text!
        let sku_id = cell.lblSku.text!
        for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                
            }
        }
        
        kKeyProductID = id;
        kKeyProductQty = ProductQty;
        kKeyProductItemID = self.productItem_id
        kKeySkuID = sku_id
        //        if indexPath.row % 2 == 0 {
        //
        //            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailAVC)
        //
        //            self.navigationController?.pushViewController(Controller, animated: true)
        //
        //        }else{
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailBVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        //        }
        
    }
    
    @objc func btnAddAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        //            cell.cartView.isHidden = false;
        //            cell.btnAdd.isHidden = true;
        //            cell.lblProductQty.text = "1";
        self.product_Id = cell.lblID.text!
        self.sku_id = cell.lblSku.text!
        self.qty =  "1"
        self.callAPIAddToCart()
        
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        i = i + 1;
        cell.lblProductQty.text = String(i);
        
        for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        
        if( i > 1 ){
            
            i = i - 1;
            cell.btnMinus.isEnabled = true;
            cell.lblProductQty.text = String(i);
            cell.cartView.isHidden = false;
            cell.btnAdd.isHidden = true;
            
        }else {
            
            i = 1
            cell.btnMinus.isEnabled = false;
            cell.lblProductQty.text = String(i);
            cell.cartView.isHidden = false;
            cell.btnAdd.isHidden = true;
        }
        
        for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }
        
    }
    
    @objc func btnLikeAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        let dict = self.productsListArray[button.tag] as! NSDictionary
        if(button.isSelected != true){
            
            let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
            customAlert.productId = (dict.value(forKey: "id") as? String)
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.delegate = self
            self.present(customAlert, animated: true, completion: nil)
            cell.btnLike.setImage(#imageLiteral(resourceName: "heart-active"), for: .normal)
            button.isSelected = true;
            
        }else {
            
            cell.btnLike.setImage(#imageLiteral(resourceName: "heart-inactive"), for: .normal)
            button.isSelected = false;
            
        }
        
    }
    
    //--------------------------------
    // MARK: - Product List API Call
    //--------------------------------
    
    func callAPIGetProductsList() {
        
        var paraDict = NSMutableDictionary()
        
            paraDict =  ["category_id": category_id ?? "38", "user_id": "226"] as NSMutableDictionary
        
        
        let urlString = BASEURL + "/API/products.php"
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
                        let dict = responseDict.value(forKey: "response") as? NSDictionary
                        if dict?.value(forKey: "status") as? String  == "success" {
                            self.productsListArray = (dict?.value(forKey: "products") as? NSArray ?? [])!;
//                            print(self.productsListArray)
                            self.diabetesTblView.reloadData();
                        }
                       
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    
    //--------------------------------
    // MARK: - Add To Cart  API Call
    //--------------------------------
    
    func callAPIAddToCart() {
        
        var paraDict = NSMutableDictionary()
        var cartArr = NSDictionary()
        
        cartArr = ["quote_id":kKeyUserCartID,"sku":self.sku_id,"qty":self.qty]
        paraDict =  ["cart_item": cartArr] as NSMutableDictionary
        let urlString =  BASEURL  + "/index.php/rest/V1/carts/mine/items"
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        self.callAPIGetCartData()
                        print(responseDict);
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
    
    func callAPIGetCartData() {
        let urlString = kKeyGetCartDataAPI;
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        if((responseDict.value(forKey: "res")) != nil){
                            
                            if let val = responseDict.value(forKey: "res") as? NSArray {
                                self.cartArray = val;
                            }
                           
//                            UserDefaults.standard.set(cartAllArray, forKey: "CartArray")
                            print(responseDict);
                            kKeyCartCount = String(self.cartArray.count);
//                            self.viewDidLoad();
                            self.diabetesTblView.reloadData()
                            
                        }else {
                            
//                            UserDefaults.standard.removeObject(forKey: "CartArray")
                            self.diabetesTblView.reloadData()
                            self.showToast(message: "Your cart is empty. Please add items in your cart ")
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
    // MARK: - Edit Cart  API Call
    //--------------------------------
    
    func callAPIEditCart() {
        
        var paraDict = NSMutableDictionary()
        var cartArr = NSDictionary()
        cartArr = ["quote_id":kKeyUserCartID,"item_id":self.productItem_id,"qty":self.qty]
        paraDict =  ["cart_item": cartArr] as NSMutableDictionary
        let urlString =  kKeyEditCartAPI + productItem_id
        print(urlString, paraDict)
        //        SVProgressHUD .show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .put, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                //                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        self.callAPIGetCartData()
                        print(responseDict);
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
extension DiabetesCareList: CustomAlertViewDelegate {
    
    func okButtonTapped(selectedOption: String, textFieldValue: String) {
        print("okButtonTapped with \(selectedOption) option selected")
        print("TextField has value: \(textFieldValue)")
    }
    
    func saveButtonTapped(wishlist_name_id:String) {
        print("SaveButtonTapped")
        self.callAPIGetProductsList()
    }
}
