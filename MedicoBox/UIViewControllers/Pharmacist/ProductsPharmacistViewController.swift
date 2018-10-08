//
//  ProductsPharmacistViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class ProductsPharmacistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblProductsPharmacist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false;
        
        self.tblProductsPharmacist.register(UINib(nibName: "ProductsPharmacistTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductsPharmacistTableViewCell")
        tblProductsPharmacist.delegate = self
        tblProductsPharmacist.dataSource = self
        tblProductsPharmacist.estimatedRowHeight = 130
        tblProductsPharmacist.separatorStyle = .none
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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "ProductsPharmacistTableViewCell") as! ProductsPharmacistTableViewCell
        
        cellObj.lblProductPrice.text = "\u{20B9}" + " 200.00"
        cellObj.btnProductDelete.tag = indexPath.row;
        cellObj.btnProductDelete.addTarget(self, action: #selector(btnProductDeleteAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnProductEdit.tag = indexPath.row;
        cellObj.btnProductEdit.addTarget(self, action: #selector(btnProductEditAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 209
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:ProductsPharmacistTableViewCell = tableView.cellForRow(at: indexPath) as! ProductsPharmacistTableViewCell
        
        
        
    }
   
    @objc func btnProductDeleteAction(button: UIButton) {
        
        let alert = UIAlertController(title: "Delete",
                                      message: "Do you want to delete??",
                                      preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default, handler: nil)
        
        let deleteAction = UIAlertAction.init(title: "Delete", style: .default, handler: { (action) in
            
//            let controller = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kProductsPharmacistVC)
//            self.present(controller, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelAction);
        alert.addAction(deleteAction);
        self.present(alert, animated: true, completion: nil)
      
    }
    
    @objc func btnProductEditAction(button: UIButton) {
        
        
    }
    
    @IBAction func btnFilterAction(_ sender: Any) {
        
        let Controller = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kTransationDetailVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
}
