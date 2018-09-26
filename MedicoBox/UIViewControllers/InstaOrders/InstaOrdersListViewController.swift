//
//  InstaOrdersListViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 24/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class InstaOrdersListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblInstaOrdersList: UITableView!
    @IBOutlet weak var newInstaListView: DesignableView!
    @IBOutlet weak var productInfoView: DesignableView!
    @IBOutlet weak var btnBackView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBackView.isHidden = true;
        self.newInstaListView.isHidden = true;
        self.productInfoView.isHidden = true;
        self.navigationController?.isNavigationBarHidden = false;
        self.tblInstaOrdersList.register(UINib(nibName: "InstaOrdersListTableViewCell", bundle: nil), forCellReuseIdentifier: "InstaOrdersListTblViewCellID")
        tblInstaOrdersList.delegate = self
        tblInstaOrdersList.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()        
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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "InstaOrdersListTblViewCellID") as! InstaOrdersListTableViewCell
        
        if(indexPath.row == 0){
            
            cellObj.lblInstaOrderTitle.text = "Diabetes";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            
        }else if(indexPath.row == 1){
            
            cellObj.lblInstaOrderTitle.text = "Monthly";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            
        }else if(indexPath.row == 2){
            
            cellObj.lblInstaOrderTitle.text = "Priyanka";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            
        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 131
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:InstaOrdersListTableViewCell = tableView.cellForRow(at: indexPath) as! InstaOrdersListTableViewCell
        cell.optionView.isHidden = false;
        //        self.productInfoView.isHidden = false;
        
        
    }
    @objc func btnOptionAction(button: UIButton) {
        
        self.btnBackView.isHidden = false;
        self.productInfoView.isHidden = false;
        self.newInstaListView.isHidden = true;

        
    }
    
    @IBAction func btnNewInstaListAction(_ sender: Any) {
        
        self.btnBackView.isHidden = false;
        self.newInstaListView.isHidden = false;
        self.productInfoView.isHidden = true;

        
        
    }
    @IBAction func btnBackViewAction(_ sender: Any) {
        
        self.btnBackView.isHidden = true;
        self.newInstaListView.isHidden = true;
        self.productInfoView.isHidden = true;
        
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        
        self.btnBackView.isHidden = true;
        self.newInstaListView.isHidden = true;
        self.productInfoView.isHidden = true;
        
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        self.btnBackView.isHidden = true;
        self.newInstaListView.isHidden = true;
        self.productInfoView.isHidden = true;

        let Controller = self.storyboard?.instantiateViewController(withIdentifier: INSTA_ORDER_ADD_VCID)
        self.navigationController?.pushViewController(Controller!, animated: true)
    }
    @IBAction func btnOkAction(_ sender: Any) {
        
        self.btnBackView.isHidden = true;
        self.productInfoView.isHidden = true;
        self.newInstaListView.isHidden = true;

    }
}
