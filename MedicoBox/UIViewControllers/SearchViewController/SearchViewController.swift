//
//  SearchViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 05/12/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblSearchView: UITableView!
    
     var searchingArray = NSArray();
     var isSeaching = false
    var productSearchArray = NSArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchBar.delegate = self;
        tblSearchView.delegate = self
        tblSearchView.dataSource = self
        tblSearchView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }
    //MARK: - tableview datasource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if  isSeaching {
        return productSearchArray.count
            
        }else{
           return searchingArray.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "cell")
        var dictObj : NSDictionary?
        if isSeaching {
            dictObj = productSearchArray.object(at: indexPath.row) as? NSDictionary
        }else{
            dictObj = searchingArray.object(at: indexPath.row) as? NSDictionary
        }
        
     
        cell.textLabel?.text = dictObj?.value(forKey: "title") as? String
        cell.selectionStyle = .none
        
        return cell
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 47
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         var dictObj : NSDictionary?
        if isSeaching {
            dictObj = productSearchArray.object(at: indexPath.row) as? NSDictionary
        }else{
            dictObj = searchingArray.object(at: indexPath.row) as? NSDictionary
        }
        kKeyProductID = dictObj?.value(forKey: "id") as! String
//        kKeyProductQty = ProductQty;
//        kKeyProductItemID = dictObj?.value(forKey: <#T##String#>)
        
        kKeySkuID =  dictObj?.value(forKey: "sku") as! String
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailBVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
//        let cell:SearchListTableViewCell = tableView.cellForRow(at: indexPath) as! SearchListTableViewCell
//
//        SELECTED_NAME = cell.lblNameSearchList.text!
//        SELECTED_IMAGE_URL = cell.lblImageUrlSearchList.text!
//
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailServiceCategoryVCID")as! DetailServiceCategoryViewController
//        self.navigationController?.pushViewController(controller, animated: false)
//
    }
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       if searchBar.text == nil || searchBar.text == "" {
            
            isSeaching = false
//            view.endEditing(true)
            tblSearchView.reloadData()
            
        }else {
            
            isSeaching = true
            self.tblSearchView.isHidden = false
            callAPI_getSearchByName()
    productSearchArray = searchingArray.filter({ (text) -> Bool in
                let tmpDict: NSDictionary = text as! NSDictionary
                let tmp:NSString = (tmpDict.value(forKey: "title") as? NSString)!
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            }) as NSArray
            
            tblSearchView.reloadData()
            //            filter({($0["Name"] as? String) == searchBar.text})
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        isSeaching = true;
        self.tblSearchView.isHidden = false
//        textFieldActive()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
//        isSeaching = false;
        callAPI_getSearchByName()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSeaching = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isSeaching = false;
//        textFieldActive()
    }
    @IBAction func btnBackAction(_ sender: Any) {
//        self.navigationController ?.popViewController(animated: true);
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Get Search By Name Items Data List API call
    func callAPI_getSearchByName() {
        
        let urlString = "http://user8.itsindev.com/medibox/API/filter-product.php"
        
        let params = ["name":self.searchBar.text!];//API_TOKEN];
        
        print(urlString,params)
//        SVProgressHUD.show()
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
//                SVProgressHUD.dismiss()
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
//                        print(responseDict);
//                        self.TblSearchList.isHidden = false
                        self.searchingArray = responseDict.value(forKey: "response")as! NSArray
//
                        self.tblSearchView.reloadData();
                        
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message") as! String );
                    }
                }
            })
        }
    }
    
}
