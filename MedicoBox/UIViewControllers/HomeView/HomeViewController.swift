//
//  HomeViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FSPagerView
import Alamofire
import SVProgressHUD
import SDWebImage

class HomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, FSPagerViewDataSource,FSPagerViewDelegate{
    
    @IBOutlet weak var medicoSearchBar: UISearchBar!
    @IBOutlet weak var MedicoCollectionView: UICollectionView!
    @IBOutlet weak var FeaturedProductsCollectionView: UICollectionView!
    @IBOutlet weak var orderView: UIView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        /// Search Bar Design Style
        if let textfield = medicoSearchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 20
                backgroundview.clipsToBounds = true
            }
        }
        
        //Collection View Add delegate and view Design
        self.MedicoCollectionView.register(UINib(nibName: "MedicoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MedicoCollectionCellID")
        /*
        screenSize = UIScreen.main.bounds
        screenWidth = (screenSize.width-20)
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        MedicoCollectionView!.collectionViewLayout = layout
        */
        MedicoCollectionView.dataSource = self
        MedicoCollectionView.delegate = self
        
        self.FeaturedProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductsCollectionCellID")
        
        FeaturedProductsCollectionView.dataSource = self
        FeaturedProductsCollectionView.delegate = self
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        if(collectionView == MedicoCollectionView)
        {
            numberCount = 4;
            
        }
        else if(collectionView == FeaturedProductsCollectionView)
        {
            numberCount = 8;

        }
        return numberCount;
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
        if(collectionView == MedicoCollectionView)
        {
            // get a reference to our storyboard cell
            let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicoCollectionCellID", for: indexPath as IndexPath) as! MedicoCollectionViewCell
            
            if(indexPath.row == 0){
                
                cellObj.lblTitleMedico.text = "MEDICINES";
                cellObj.lblSubTitleMedico.text = "1,00,000+ Medicines";
                cellObj.imgMedico.image = #imageLiteral(resourceName: "capsules")
                
            }else if(indexPath.row == 1){
                
                cellObj.lblTitleMedico.text = "LAB TESTS";
                cellObj.lblSubTitleMedico.text = "Free Sample Collection";
                cellObj.imgMedico.image = #imageLiteral(resourceName: "test-tubes")

                
            }else if(indexPath.row == 2){
                
                cellObj.lblTitleMedico.text = "INSTA ORDERS";
                cellObj.lblSubTitleMedico.text = "65,000+ Products";
                cellObj.imgMedico.image = #imageLiteral(resourceName: "cardboxes")

                
            }else if(indexPath.row == 3){
                
                cellObj.lblTitleMedico.text = "E-CONSULTATION";
                cellObj.lblSubTitleMedico.text = "Chat for Free";
                cellObj.imgMedico.image = #imageLiteral(resourceName: "doctor")

                
            }
            
            return cellObj;
            
        }
        else if(collectionView == FeaturedProductsCollectionView)
        {
            // get a reference to our storyboard cell
            let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductsCollectionCellID", for: indexPath as IndexPath) as! FeaturedProductCollectionViewCell
            
            
            return cellObj;
        }
    
    return CommomCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == MedicoCollectionView)
        {
            let cell = collectionView.cellForItem(at: indexPath) as! MedicoCollectionViewCell
            
            if(cell.lblTitleMedico.text == "INSTA ORDERS"){
                
                let Controller = self.storyboard?.instantiateViewController(withIdentifier: INSTA_ORDERS_LIST_VCID)
                self.navigationController?.pushViewController(Controller!, animated: true)
                
            }else {
                
                let Controller = self.storyboard?.instantiateViewController(withIdentifier: PRODUCT_DESC_VCID)
                self.navigationController?.pushViewController(Controller!, animated: true)
            }
            
        }
        else if(collectionView == FeaturedProductsCollectionView)
        {
            let cell = collectionView.cellForItem(at: indexPath) as! FeaturedProductCollectionViewCell

        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var value:CGSize = CGSize()
        if(collectionView == MedicoCollectionView)
        {
            value = CGSize(width: 210, height: 168);
//CGSize(width: screenWidth/3, height: self.orderView.frame.size.height/3);
            
        } else if(collectionView == FeaturedProductsCollectionView)
        {
            value = CGSize(width: 204, height: 327)
        }
    
        return value;
    }
    
    //MARK:- FSPager Delegate And DataSource
    
//    var imagesNameArray = NSArray();
        fileprivate var imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        var numberCount:Int = Int()
        
        if(pagerView == firstPagerView){
            
            numberCount = self.imageNames.count
            
        }else{
            
           numberCount = self.imageNames.count
        }
        
        return numberCount;
    }
    
    @objc(pagerView:cellForItemAtIndex:) func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let CELL:FSPagerViewCell = FSPagerViewCell()
        
        if(pagerView == firstPagerView){
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellFirst", at: index)
            
          /*  let dictObj = self.imagesNameArray[index] as! NSDictionary
            
            let URLstr = BASEURL + "/" + (dictObj.value(forKey: "file_name") as? String)!
            
            let urlimg = URL.init(string: URLstr)
            if urlimg != nil
            {
                cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
             
                    cell.imageView?.image = image
                })
            }
            */
            cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
            return cell
            
        }else{
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellSecond", at: index)
            
            /*  let dictObj = self.imagesNameArray[index] as! NSDictionary
             
             let URLstr = BASEURL + "/" + (dictObj.value(forKey: "file_name") as? String)!
             
             let urlimg = URL.init(string: URLstr)
             if urlimg != nil
             {
             cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
             
             cell.imageView?.image = image
             })
             }
             */
            cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
            return cell

        }
        return CELL;

    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if(pagerView == firstPagerView){

            pagerView.deselectItem(at: index, animated: true)
            
        }else{
            
            pagerView.deselectItem(at: index, animated: true)
            
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        if(pagerView == firstPagerView){
            
            guard self.firstPageControl.currentPage != pagerView.currentIndex else {
                return
            }
            self.firstPageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
            
        }else{
            
            guard self.secondPageControl.currentPage != pagerView.currentIndex else {
                return
            }
            self.secondPageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
        }
    }
    
    
   
   @IBOutlet weak var firstPagerView: FSPagerView!
        {
        didSet {
            self.firstPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellFirst")
        }
        
    }
    
    @IBOutlet weak var secondPagerView: FSPagerView!
        {
        didSet {
            self.secondPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellSecond")
        }
        
    }
    
     @IBOutlet weak var firstPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imageNames.count
            //            self.pageControl.contentHorizontalAlignment = .center
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setFillColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(.white, for: .selected)
            
        }
    }
    
    @IBOutlet weak var secondPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imageNames.count
            //            self.pageControl.contentHorizontalAlignment = .center
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setFillColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(.white, for: .selected)
            
        }
    }
    
    fileprivate var styleIndex = 0 {
        
        didSet {
            // Clean up
            self.firstPageControl.setStrokeColor(nil, for: .normal)
            self.firstPageControl.setStrokeColor(nil, for: .selected)
            self.firstPageControl.setFillColor(nil, for: .normal)
            self.firstPageControl.setFillColor(nil, for: .selected)
            self.firstPageControl.setImage(nil, for: .normal)
            self.firstPageControl.setImage(nil, for: .selected)
            self.firstPageControl.setPath(nil, for: .normal)
            self.firstPageControl.setPath(nil, for: .selected)
            
            self.secondPageControl.setStrokeColor(nil, for: .normal)
            self.secondPageControl.setStrokeColor(nil, for: .selected)
            self.secondPageControl.setFillColor(nil, for: .normal)
            self.secondPageControl.setFillColor(nil, for: .selected)
            self.secondPageControl.setImage(nil, for: .normal)
            self.secondPageControl.setImage(nil, for: .selected)
            self.secondPageControl.setPath(nil, for: .normal)
            self.secondPageControl.setPath(nil, for: .selected)
            
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
                self.secondPageControl.setStrokeColor(.green, for: .normal)
                self.secondPageControl.setStrokeColor(.green, for: .selected)
                self.secondPageControl.setFillColor(.green, for: .selected)
                
            case 2:
                // Image
                self.firstPageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.firstPageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
                self.secondPageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.secondPageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
                
            default:
                break
            }
            
            self.firstPagerView.reloadData()
            self.secondPagerView.reloadData()

        }
        
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {

        self.toggleLeft()
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
}
