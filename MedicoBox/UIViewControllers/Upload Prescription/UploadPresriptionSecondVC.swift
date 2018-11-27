//
//  UploadPresriptionSecondVC.swift
//  MedicoBox
//
//  Created by SBC on 27/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class UploadPresriptionSecondVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    var flagViewWillAppear = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        //show navigationbar with back button
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        
        btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        flagViewWillAppear = "true";
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        if(btnOrderEverything.isSelected == false){
            
            btnOrderEverything.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            topViewHightConstraint.constant = 220;
            durationDosageViewHightConstraint.constant = 70;
            medicineNameViewHightConstraint.constant = 0;
            durationOfDosageView.isHidden = false;
            medicinesAndQuantityView.isHidden = true;
            self.btnOrderEverything.isSelected = true;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

            
        }else {
            
            btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            topViewHightConstraint.constant = 165;
            medicineNameViewHightConstraint.constant = 0;
            durationDosageViewHightConstraint.constant = 0;
            self.btnOrderEverything.isSelected = false;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

            
        }
    }
    @IBAction func btnMedicinesAndQuantityAction(_ sender: Any) {
        
        if(btnMedicinesAndQuantity.isSelected == false){
            
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = false;
            topViewHightConstraint.constant = 220;
            durationDosageViewHightConstraint.constant = 0;
            medicineNameViewHightConstraint.constant = 76;
            self.btnMedicinesAndQuantity.isSelected = true;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

            
        }else {
            
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            topViewHightConstraint.constant = 165;
            medicineNameViewHightConstraint.constant = 0;
            durationDosageViewHightConstraint.constant = 0;
            self.btnMedicinesAndQuantity.isSelected = false;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

            
        }
        
    }
    @IBAction func btnCallMeForDetailsAction(_ sender: Any) {
        
        
        if(btnCallMeForDetails.isSelected == false){
            
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnOrderEverything.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            btnMedicinesAndQuantity.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            topViewHightConstraint.constant = 165;
            durationDosageViewHightConstraint.constant = 0;
            medicineNameViewHightConstraint.constant = 0;
            self.btnMedicinesAndQuantity.isSelected = true;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            
        }else {
            
            btnCallMeForDetails.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            durationOfDosageView.isHidden = true;
            medicinesAndQuantityView.isHidden = true;
            topViewHightConstraint.constant = 165;
            medicineNameViewHightConstraint.constant = 0;
            durationDosageViewHightConstraint.constant = 0;
            self.btnMedicinesAndQuantity.isSelected = false;
            
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
            
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
    
}
