//
//  ProductDetailAViewController.swift
//  MedicoBox
//
//  Created by SBC on 26/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import FSPagerView
import Alamofire
import SVProgressHUD
import SDWebImage

class ProductDetailAViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource , UISearchBarDelegate {
    var searchBar :UISearchBar?
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var FeaturedProductsCollectionView: UICollectionView!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var qtyEditCartView: UIView!
    var imagesArray = NSArray();
    var product_Id = "";
    var sku_id = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self; self.FeaturedProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductsCollectionCellID")
        
        FeaturedProductsCollectionView.dataSource = self
        FeaturedProductsCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;

        self.callAPIGetProductData()
        
        if(kKeyProductQty == ""){
            
            self.btnAddToCart.isEnabled = true;
            self.qtyEditCartView.isHidden = true;
            self.btnAddToCart.alpha = 1;
            
        }else {
            self.lblProductQty.text = kKeyProductQty;
            self.qtyEditCartView.isHidden = false;
            self.btnAddToCart.alpha = 0.8;
            self.btnAddToCart.isEnabled = false;
        }
    }

    @IBAction func ProductDetailAction(_ sender: Any) {

        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDescriptionVC)

        self.navigationController?.pushViewController(Controller, animated: true)
    }
    //MARK:- FSPager Delegate And DataSource
    
    //    var imagesNameArray = NSArray();
    fileprivate var imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        var numberCount:Int = Int()
        
        if(pagerView == firstPagerView){
            
            numberCount = self.imageNames.count
            
        }
        
        return numberCount;
    }
    
    @objc(pagerView:cellForItemAtIndex:) func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellFirst", at: index)
        
      /*  let dictObj = imagesArray.object(at: index) as! NSDictionary

        let URLstr = BASEURL + (dictObj.value(forKey: "file") as? String ?? "")
        let urlimg = URL.init(string: URLstr)
        if urlimg != nil
        {
            cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
                
                cell.imageView?.image = image
            })
        }
        */
        cell.imageView?.image = UIImage(named: imageNames[index]);
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
//        cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
        return cell
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if(pagerView == firstPagerView){
            
            pagerView.deselectItem(at: index, animated: true)
            
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        guard self.firstPageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.firstPageControl.currentPage = pagerView.currentIndex
        
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
            self.firstPageControl.numberOfPages = self.imageNames.count
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
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        numberCount = 8;
        return numberCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
                   // get a reference to our storyboard cell
            let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductsCollectionCellID", for: indexPath as IndexPath) as! FeaturedProductCollectionViewCell
                        
            return cellObj;

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//            let cell = collectionView.cellForItem(at: indexPath) as! FeaturedProductCollectionViewCell
//
//            let Controller = self.storyboard?.instantiateViewController(withIdentifier: PRODUCT_DESC_VCID)
//            self.navigationController?.pushViewController(Controller!, animated: true)
        
    }
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
     {
     return 10
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
     {
     let sectionInset = UIEdgeInsetsMake(kScreenHeight > 568 ? 20 : 0, 0, 0, 0)
     return sectionInset
     }
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        var value:CGSize = CGSize()
        /*
             if(kScreenWidth > 320) {
             
             value = CGSize(width: kScreenWidth / 2 - 1,  height: (kScreenHeight-(kScreenHeight > 568 ? 380 : 350)) / 2)
             
             }else{
             
             value = CGSize(width: kScreenWidth / 2 + 23 ,  height: (kScreenHeight-(kScreenHeight > 568 ? 350 : 340)) / 2)
             
             }
             */
            
         if(collectionView == FeaturedProductsCollectionView)
        {
            value = CGSize(width: 204, height: 300)
        }
        
        return value;
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
        
        self.qtyEditCartView.isHidden = false;
        self.lblProductQty.text = "1";
//        self.btnMinus.isEnabled = false;
        callAPIAddToCart()
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
                        self.qtyEditCartView.isHidden = false;
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

        let urlString =  BASEURL + "/index.php/rest/V1/products/id/" + kKeyProductID
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
                        
                        self.lblName.text = responseDict.value(forKey: "name")as? String ?? ""
                        self.sku_id = responseDict.value(forKey: "sku")as? String ?? ""
                        self.imagesArray =  responseDict.value(forKey: "media_gallery_entries")as? NSArray ?? []
                        self.firstPagerView.reloadData()

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
        let urlString = kKeyEditCartAPI + kKeyProductItemID
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
