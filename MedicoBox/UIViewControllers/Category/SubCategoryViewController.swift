//
//  SubCategoryViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 05/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tblSubCategory: UITableView!
    var subCategoryArray : Array<Any>?
    var searchBar : UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;       
        
        // Do any additional setup after loading the view.
        tblSubCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        
        tblSubCategory.estimatedRowHeight = 130
        tblSubCategory.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblSubCategory.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblSubCategory.tableFooterView = footerView
        tblSubCategory.delegate = self
        tblSubCategory.dataSource = self
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
        //        self.callAPIGetCartData()
        //        self.callAPIGetProductsList()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return subCategoryArray?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        let dictObj = self.subCategoryArray![indexPath.row] as! NSDictionary
        cellObj.lblCategoryName.text = (dictObj.value(forKey: "categoryName") as? String ?? "")!;
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let dictObj = self.subCategoryArray![indexPath.row] as! NSDictionary
        let controllerObj = kMainStoryboard.instantiateViewController(withIdentifier: kDiabetesCareListVC)as! DiabetesCareList
        controllerObj.category_id = dictObj.value(forKey: "CategoryId") as? NSString
        self.navigationController?.pushViewController(controllerObj, animated: true)
        
        /*   let cell:DiabetesCareCell = tableView.cellForRow(at: indexPath) as! DiabetesCareCell
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
         */
    }
    
    
}
