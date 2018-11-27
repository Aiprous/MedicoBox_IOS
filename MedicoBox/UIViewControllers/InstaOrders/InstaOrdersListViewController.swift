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
    @IBOutlet weak var lblMRPProductInfoView: UILabel!
    @IBOutlet weak var lblTabletSRProductInfoView: UILabel!

    var displayList = NSMutableArray()
    //    var destinationData: [DestinationData?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        destinationData = getData()
        self.btnBackView.isHidden = true;
        self.newInstaListView.isHidden = true;
        self.productInfoView.isHidden = true;
        self.navigationController?.isNavigationBarHidden = false;
        self.tblInstaOrdersList.register(UINib(nibName: "InstaOrdersListTableViewCell", bundle: nil), forCellReuseIdentifier: "InstaOrdersListTblViewCellID")
        tblInstaOrdersList.delegate = self
        tblInstaOrdersList.dataSource = self
        tblInstaOrdersList.estimatedRowHeight = 128
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblInstaOrdersList.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblInstaOrdersList.tableFooterView = footerView
        
        self.lblTabletSRProductInfoView.text = "(" + "\u{20B9}" + "6.86/Tablet SR)"
        self.lblMRPProductInfoView.text = "\u{20B9}" + " 68.00"
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
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "InstaOrdersListTblViewCellID") as! InstaOrdersListTableViewCell
        
        if(indexPath.row == 0){
            
            cellObj.headerTitle = "Diabetes"
            cellObj.bottomCellView.isHidden = false
            cellObj.topHeaderCellView.isHidden = false
            cellObj.btnSelectAll.isHidden = false
            cellObj.lblSelectAll.isHidden = false
            
        }else{
            
            cellObj.bottonCellViewTop.constant = 8;
            //            cellObj.bottonCellViewHeight.constant = 40;
            cellObj.SelectAllCellViewHeight.constant = 0;
            cellObj.btnSelectAll.isHidden = true
            cellObj.lblSelectAll.isHidden = true
            cellObj.bottomCellView.isHidden = false
            cellObj.topHeaderCellView.isHidden = true
        }
      
        cellObj.optionView.isHidden = true;
        cellObj.btnOptions.tag = indexPath.row;
        cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnAddItem.tag = indexPath.row;
        cellObj.btnAddItem.addTarget(self, action: #selector(btnAddItemAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnEdit.tag = indexPath.row;
        cellObj.btnEdit.addTarget(self, action: #selector(btnEditAction(button:)), for: UIControlEvents.touchUpInside);
        
        cellObj.btnDropDown.tag = indexPath.section
        let headerTapped = UITapGestureRecognizer(target: self, action:#selector(InstaOrdersListViewController.sectionHeaderTapped(_:)))
        cellObj.btnDropDown.addGestureRecognizer(headerTapped)
        cellObj.btnPlus.tag = indexPath.row;
        cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnMinus.tag = indexPath.row;
        cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
        //        cellObj.bottomCellView.isHidden = true
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var value:CGFloat = CGFloat()
        
        if (indexPath.row == 0){
                
                value =  194;
                
            }else {
                
                value = 53;
                
            }
        
        return value;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//         let cell:InstaOrdersListTableViewCell = tableView.cellForRow(at: indexPath) as! InstaOrdersListTableViewCell
        self.productInfoView.isHidden = false;
        self.btnBackView.isHidden = false;

   

    }
    
    /* func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     
     if (tableView == tblInstaOrdersList){
     
     if (section == 0) {
     return 128;
     }
     return 128;
     }else {
     
     }
     return 1.0;
     
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
     */
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
    
    @objc func sectionHeaderTapped(_ gestureRecognizer: UITapGestureRecognizer?) {
        
        let indexPath = IndexPath(row: 0, section: gestureRecognizer?.view?.tag ?? 0)
        
        /*     if indexPath.row == 0 {
         if let data = destinationData {
         if let rowData = data[indexPath.section] {
         if(rowData.flag == "Close"){
         rowData.flag = "Open"
         }
         else{
         rowData.flag = "Close"
         }
         }
         }
         var data = destinationData
         let rowData = data![indexPath.section]
         if let anInfo = rowData {
         data![indexPath.section] = anInfo
         }
         
         tblInstaOrdersList.reloadSections(NSIndexSet(index: gestureRecognizer?.view?.tag ?? 0) as IndexSet, with: .automatic)
         }
         */
    }
    
    
    @objc func btnOptionAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        cell.optionView.isHidden = false;
        
    }
    
     @objc func btnEditAction(button: UIButton) {
        
        
    }
    
    @objc func btnAddItemAction(button: UIButton) {
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kInstaOrderAddVC)
        self.navigationController?.pushViewController(Controller!, animated: true)
        self.tblInstaOrdersList.reloadData()
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        
        var i = Int()
        i = Int(cell.lblInstaOrderCount.text!)!
        i = i + 1;
        cell.lblInstaOrderCount.text = String(i);
        
       /* for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_Id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }*/
    }
    
    @objc func btnMinusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        
        var i = Int()
        i = Int(cell.lblInstaOrderCount.text!)!
        
        if( i > 1 ){
            
            i = i - 1;
            cell.btnMinus.isEnabled = true;
            cell.lblInstaOrderCount.text = String(i);
            
        }else {
            
            i = 1
            cell.btnMinus.isEnabled = false;
            cell.lblInstaOrderCount.text = String(i);
            
        }
        
       /* for dictObjCart in cartArray {
            
            if((cell.lblTabletName.text! == ((dictObjCart as AnyObject).value(forKey: "name")as? String ?? "")!) && (cell.lblSku.text! == ((dictObjCart as AnyObject).value(forKey: "sku")as? String ?? "")!)){
                
                self.productItem_Id = String((dictObjCart as AnyObject).value(forKey: "item_id")as? Int ?? 0)
                self.qty = String(cell.lblProductQty.text!)
                self.callAPIEditCart()
                
            }
        }*/
        
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
     
    }
    @IBAction func btnOkAction(_ sender: Any) {
        
        self.btnBackView.isHidden = true;
        self.productInfoView.isHidden = true;
        self.newInstaListView.isHidden = true;
        
    }
}
