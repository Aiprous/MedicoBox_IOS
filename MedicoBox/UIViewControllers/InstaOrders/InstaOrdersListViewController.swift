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
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "InstaOrdersListTblViewCellID") as! InstaOrdersListTableViewCell
        
        if(indexPath.row == 0){
            
            cellObj.lblInstaOrderTitle.text = "Diabetes";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            cellObj.bottomCellView.isHidden = true

        }else if(indexPath.row == 1){
            
            cellObj.lblInstaOrderTitle.text = "Monthly";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            cellObj.bottomCellView.isHidden = true

        }else if(indexPath.row == 2){
            
            cellObj.lblInstaOrderTitle.text = "Priyanka";
            cellObj.btnOptions.tag = indexPath.row;
            cellObj.btnDropDown.tag = indexPath.row;
            cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
            cellObj.bottomCellView.isHidden = true

        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if indexPath.row == 0 {
            return 212
        } else {
            return 131
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:InstaOrdersListTableViewCell = tableView.cellForRow(at: indexPath) as! InstaOrdersListTableViewCell
        
       /* if(cell.btnDropDown.isSelected == true){
            
            cell.bottomCellView.isHidden = false
            
        }
        */
//        cell.optionView.isHidden = false;
        //        self.productInfoView.isHidden = false;
        cell.bottomCellView.isHidden = false

        
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 320.0, height: 20.0))
        footer.layer.backgroundColor = UIColor.clear.cgColor
        return footer
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 320.0, height: 20.0))
        footer.layer.backgroundColor = UIColor.clear.cgColor
        return footer
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(getter: UITableViewCell.tintColor)) {
            let cornerRadius: CGFloat = 9.0
            cell.backgroundColor = UIColor.clear
            let layer = CAShapeLayer()
            let pathRef = CGMutablePath()
            let bounds: CGRect = cell.bounds.insetBy(dx: 5, dy: 0)
            var addLine = false
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                pathRef.addRoundedRect(in: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: .identity)
            } else if indexPath.row == 0 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY), transform: .identity)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius, transform: .identity)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
                pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY), transform: .identity)
                addLine = true
            } else if  indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY), transform: .identity)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius, transform: .identity)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
            } else {
                    pathRef.addRect(bounds, transform: .identity)
                    addLine = true
            }
            
            layer.path = pathRef
            //set the border color with shadow
            layer.strokeColor = UIColor.white.cgColor
            //set the border width
            layer.lineWidth = 1
            layer.fillColor = UIColor(white: 1.0, alpha: 1.0).cgColor
            
            if addLine == true {
                let lineLayer = CALayer()
                let lineHeight: CGFloat = 1.0 / UIScreen.main.scale
                lineLayer.frame = CGRect(x: bounds.minX, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor?.cgColor
                layer.addSublayer(lineLayer)
            }
            
            let testView = UIView(frame: bounds)
            testView.layer.insertSublayer(layer, at: 0)
            testView.backgroundColor = UIColor.clear
            cell.backgroundView = testView
        }
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
