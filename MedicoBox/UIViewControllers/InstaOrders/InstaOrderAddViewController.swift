//
//  InstaOrderAddViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 25/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class InstaOrderAddViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblInstaOrderAdd: UITableView!
    @IBOutlet weak var instaOrderAddSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false;
        
        /// Search Bar Design Style
        if let textfield = instaOrderAddSearchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 20
                backgroundview.clipsToBounds = true
            }
        }
        
        self.tblInstaOrderAdd.register(UINib(nibName: "DiabetesCareCell", bundle: nil), forCellReuseIdentifier: "DiabetesCareCell")
        tblInstaOrderAdd.delegate = self
        tblInstaOrderAdd.dataSource = self
        tblInstaOrderAdd.estimatedRowHeight = 130
        tblInstaOrderAdd.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblInstaOrderAdd.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblInstaOrderAdd.tableFooterView = footerView
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
        self.setNavigationBarItemBackButton()        
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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DiabetesCareCell") as! DiabetesCareCell
        
        cellObj.btnLike.setImage(#imageLiteral(resourceName: "heart-inactive"), for: .normal)
        cellObj.btnAdd.setTitle("ADD TO INSTA LIST", for: .normal);
        cellObj.lblMRP.text = "\u{20B9}" + "135.00"
        cellObj.selectionStyle = .none
        cellObj.btnLike.tag = indexPath.row;
        cellObj.btnLike.addTarget(self, action: #selector(btnLikeAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnAdd.isHidden = false;
        cellObj.cartView.isHidden = true;
        cellObj.btnAdd.tag = indexPath.row;
        cellObj.btnAdd.addTarget(self, action: #selector(btnAddAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnPlus.tag = indexPath.row;
        cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnMinus.tag = indexPath.row;
        cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 128
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:DiabetesCareCell = tableView.cellForRow(at: indexPath) as! DiabetesCareCell
     
    }


    @objc func btnAddAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrderAdd)
        let indexPath = self.tblInstaOrderAdd.indexPathForRow(at: position)
        let cell:DiabetesCareCell = tblInstaOrderAdd.cellForRow(at: indexPath!) as! DiabetesCareCell
        cell.cartView.isHidden = false;
        cell.btnAdd.isHidden = true;
        cell.lblProductQty.text = "1";
        
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrderAdd)
        let indexPath = self.tblInstaOrderAdd.indexPathForRow(at: position)
        let cell:DiabetesCareCell = tblInstaOrderAdd.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        i = i + 1;
        cell.lblProductQty.text = String(i);
        
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrderAdd)
        let indexPath = self.tblInstaOrderAdd.indexPathForRow(at: position)
        let cell:DiabetesCareCell = tblInstaOrderAdd.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        var i = Int()
        i = Int(cell.lblProductQty.text!)!
        
        if( i > 1 ){
            
            i = i - 1;
            cell.btnMinus.isEnabled = true;
            cell.lblProductQty.text = String(i);
            cell.cartView.isHidden = false;
            cell.btnAdd.isHidden = true;
            
        }else {
            
            i = 1
            cell.btnMinus.isEnabled = false;
            cell.lblProductQty.text = String(i);
            cell.cartView.isHidden = false;
            cell.btnAdd.isHidden = true;
        }
        
        
    }
    
    @objc func btnLikeAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrderAdd)
        let indexPath = self.tblInstaOrderAdd.indexPathForRow(at: position)
        let cell:DiabetesCareCell = tblInstaOrderAdd.cellForRow(at: indexPath!) as! DiabetesCareCell
        
        if(button.isSelected != true){
            
            cell.btnLike.setImage(#imageLiteral(resourceName: "heart-active"), for: .normal)
            button.isSelected = true;
            
        }else {
            
            cell.btnLike.setImage(#imageLiteral(resourceName: "heart-inactive"), for: .normal)
            button.isSelected = false;
            
        }
        
    }
    
    
}
