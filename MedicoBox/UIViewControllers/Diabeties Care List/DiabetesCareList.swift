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

class DiabetesCareList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var diabetesTblView: UITableView!
    
    var productsListArray =  NSArray();
    var cartArray = NSArray();
    var product_Id = "";
    var sku_id = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false;
        // Do any additional setup after loading the view.
        diabetesTblView.register(UINib(nibName: "DiabetesCareCell", bundle: nil), forCellReuseIdentifier: "DiabetesCareCell")
        diabetesTblView.estimatedRowHeight = 130
        diabetesTblView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: diabetesTblView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        diabetesTblView.tableFooterView = footerView
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        self.callAPIGetProductsList()
        self.callAPIGetCartData()
        //Get Cart Id only once
        let returnValue: String = (UserDefaults.standard.object(forKey: "kKeyUserCartID") as? String)!
        kKeyUserCartID = returnValue;
        if(kKeyUserCartID == ""){
            self.callAPIGetCartID()
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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DiabetesCareCell") as! DiabetesCareCell
        
        let dictObj = self.productsListArray.object(at: indexPath.row) as! NSDictionary
        
        /*
         {
         id = 64;
         image = "https://user8.itsindev.com/medibox/pub/media/catalog/product/5/_/5_4.jpg";
         price = "150.0000";
         "sale_price" = "120.0000";
         "short_description" = "15 gm pack 1item";
         sku = Demo17;
         title = "ZEBOR Cream 15gm";
         }
         
         {
         "item_id": 115,
         "sku": "DEMO3",
         "qty": 10,
         "name": "BDIFF A Gel 15gm",
         "price": 321,
         "product_type": "simple",
         "quote_id": "157"
         }
*/
        
        self.cartArray = (UserDefaults.standard.object(forKey: "CartArray")as? NSArray)!
        
        var dictObjCart = NSDictionary();

        for dictObjCart in self.cartArray {
            
                if(((dictObj.value(forKey: "title") as? String)! == ((dictObjCart as AnyObject).value(forKey: "name")as? String)!) && ((dictObj.value(forKey: "sku") as? String)! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String)!)){
                   
                    let qty = (dictObjCart as AnyObject).value(forKey: "qty")as? Int;
                    cellObj.lblProductQty.text = String(qty!);
                    cellObj.btnAdd.isHidden = true;
                    cellObj.cartView.isHidden = false;
                    cellObj.btnPlus.tag = indexPath.row;
                    cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
                    cellObj.btnMinus.tag = indexPath.row;
                    cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
                    }
            
                else {
                
                cellObj.btnLike.setImage(#imageLiteral(resourceName: "heart-inactive"), for: .normal)
                cellObj.lblTabletName.text = (dictObj.value(forKey: "title") as? String)!;
                cellObj.lblSku.text = (dictObj.value(forKey: "sku") as? String)!;
                //        cellObj.lblDescription.text = (dictObj.value(forKey: "short_description") as? String)!;
                cellObj.lblID.text = (dictObj.value(forKey: "id") as? String)!;
                cellObj.lblMRP.text =  "\u{20B9} " + (dictObj.value(forKey: "price") as? String)!;
                
                cellObj.cartView.isHidden = true;
                cellObj.btnAdd.isHidden = false;
                cellObj.btnAdd.tag = indexPath.row;
                cellObj.btnAdd.addTarget(self, action: #selector(btnAddAction(button:)), for: UIControlEvents.touchUpInside);
                cellObj.btnLike.tag = indexPath.row;
                cellObj.btnLike.addTarget(self, action: #selector(btnLikeAction(button:)), for: UIControlEvents.touchUpInside);
                let URLstr =  (dictObj.value(forKey: "image") as? String)!
                let url = URL.init(string: URLstr )
                if url != nil
                {
                    cellObj.imageViewTablet.sd_setImage(with: url! , completed: { (image, error, cacheType, imageURL) in
                        cellObj.imageViewTablet.image = image
                    })
                }
                
            }
            
        }
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0 {
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailAVC)
            self.navigationController?.pushViewController(Controller, animated: true)
        }else{
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailBVC)

            self.navigationController?.pushViewController(Controller, animated: true)
        }
        
    }

    @objc func btnAddAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
            self.product_Id = cell.lblID.text!
            self.sku_id = cell.lblSku.text!
            self.callAPIAddToCart()
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
    }
    
    @objc func btnLikeAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.diabetesTblView)
        let indexPath = self.diabetesTblView.indexPathForRow(at: position)
        let cell:DiabetesCareCell = diabetesTblView.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        if(button.isSelected != true){
            
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
        paraDict =  ["category_id": "38"] as NSMutableDictionary
        
        let urlString = "http://user8.itsindev.com/medibox/API/products.php"
        //        let urlString = BASEURL + "/integration/customer/token"
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
                        print(self.productsListArray)
                        self.diabetesTblView.reloadData();
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
    // MARK: - Get Cart ID API Call
    //--------------------------------
    
    func callAPIGetCartID() {
        
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/carts/mine"
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        kKeyUserCartID = resposeData.result.value as! String;
                        UserDefaults.standard.set(kKeyUserCartID, forKey: "kKeyUserCartID")
                    }
                    else{
                        
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
 
        cartArr = ["quote_id":kKeyUserCartID,"sku":self.sku_id,"qty":"2"]
        paraDict =  ["cart_item": cartArr] as NSMutableDictionary
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/carts/mine/items"
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
        
        let urlString = "http://user8.itsindev.com/medibox/index.php/rest/V1/carts/mine"
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
                        let cartAllArray = (responseDict.value(forKey: "items") as? NSArray)!;
                        
                        UserDefaults.standard.set(cartAllArray, forKey: "CartArray")
                        print(responseDict);
                        self.diabetesTblView.reloadData()
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
