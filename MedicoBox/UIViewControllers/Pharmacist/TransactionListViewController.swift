//
//  TransactionListViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblTransactionList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false;

        self.tblTransactionList.register(UINib(nibName: "TransactionListTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionListTableViewCell")
        tblTransactionList.delegate = self
        tblTransactionList.dataSource = self
        tblTransactionList.estimatedRowHeight = 130
        tblTransactionList.separatorStyle = .none
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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "TransactionListTableViewCell") as! TransactionListTableViewCell
        
        cellObj.lblTransactionAmount.text = "\u{20B9}" + " 200.00"
        
        cellObj.btnTransViewDetails.tag = indexPath.row;
        cellObj.btnTransViewDetails.addTarget(self, action: #selector(btnTransViewDetailsAction(button:)), for: UIControlEvents.touchUpInside);
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 144
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:TransactionListTableViewCell = tableView.cellForRow(at: indexPath) as! TransactionListTableViewCell
        
       
        
    }
    
    
    @objc func btnTransViewDetailsAction(button: UIButton) {
        
        let Controller = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kTransationDetailVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    

}
