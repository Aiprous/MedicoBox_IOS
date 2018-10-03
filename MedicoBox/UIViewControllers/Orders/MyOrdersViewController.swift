 //
 //  MyOrdersViewController.swift
 //  MedicoBox
 //
 //  Created by NCORD LLP on 25/09/18.
 //  Copyright © 2018 Aiprous. All rights reserved.
 //
 
 import UIKit
 
 class MyOrdersViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblMyOrders: UITableView!
    @IBOutlet weak var myOrdersSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
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
        
        
    }
    
    
 }

