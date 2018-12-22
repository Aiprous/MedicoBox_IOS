//
//  NotificationViewController.swift
//  MedicoBox
//
//  Created by SBC on 01/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource , UISearchBarDelegate {
    var searchBar :UISearchBar?

    @IBOutlet weak var tblNotification: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblNotification.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        tblNotification.estimatedRowHeight = 90
        tblNotification.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblNotification.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblNotification.tableFooterView = footerView
        
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItem(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        
         self.navigationController?.isNavigationBarHidden = false;
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
//        cellObj.textField.text = ""
//        cellObj.textField.placeholder = arrayofText[indexPath.row] as? String
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
