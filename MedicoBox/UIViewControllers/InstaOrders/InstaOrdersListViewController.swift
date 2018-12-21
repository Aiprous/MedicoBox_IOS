//
//  InstaOrdersListViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 24/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class InstaOrdersListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar?
    var optionView1 : UIView?
    @IBOutlet weak var tblInstaOrdersList: UITableView!
    @IBOutlet weak var newInstaListView: DesignableView!
    @IBOutlet weak var productInfoView: DesignableView!
    @IBOutlet weak var btnBackView: UIButton!
    @IBOutlet weak var lblMRPProductInfoView: UILabel!
    @IBOutlet weak var lblTabletSRProductInfoView: UILabel!
    var wishListArray: NSArray?
    var displayList = NSMutableArray()
    //    var destinationData: [DestinationData?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
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
        // Get wishlist
        self.getInstaOrderListAPI()
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return self.wishListArray?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        return 3
        let dict = self.wishListArray?[section] as! NSDictionary
        
        return (dict.value(forKey: "items") as? NSArray)?.count == 0 ? 1 : ((dict.value(forKey: "items") as? NSArray)?.count)!;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "InstaOrdersListTblViewCellID") as! InstaOrdersListTableViewCell
        let dict = self.wishListArray![indexPath.section] as! NSDictionary
        if(indexPath.row == 0) {
            
            cellObj.headerTitle = dict.value(forKey: "wishlist_name") as! String
            if (dict.value(forKey: "items") as? NSArray)?.count == 0 {
                 cellObj.bottomCellView.isHidden = true
                 cellObj.btnAddToCart.isHidden = true
                 cellObj.btnShareWishlist.isHidden = true
                 cellObj.btnDropDown.isHidden = true
            }else{
                 cellObj.bottomCellView.isHidden = false
                 cellObj.btnAddToCart.isHidden = false
                 cellObj.btnShareWishlist.isHidden = false
                 cellObj.btnDropDown.isHidden = false
            }
            cellObj.topHeaderCellView.isHidden = false
//            cellObj.btnSelectAll.isHidden = false
//            cellObj.lblSelectAll.isHidden = false
            
        }else{
            
             //  cellObj.bottonCellViewTop.constant = 8;
            //   cellObj.bottonCellViewHeight.constant = 40;
            
//            cellObj.SelectAllCellViewHeight.constant = 0;
//            cellObj.btnSelectAll.isHidden = true
//            cellObj.lblSelectAll.isHidden = true
            cellObj.bottomCellView.isHidden = false
            cellObj.topHeaderCellView.isHidden = true
        }
      
        cellObj.optionView.isHidden = true;
        cellObj.btnOptions.tag = indexPath.row;
        cellObj.btnOptions.addTarget(self, action: #selector(btnOptionAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnAddItem.tag = indexPath.row;
        cellObj.btnAddItem.addTarget(self, action: #selector(deleteWishlist(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnEdit.tag = indexPath.row;
        cellObj.btnEdit.addTarget(self, action: #selector(btnEditAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnPtoductDetail.addTarget(self, action: #selector(showDetailAction(button:)), for: UIControlEvents.touchUpInside)
        cellObj.btnPtoductDetail.tag = indexPath.row
//        cellObj.btnSelectAll.tag = indexPath.row;
//        cellObj.btnEdit.addTarget(self, action: #selector(btnSelectAllAction(button:)), for: UIControlEvents.touchUpInside);
//        cellObj.btnCheckboxCell.tag = indexPath.row;
//        cellObj.btnCheckboxCell.addTarget(self, action: #selector(btnSelectProductAction(button:)), for: UIControlEvents.touchUpInside);
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
             let dict = self.wishListArray?[indexPath.section] as! NSDictionary
            if (dict.value(forKey: "items") as? NSArray)?.count == 0 {
                value =  100;
            }else {
                value =  160;
            }
                
            }else {
                
                value = 53;
                
            }
        
        return value;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
         let cell:InstaOrdersListTableViewCell = tableView.cellForRow(at: indexPath) as! InstaOrdersListTableViewCell
        cell.optionView.isHidden = true
//        self.productInfoView.isHidden = false;
//        self.btnBackView.isHidden = false;
       
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
//            cell.backgroundColor = UIColor.clear
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
                pathRef.addRect(bounds, transform: .identity)
                addLine = true
//                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY), transform: .identity)
//                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius, transform: .identity)
//                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius, transform: .identity)
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
//            testView.backgroundColor = UIColor.clear
            cell.backgroundView = testView
        }
    }
    
    @objc func sectionHeaderTapped(_ gestureRecognizer: UITapGestureRecognizer?) {
        
        let indexPath = IndexPath(row: 0, section: gestureRecognizer?.view?.tag ?? 0)
        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath) as! InstaOrdersListTableViewCell
        cell.optionView.isHidden = true;
       
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
        optionView1 = cell.optionView
    }
    
    //Movea
     @objc func btnEditAction(button: UIButton) {
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
         cell.optionView.isHidden = true
    }
    @objc func btnSelectAllAction(button: UIButton) {
        //        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        //        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        //        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        
    }
    @objc func btnSelectProductAction(button: UIButton) {
        //        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        //        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        //        let cell:InstaOrdersListTableViewCell = tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        
    }
    
    @objc func showDetailAction (button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        
        let cell:InstaOrdersListTableViewCell = self.tblInstaOrdersList.cellForRow(at: indexPath!) as! InstaOrdersListTableViewCell
        cell.optionView.isHidden = true
        self.productInfoView.isHidden = false;
        self.btnBackView.isHidden = false;
        
    }
    @objc func deleteWishlist(button: UIButton) {
        let position: CGPoint = button.convert(.zero, to: self.tblInstaOrdersList)
        let indexPath = self.tblInstaOrdersList.indexPathForRow(at: position)
        self.deleteWishListAPI(wishListId:  (indexPath?.section)!)
//        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kInstaOrderAddVC)
//        self.navigationController?.pushViewController(Controller!, animated: true)
//        self.tblInstaOrdersList.reloadData()
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
    
    //--------------------------------
    // MARK: - InstOrder List API Call
    //--------------------------------
    
    func getInstaOrderListAPI() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["user_id": "226"] as NSMutableDictionary
        //        https://user8.itsindev.com/medibox/API/get_user_wishlist_products.php
        
        let urlString = BASEURL + "/API/get_user_wishlist_products.php"
        
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
                        if responseDict.value(forKey: "response") != nil {
                           
                            self.wishListArray = responseDict.value(forKey: "response") as? NSArray
                        }
                        self.tblInstaOrdersList.reloadData();
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    func deleteWishListAPI(
        wishListId: Int) {
//    {
//        "wishlist_name_id" :57,
//        "user_id": 184
//        }
        let dict = self.wishListArray![wishListId] as! NSDictionary

        var paraDict = NSMutableDictionary()
        paraDict =  ["user_id": "226", "wishlist_name_id" : dict.value(forKey: "wishlist_name_id") as! String] as NSMutableDictionary
        //        https://user8.itsindev.com/medibox/API/delete_wishlist.php
        
        let urlString = BASEURL + "/API/delete_wishlist.php"
        
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
                        if responseDict.value(forKey: "response") != nil {
                            self.getInstaOrderListAPI()
//                            self.wishListArray = responseDict.value(forKey: "response") as? NSArray
                        }
                        self.tblInstaOrdersList.reloadData();
                        
                    }else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }

}
