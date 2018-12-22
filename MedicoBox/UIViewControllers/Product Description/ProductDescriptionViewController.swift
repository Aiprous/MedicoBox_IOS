//
//  ProductDescriptionViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

class ProductDescriptionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var tblProductDesc: UITableView!
    @IBOutlet weak var FeaturedProductsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self; self.FeaturedProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductsCollectionCellID")
        
        FeaturedProductsCollectionView.dataSource = self
        FeaturedProductsCollectionView.delegate = self
        tblProductDesc.delegate = self
        tblProductDesc.dataSource = self
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblProductDesc.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblProductDesc.tableFooterView = footerView
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
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        if(collectionView == FeaturedProductsCollectionView)
        {
            numberCount = 8;
            
        }
        return numberCount;
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
        if(collectionView == FeaturedProductsCollectionView)
        {
            // get a reference to our storyboard cell
            let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductsCollectionCellID", for: indexPath as IndexPath) as! FeaturedProductCollectionViewCell
            
            
            return cellObj;
        }
        return CommomCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == FeaturedProductsCollectionView)
        {
            let cell = collectionView.cellForItem(at: indexPath) as! FeaturedProductCollectionViewCell
            
            
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var value:CGSize = CGSize()
        if(collectionView == FeaturedProductsCollectionView)
        {
            value = CGSize(width: 204, height: 327)
        }
        
        return value;
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTblViewCellID") as! ProductDescriptionTableViewCell
        
        if(indexPath.row == 0){
            
            cellObj.lblProductionTitle.text = "FORMULATION";
            cellObj.lblProductionSubTitle.text = "Balm";
            
        }else if(indexPath.row == 1){
            
            cellObj.lblProductionTitle.text = "MANUFACTURER";
            cellObj.lblProductionSubTitle.text = "false";
            
        }else if(indexPath.row == 2){
            
            cellObj.lblProductionTitle.text = "PACKAGING";
            cellObj.lblProductionSubTitle.text = "Bottle";
            
        }else if(indexPath.row == 3){
            
            cellObj.lblProductionTitle.text = "SIZE";
            cellObj.lblProductionSubTitle.text = "NA";
            
        }else if(indexPath.row == 4){
            
            cellObj.lblProductionTitle.text = "DIRECTION";
            cellObj.lblProductionSubTitle.text = "NA";
            
        }
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 47
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:ProductDescriptionTableViewCell = tableView.cellForRow(at: indexPath) as! ProductDescriptionTableViewCell
        
        
        
    }
}
