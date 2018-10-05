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
    /*
     private func getData() -> [DestinationData?] {
     let data: [DestinationData?] = []
     
     let diabetesCellData = [ CellsData(orderName: "Tab Evion 400mg", itemCount: "1"), CellsData(orderName: "Inj Emcet 4mg", itemCount: "3") ,CellsData(orderName: "Otrivin Spray", itemCount: "2")]
     let diabetes = DestinationData(name: "Diabetes", flag: "Close", cellData: diabetesCellData)
     
     //        let monthlyCellData = [CellsData(orderName: "Otrivin Spray", itemCount: "2"),  CellsData(orderName: "Inj Emcet 4mg", itemCount: "3")]
     //        let monthly = DestinationData(name: "Monthly", cellData: monthlyCellData)
     //
     //        let priyankaCellData = [CellsData(orderName: "Otrivin Spray", itemCount: "2")]
     //        let priyanka = DestinationData(name: "Priyanka", cellData: priyankaCellData)
     
     return [diabetes] //, monthly, priyanka]
     } */
    
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
            
            cellObj.bottonCellViewTop.constant = 0;
            //            cellObj.bottonCellViewHeight.constant = 40;
            cellObj.SelectAllCellViewHeight.constant = 0;
            cellObj.btnSelectAll.isHidden = true
            cellObj.lblSelectAll.isHidden = true
            cellObj.bottomCellView.isHidden = false
            cellObj.topHeaderCellView.isHidden = true
        }
        
        /* if let rowData = destinationData?[indexPath.section] {
         if(rowData.flag == "Close"){
         
         cellObj.lblInstaOrderTitle.text = rowData.name
         
         if(indexPath.row == 0){
         
         cellObj.bottomCellView.isHidden = true
         cellObj.topHeaderCellView.isHidden = false
         
         }else{
         
         cellObj.bottomCellView.isHidden = false
         }
         }else {
         
         if(indexPath.row == 0){
         
         cellObj.bottomCellView.isHidden = true
         cellObj.topHeaderCellView.isHidden = false
         
         }else{
         
         cellObj.bottomCellView.isHidden = false
         cellObj.topHeaderCellView.isHidden = true
         
         }
         
         cellObj.lblInstaOrderTitle.text = rowData.name
         cellObj.lblOrderName.text = rowData.cellData?[indexPath.row].orderName
         cellObj.lblInstaOrderCount.text = rowData.cellData?[indexPath.row].itemCount
         }
         
         }
         */
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
        //        cellObj.bottomCellView.isHidden = true
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if (indexPath.row == 0){
            
            return 194
            
        }else {

             return 40
            
        }
        
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
