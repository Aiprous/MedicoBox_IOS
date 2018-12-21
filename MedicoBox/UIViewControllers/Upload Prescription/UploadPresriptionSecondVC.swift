//
//  UploadPresriptionSecondVC.swift
//  MedicoBox
//
//  Created by SBC on 27/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import Alamofire

class UploadPresriptionSecondVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar? 

    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    @IBOutlet weak var durationDosageViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var medicineNameViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnCallMeForDetails: UIButton!
    @IBOutlet weak var btnMedicinesAndQuantity: UIButton!
    @IBOutlet weak var btnOrderEverything: UIButton!
    @IBOutlet weak var durationOfDosageView: UIView!
    @IBOutlet weak var medicinesAndQuantityView: UIView!
    @IBOutlet weak var topViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: DesignableShadowView!
    @IBOutlet weak var bottomViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewAttachedPresription: UICollectionView!
    @IBOutlet weak var btnAttachedPresription: UIButton!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var txtMedicineSearch: UITextField!
    @IBOutlet weak var tblSearchList: UITableView!
    @IBOutlet weak var cartProductView: DesignableShadowView!
    @IBOutlet weak var tblProduct: UITableView!
    
    @IBOutlet weak var lblCartItem: UILabel!
    var flagViewWillAppear = "";
    let cellReuseIdentifier = "cell"
    var searchingArray = NSArray();
    var isSeaching = false
    var productSearchArray = NSArray();
    var selectedProductArray: NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartProductView.isHidden = true; prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        self.navigationController?.isNavigationBarHidden = false;
        btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        flagViewWillAppear = "true";
        self.tblProduct.register(UINib(nibName: "UploadPrescProductTCell", bundle: nil), forCellReuseIdentifier: "UploadPrescProductTCell")
        tblProduct.delegate = self
        tblProduct.dataSource = self
        tblProduct.estimatedRowHeight = 70
        
        self.tblSearchList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tblSearchList.delegate = self
        tblSearchList.dataSource = self
        self.selectedProductArray = [];
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = false;
        if(flagViewWillAppear == "true"){
            
            topViewHightConstraint.constant = 165;
            durationDosageViewHightConstraint.constant = 0;
            medicineNameViewHightConstraint.constant = 0;
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            bottomViewHightConstraint.constant = 50;
            
                UIView.animate(withDuration: 0.5) {
                    self.view.updateConstraints()
                    self.view.layoutIfNeeded()
                }
            flagViewWillAppear = "false";

        }else {
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func continueBtnAction(_ sender: Any) {
    
     let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kSelectAddressVC)
     self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        numberCount = 1;
        return numberCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
        // get a reference to our storyboard cell
        let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionCollectionViewCell", for: indexPath as IndexPath) as! PrescriptionCollectionViewCell
        return cellObj;
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 112, height: 133)
        
    }

    
    @IBAction func btnOrderEverythingAction(_ sender: Any) {

            btnOrderEverything.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            topViewHightConstraint.constant = 220;
            durationDosageViewHightConstraint.constant = 70;
            medicineNameViewHightConstraint.constant = 0;
            durationOfDosageView.isHidden = false;
            medicinesAndQuantityView.isHidden = true;
            self.btnOrderEverything.isSelected = true;
            self.cartProductView.isHidden = true
            self.lblCartItem.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

    }
    @IBAction func btnMedicinesAndQuantityAction(_ sender: Any) {
            
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = false;
            topViewHightConstraint.constant = 220;
            durationDosageViewHightConstraint.constant = 0;
            medicineNameViewHightConstraint.constant = 76;
            self.btnMedicinesAndQuantity.isSelected = true;
        if selectedProductArray?.count ?? 0 > 0 {
            self.cartProductView.isHidden = false
            self.lblCartItem.isHidden = false
        }else{
            self.cartProductView.isHidden = true
            self.lblCartItem.isHidden = true
        }
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        
    }
    @IBAction func btnCallMeForDetailsAction(_ sender: Any) {
        
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            topViewHightConstraint.constant = 165;
            durationDosageViewHightConstraint.constant = 0;
            medicineNameViewHightConstraint.constant = 0;
            self.btnMedicinesAndQuantity.isSelected = true;
            self.cartProductView.isHidden = true
            self.lblCartItem.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        
    }
    
    @IBAction func btnAttachedPresriptionAction(_ sender: Any) {
        
        if(btnAttachedPresription.isSelected == false){
            
            bottomViewHightConstraint.constant = 207;
            collectionViewHightConstraint.constant = 147;
            self.collectionViewAttachedPresription.isHidden = false;
            self.btnAttachedPresription.isSelected = true;
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            
        }else {
            
            bottomViewHightConstraint.constant = 50;
            collectionViewHightConstraint.constant = 0;
            self.collectionViewAttachedPresription.isHidden = true;
            self.btnAttachedPresription.isSelected = false;
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

        }
    }
    @objc func deleteProduct(button: UIButton) {
        let position: CGPoint = button.convert(.zero, to: self.tblProduct)
        let indexPath = self.tblProduct.indexPathForRow(at: position)
        selectedProductArray?.removeObject(at: (indexPath?.row)!)
        self.tblProduct.reloadData()
//        self.deleteWishListAPI(wishListId:  (indexPath?.section)!)
        //        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kInstaOrderAddVC)
        //        self.navigationController?.pushViewController(Controller!, animated: true)
        //        self.tblInstaOrdersList.reloadData()
    }
    
    @objc func btnPlusAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.tblProduct)
        let indexPath = self.tblProduct.indexPathForRow(at: position)
        let cell:UploadPrescProductTCell = tblProduct.cellForRow(at: indexPath!) as! UploadPrescProductTCell
        
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
        
        let position: CGPoint = button.convert(.zero, to: self.tblProduct)
        let indexPath = self.tblProduct.indexPathForRow(at: position)
        let cell:UploadPrescProductTCell = tblProduct.cellForRow(at: indexPath!) as! UploadPrescProductTCell
        
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
    
    func callAPI_getSearchByName() {
        
        let urlString = "http://user8.itsindev.com/medibox/API/filter-product.php"
        
        let params = ["name":self.txtMedicineSearch.text!];//API_TOKEN];
        
        print(urlString,params)
        //        SVProgressHUD.show()
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                //                SVProgressHUD.dismiss()
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        //                        print(responseDict);
                        //                        self.TblSearchList.isHidden = false
                        self.searchingArray = responseDict.value(forKey: "response")as! NSArray
                        //
                        self.tblSearchList.reloadData();
                        
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message") as! String );
                    }
                }
            })
        }
    }

    
}

//MARK:- Table View Delegate And DataSource
extension UploadPresriptionSecondVC: UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
}
func numberOfSections(in tableView: UITableView) -> Int{
    
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    if tableView == tblSearchList {
        if  isSeaching {
            return productSearchArray.count
            
        }else{
            return searchingArray.count;
        }
    }else{
       return self.selectedProductArray?.count ?? 0
    }
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    if tableView == tblSearchList {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        var dictObj : NSDictionary?
        if isSeaching {
            dictObj = productSearchArray.object(at: indexPath.row) as? NSDictionary
        }else{
            dictObj = searchingArray.object(at: indexPath.row) as? NSDictionary
        }
        // set the text from the data model
//        cell.textLabel?.text = "";
        cell.textLabel?.text = dictObj?.value(forKey: "title") as? String
        cell.selectionStyle = .none
        return cell
    }else{
    
    let cellObj = tableView.dequeueReusableCell(withIdentifier: "UploadPrescProductTCell") as! UploadPrescProductTCell
   
        cellObj.btnPlus.tag = indexPath.row;
        cellObj.btnPlus.addTarget(self, action: #selector(btnPlusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnMinus.tag = indexPath.row;
        cellObj.btnMinus.addTarget(self, action: #selector(btnMinusAction(button:)), for: UIControlEvents.touchUpInside);
        cellObj.btnDelete.tag = indexPath.row;
        cellObj.btnDelete.addTarget(self, action: #selector(deleteProduct(button:)), for: UIControlEvents.touchUpInside);
        
        let dict = self.selectedProductArray![indexPath.row] as! NSDictionary
        cellObj.lblProductName.text = (dict.value(forKey: "title") as! String)
        cellObj.lblMRP.text = "\u{20B9} " + (dict.value(forKey: "price") as! String)
//    cellObj.btnSelectWishlist.tag = indexPath.row;
//    cellObj.btnSelectWishlist.addTarget(self, action: #selector(btnSelectWishlistAction(button:)), for: UIControlEvents.touchUpInside);
//    if (dict.value(forKey: "selectedFlag") != nil && (dict.value(forKey: "selectedFlag") as! Bool)) {
//        cellObj.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-selected"), for: .normal)
//    }else{
//        cellObj.btnSelectWishlist.setImage(#imageLiteral(resourceName: "check-box-empty"), for: .normal)
//    }
    
    return cellObj
    }
}

//MARK: - tableview delegate

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
    
    return UITableViewAutomaticDimension
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == tblSearchList {
        self.view.endEditing(true);
        self.tblSearchList.isHidden = true
        if  isSeaching {
            self.selectedProductArray?.add(productSearchArray[indexPath.row])
            
        }else{
            self.selectedProductArray?.add(searchingArray[indexPath.row])
        }
        self.lblCartItem.isHidden = false;
        self.cartProductView.isHidden = false;
        self.tblProduct.reloadData();
    }
}
}

//MARK:- Table View Delegate And DataSource
extension UploadPresriptionSecondVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtMedicineSearch {
        isSeaching = true;
        self.tblSearchList.isHidden = false
        self.view.bringSubview(toFront: self.tblSearchList)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtMedicineSearch {
         self.tblSearchList.isHidden = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.tblSearchList.isHidden = true
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtMedicineSearch {
            self.tblSearchList.isHidden = false
        if textField.text == nil || textField.text == "" {
            
            isSeaching = false
            //            view.endEditing(true)
            tblSearchList.reloadData()
            
        }else {
            
            isSeaching = true
            self.tblSearchList.isHidden = false
            callAPI_getSearchByName()
            productSearchArray = searchingArray.filter({ (text) -> Bool in
                let tmpDict: NSDictionary = text as! NSDictionary
                let tmp:NSString = (tmpDict.value(forKey: "title") as? NSString)!
                let range = tmp.range(of: textField.text!, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            }) as NSArray
            
            tblSearchList.reloadData()
            //            filter({($0["Name"] as? String) == searchBar.text})
          }
        }
        return true
    }
}
