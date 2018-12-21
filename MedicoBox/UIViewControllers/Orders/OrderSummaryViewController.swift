//
//  OrderSummaryViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var searchBar :UISearchBar? 

    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    @IBOutlet weak var lblAddressView: UILabel!
    @IBOutlet weak var bottomView: DesignableShadowView!
    @IBOutlet weak var bottomViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnAttachedPresription: UIButton!
    @IBOutlet weak var mainViewHightConstraint: NSLayoutConstraint!
    var flagViewWillAppear = "";

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        //show navigationbar with back button
        
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
        lblAddressView.text = "Flat No 104, A Wing \nGreen Olive Apartments,\nHinjawadi \nPune - 411057\nMaharashtra \nIndia"
        flagViewWillAppear = "true";

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;

        if(flagViewWillAppear == "true"){

            self.bottomViewHightConstraint.constant = 50;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
        
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            flagViewWillAppear = "false";
        
        }else {
    
    
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.bottomViewHightConstraint.constant = 50;
//        self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
//
//        UIView.animate(withDuration: 0.5) {
//            self.view.updateConstraints()
//            self.view.layoutIfNeeded()
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kOrderPlacedVC)
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
    
    
    @IBAction func btnAttachedPresriptionAction(_ sender: Any) {
        
        if(btnAttachedPresription.isSelected == false){
            
            bottomViewHightConstraint.constant = 207;
            collectionViewHightConstraint.constant = 147;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant + 157;
            self.prescriptionCollectionView.isHidden = false;
            self.btnAttachedPresription.isSelected = true;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            
            
        }else {
            
            bottomViewHightConstraint.constant = 50;
            collectionViewHightConstraint.constant = 0;
            self.prescriptionCollectionView.isHidden = true;
            self.btnAttachedPresription.isSelected = false;
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
    }
}
