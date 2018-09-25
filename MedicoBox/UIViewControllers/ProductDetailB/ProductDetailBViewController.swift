//
//  ProductDetailBViewController.swift
//  MedicoBox
//
//  Created by SBC on 24/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import FSPagerView

class ProductDetailBViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, FSPagerViewDelegate, FSPagerViewDataSource {
    
    @IBOutlet weak var prodTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prodTblView.register(UINib(nibName: "ProductDetailBTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailBTableViewCell")
        prodTblView.estimatedRowHeight = 62
        prodTblView.separatorStyle = .none
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
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
        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
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
    
}
