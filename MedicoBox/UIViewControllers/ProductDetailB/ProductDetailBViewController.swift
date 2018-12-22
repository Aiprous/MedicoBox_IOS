//
//  ProductDetailBViewController.swift
//  MedicoBox
//
//  Created by SBC on 24/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import FSPagerView
import FSPagerView
import Alamofire
import SVProgressHUD
import SDWebImage

class ProductDetailBViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, FSPagerViewDelegate, FSPagerViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblPricePerTabletSR: UILabel!
    @IBOutlet weak var lblPrescriptionRequired: UILabel!
    @IBOutlet weak var imgLogoRequired: UIImageView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var btnAddToCart: DesignableButton!
    //    @IBOutlet weak var qtyEditCartView: UIView!
    @IBOutlet weak var prodTblView: UITableView!
    @IBOutlet weak var imgPagerProduct: UIImageView!
    
    @IBOutlet weak var imgAlertBackView: UIView!
    var imagesArray = NSArray();
    var product_Id = "";
    var sku_id = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prodTblView.register(UINib(nibName: "ProductDetailBTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailBTableViewCell")
        prodTblView.estimatedRowHeight = 62
        prodTblView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: prodTblView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        prodTblView.tableFooterView = footerView
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        self.callAPIGetProductData()
        self.imgAlertBackView.isHidden = true;
        self.navigationController?.isNavigationBarHidden = false
        if(kKeyProductQty == ""){
            
            self.btnAddToCart.isEnabled = true;
            //            self.qtyEditCartView.isHidden = true;
            self.btnPlus.isHidden = true;
            self.btnMinus.isHidden = true;
            self.lblProductQty.isHidden = true;
            self.btnAddToCart.alpha = 1;
            
        }else {
            
            self.lblProductQty.text = kKeyProductQty;
            self.btnPlus.isHidden = false;
            self.btnMinus.isHidden = false;
            self.lblProductQty.isHidden = false;
            //            self.qtyEditCartView.isHidden = false;
            self.btnAddToCart.alpha = 0.8;
            self.btnAddToCart.isEnabled = false;
            
        }
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
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBTableViewCell") as! ProductDetailBTableViewCell
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    //MARK:- FSPager Delegate And DataSource
    
    //    var imagesNameArray = NSArray();
    //    fileprivate var imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        var numberCount:Int = Int()
        
        if(pagerView == firstPagerView){
            
            numberCount = self.imagesArray.count
            
        }
        
        return numberCount;
    }
    
    @objc(pagerView:cellForItemAtIndex:) func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellFirst", at: index)
        /*
         let dictObj = imagesArray.object(at: index) as! NSDictionary
         
         let URLstr = BASEURL + (dictObj.value(forKey: "file") as? String ?? "")
         let urlimg = URL.init(string: URLstr)
         if urlimg != nil
         {
         cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
         
         cell.imageView?.image = image
         })
         }
         */
        let URLstr = self.imagesArray[index] as! String
        let urlimg = URL.init(string: URLstr)
        if urlimg != nil
        {
            cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
                
                cell.imageView?.image = image
            })
        }
        
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //        cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
        return cell
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if(pagerView == firstPagerView){
            
            pagerView.deselectItem(at: index, animated: true)
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
            pagerView.addGestureRecognizer(tap)
            //            self.view.addSubview(pagerView)
        }
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool{
        return true;
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        guard self.firstPageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.firstPageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
        
        
    }
    
    @IBOutlet weak var firstPagerView: FSPagerView!
        {
        didSet {
            self.firstPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellFirst")
        }
    }
    
    @IBOutlet weak var firstPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imagesArray.count
            //            self.pageControl.contentHorizontalAlignment = .center
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setStrokeColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(UIColor.darkGray, for: .selected)
            
        }
    }
    
    
    fileprivate var styleIndex = 0 {
        
        didSet {
            // Clean up
            self.firstPageControl.setStrokeColor(UIColor.lightGray, for: .normal)
            self.firstPageControl.setStrokeColor(UIColor.lightGray, for: .selected)
            self.firstPageControl.setFillColor(nil, for: .normal)
            self.firstPageControl.setFillColor(nil, for: .selected)
            self.firstPageControl.setImage(nil, for: .normal)
            self.firstPageControl.setImage(nil, for: .selected)
            self.firstPageControl.setPath(nil, for: .normal)
            self.firstPageControl.setPath(nil, for: .selected)
            
            switch self.styleIndex {
            case 0:
                // Default
                // Automatic Sliding
                
                break
            case 1:
                // Ring
                self.firstPageControl.setStrokeColor(.green, for: .normal)
                self.firstPageControl.setStrokeColor(.green, for: .selected)
                self.firstPageControl.setFillColor(.green, for: .selected)
                
            case 2:
                // Image
                self.firstPageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.firstPageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
                
            default:
                break
            }
            self.firstPagerView.reloadData()
        }
    }
    
    @IBAction func btnPlusAction(_ sender: Any) {
        
        var i = Int()
        i = Int(self.lblProductQty.text!)!
        i = i + 1;
        self.lblProductQty.text = String(i);
        self.callAPIEditCart()
    }
    
    @IBAction func btnMinusAction(_ sender: Any) {
        
        var i = Int()
        i = Int(self.lblProductQty.text!)!
        
        if( i > 1 ){
            
            i = i - 1;
            self.btnMinus.isEnabled = true;
            self.lblProductQty.text = String(i);
            
        }else {
            
            i = 1
            self.btnMinus.isEnabled = false;
            self.lblProductQty.text = String(i);
            
        }
        
        self.callAPIEditCart()
        
    }
    
    @IBAction func btnAddToCartAction(_ sender: Any) {
        
        self.btnPlus.isHidden = false;
        self.btnMinus.isHidden = false;
        self.lblProductQty.isHidden = false;
        //        self.qtyEditCartView.isHidden = false;
        self.lblProductQty.text = "1";
        callAPIAddToCart()
    }
    
    
    @IBAction func btnDrugInformationAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDrugInfoVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    
    // Product Image Zoom In Zoom Out
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        //        let pagerView = sender.view as! FSPagerView
        //        self.imgPagerProduct = pagerView.
        imgPagerProduct.contentMode = .scaleAspectFit
        imgPagerProduct.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imgPagerProduct.addGestureRecognizer(tap)
        self.view.addSubview(imgPagerProduct)
        self.imgAlertBackView.isHidden = false;
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        
        self.imgAlertBackView.isHidden = true;
        
    }
    
    
    //--------------------------------
    // MARK: - Add To Cart  API Call
    //--------------------------------
    
    func callAPIAddToCart() {
        
        var paraDict = NSMutableDictionary()
        var cartArr = NSDictionary()
        
        cartArr = ["quote_id":kKeyUserCartID,"sku":self.sku_id,"qty":self.lblProductQty.text!]
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
                        print(responseDict);
                        
                        kKeyProductItemID = String(responseDict.value(forKey: "item_id")as? Int ?? 0)
                        //                        self.lblProductQty.text = kKeyProductQty;
                        //                        self.qtyEditCartView.isHidden = false;
                        self.btnPlus.isHidden = false;
                        self.btnMinus.isHidden = false;
                        self.lblProductQty.isHidden = false;
                        self.btnAddToCart.alpha = 0.8;
                        self.btnAddToCart.isEnabled = false;
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
    
    //--------------------------------------
    // MARK: - Get Product Data API Call
    //--------------------------------------
    
    func callAPIGetProductData() {
        
        let urlString =  kKeyGetProductDetailBData + kKeyProductID
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
                        
                        print(responseDict);
                        
                        self.lblName.text = responseDict.value(forKey: "title")as? String ?? ""
                        self.lblDesc.text = responseDict.value(forKey: "short_description")as? String ?? ""
                        self.lblDesc.underline();
                        self.lblCompanyName.text = responseDict.value(forKey: "company_name")as? String ?? ""
                        self.lblPrice.text =  "\u{20B9} " + (responseDict.value(forKey: "price")as? String ?? "")
                        let prescription_required = responseDict.value(forKey: "prescription_required")as? String ?? ""
                        self.sku_id = kKeySkuID;
                        self.imagesArray =  responseDict.value(forKey: "images")as? NSArray ?? []
                        
                        if(prescription_required == "0"){
                            
                            self.lblPrescriptionRequired.isHidden = true;
                            self.imgLogoRequired.isHidden = true;
                            
                        }else {
                            
                            self.lblPrescriptionRequired.isHidden = false;
                            self.imgLogoRequired.isHidden = false;
                            
                        }
                        if self.imagesArray.count > 0 {
                            self.firstPagerView.delegate = self
                            self.firstPagerView.dataSource = self;
                            self.firstPageControl.numberOfPages = self.imagesArray.count
                            self.firstPageControl.setStrokeColor(.gray, for: .normal)
                            self.firstPageControl.setFillColor(UIColor.darkGray, for: .selected)
                            self.firstPagerView.reloadData()
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
        cartArr = ["quote_id":kKeyUserCartID,"item_id":kKeyProductItemID,"qty":self.lblProductQty.text!]
        paraDict =  ["cart_item": cartArr] as NSMutableDictionary
        let urlString =  kKeyEditCartAPI + kKeyProductItemID
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
