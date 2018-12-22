//
//  CategoryViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 05/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tblCategoryView: UITableView!
    var searchBar : UISearchBar?
    var cartegoryArray = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false;
        
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        
        // Do any additional setup after loading the view.
        tblCategoryView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        tblCategoryView.estimatedRowHeight = 130
        tblCategoryView.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblCategoryView.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblCategoryView.tableFooterView = footerView
        tblCategoryView.delegate = self;
        tblCategoryView.dataSource = self
        //call category api
        self.callAPIGetCategoryList()
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
        return self.cartegoryArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
        let dictObj = self.cartegoryArray.object(at: indexPath.row) as! NSDictionary
        cellObj.lblCategoryName.text = (dictObj.value(forKey: "categoryName") as? String ?? "")!;
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictObj = self.cartegoryArray.object(at: indexPath.row) as! NSDictionary
        if dictObj.value(forKey: "SubCategory") != nil {
            let controllerObj = kMainStoryboard.instantiateViewController(withIdentifier: kSubCategoryVC) as! SubCategoryViewController
            controllerObj.subCategoryArray = dictObj.value(forKey: "SubCategory") as? Array
        self.navigationController?.pushViewController(controllerObj, animated: true)
        }else{
            let controllerObj = kMainStoryboard.instantiateViewController(withIdentifier: kDiabetesCareListVC) as! DiabetesCareList
            controllerObj.category_id = dictObj.value(forKey: "CategoryId") as? NSString
            self.navigationController?.pushViewController(controllerObj, animated: true)
        }
    }
    

    //--------------------------------
    // MARK: - Product List API Call
    //--------------------------------
    
    func callAPIGetCategoryList() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["category_id": "38"] as NSMutableDictionary
//        http://user8.itsindev.com/medibox/API/categories_new.php
        
        let urlString = BASEURL + "/API/categories_new.php"
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
                        
                        self.cartegoryArray = (responseDict.value(forKey: "response") as? NSArray ?? [])!;
//                        print(self.productsListArray)
                        self.tblCategoryView.reloadData();
                         self.navigationController?.isNavigationBarHidden = false;
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
}
