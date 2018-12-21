 //
 //  MyOrdersViewController.swift
 //  MedicoBox
 //
 //  Created by NCORD LLP on 25/09/18.
 //  Copyright © 2018 Aiprous. All rights reserved.
 //
 
 import UIKit
 import Alamofire
 import SVProgressHUD
 
 class MyOrdersViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tblMyOrders: UITableView!
    @IBOutlet weak var myOrdersSearchBar: UISearchBar!
    var wishListArray: NSArray?
     var searchBar : UISearchBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItem(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.addTitleSearchBar(searchBar1: searchBar!)
        self.searchBar?.delegate = self;
        
        self.navigationController?.isNavigationBarHidden = false;
        /// Search Bar Design Style
        
        if let textfield = myOrdersSearchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 20
                backgroundview.clipsToBounds = true
            }
        }
        
        self.tblMyOrders.register(UINib(nibName: "MyOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "MyOrdersTableViewCell")
        tblMyOrders.delegate = self
        tblMyOrders.dataSource = self
        tblMyOrders.estimatedRowHeight = 130
        tblMyOrders.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblMyOrders.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblMyOrders.tableFooterView = footerView
        self.getOrderListAPI()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell") as! MyOrdersTableViewCell
        
        cellObj.lblOrderPrice.text = "\u{20B9}" + " 278.00"
        
        if(indexPath.row == 0){
            
            cellObj.lblOrderStatus.text = "Intransit"
            cellObj.lblOrderStatus.textColor = #colorLiteral(red: 1, green: 0.7803921569, blue: 0, alpha: 1)
        }
        else if(indexPath.row == 1){
            
            cellObj.lblOrderStatus.text = "Delivered"
            cellObj.lblOrderStatus.textColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.2470588235, alpha: 1)
            
        }
        else if(indexPath.row == 2){
            
            cellObj.lblOrderStatus.text = "Cancelled"
            cellObj.lblOrderStatus.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 115
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:MyOrdersTableViewCell = tableView.cellForRow(at: indexPath) as! MyOrdersTableViewCell
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kMyOrdersDetailsVC)
        self.navigationController?.pushViewController(Controller!, animated: true)
        
    }
    
    //--------------------------------
    // MARK: - Product List API Call
    //--------------------------------
    
    func getOrderListAPI() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["token": "38"] as NSMutableDictionary
        //        http://user8.itsindev.com/medibox/API/categories_new.php
        
        let urlString = BASEURL + "/API/user_orders.php"
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                       
//                        self.cartegoryArray = (responseDict.value(forKey: "response") as? NSArray ?? [])!;
//                        //                        print(self.productsListArray)
                        self.tblMyOrders.reloadData();
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
 }

