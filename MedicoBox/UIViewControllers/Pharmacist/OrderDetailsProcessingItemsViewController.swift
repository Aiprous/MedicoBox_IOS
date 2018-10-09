//
//  OrderDetailsProcessingItemsViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderDetailsProcessingItemsViewController: UIViewController {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var itemsOrderedBtn: UIButton!
    @IBOutlet weak var itemsOrderedBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var invoiceBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shipmentsBtn: UIButton!
    @IBOutlet weak var shipmentsBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var itemsOrderedContainer: UIView!
    @IBOutlet weak var invoiceContainer: UIView!
    @IBOutlet weak var shipmentsContainer: UIView!
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemsOrderedBtn.isSelected = true
        self.invoiceBtn.isSelected = false
        self.shipmentsBtn.isSelected = false
        
        self.itemsOrderedContainer.isHidden = false
        self.invoiceContainer.isHidden = true
        self.shipmentsContainer.isHidden = true

        self.itemsOrderedBottomConstraint.constant = 2
        self.invoiceBtnBottomConstraint.constant = 0
        self.shipmentsBtnBottomConstraint.constant = 0
        self.topContainer.layoutIfNeeded()
        
        self.itemsOrderedBtn.setTitleColor(.black, for: .selected)
        self.invoiceBtn.setTitleColor(.black, for: .selected)
        self.shipmentsBtn.setTitleColor(.black, for: .selected)
        
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
        
        if( self.itemsOrderedBtn.isSelected) {
            
        }else if( self.invoiceBtn.isSelected){
            
        }else{
            
        }
    }
   
    //MARK:// Button action
    @IBAction func topActionBtnTapped(_ sender: Any) {
        
        let btn = sender as! UIButton
        if (btn == self.itemsOrderedBtn){
            
            if btn.isSelected {
                
            }else{
                
                btn.isSelected = true
                self.itemsOrderedBtn.isSelected = true
                self.invoiceBtn.isSelected = false
                self.shipmentsBtn.isSelected = false
                self.invoiceContainer.isHidden = true
                self.shipmentsContainer.isHidden = true
                self.itemsOrderedContainer.isHidden = false
                self.itemsOrderedBottomConstraint.constant = 2
                self.invoiceBtnBottomConstraint.constant = 0
                self.shipmentsBtnBottomConstraint.constant = 0

                UIView.animate(withDuration: 0.2, animations: {
                    self.topContainer.layoutIfNeeded()
                })
                
            }
            
        }else if (btn == self.invoiceBtn){
            
            if btn.isSelected {
                
            }else{
                
                btn.isSelected = true
                self.itemsOrderedBtn.isSelected = false
                self.invoiceBtn.isSelected = true
                self.shipmentsBtn.isSelected = false
                self.invoiceContainer.isHidden = false
                self.itemsOrderedContainer.isHidden = true
                self.shipmentsContainer.isHidden = true
                self.itemsOrderedBottomConstraint.constant = 0
                self.invoiceBtnBottomConstraint.constant = 2
                self.shipmentsBtnBottomConstraint.constant = 0
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.topContainer.layoutIfNeeded()
                })
            }
        }
        else{
         
         if btn.isSelected {
         
         }else{
         
         btn.isSelected = true
         self.itemsOrderedBtn.isSelected = false
         self.invoiceBtn.isSelected = false
         self.shipmentsBtn.isSelected = true
         self.invoiceContainer.isHidden = true
         self.itemsOrderedContainer.isHidden = true
         self.shipmentsContainer.isHidden = false
         self.itemsOrderedBottomConstraint.constant = 0
         self.invoiceBtnBottomConstraint.constant = 0
         self.shipmentsBtnBottomConstraint.constant = 2
         
         UIView.animate(withDuration: 0.2, animations: {
         self.topContainer.layoutIfNeeded()
         })
         }
         }
    }
    
    //Feature use
    func updateBottomHighLighter() {
        
        let layer = CALayer()
        
        layer.backgroundColor = UIColor.blue.cgColor
        
        layer.name = "bootomLayerBlue"
        
        
        if self.itemsOrderedBtn.isSelected {
            
            var rect = self.itemsOrderedBtn.frame
            
            rect.origin.y = rect.origin.y + rect.size.height - 2
            rect.size.height = 2
            layer.frame = rect
            
            self.topContainer.layer.addSublayer(layer)
            
        }else if(self.invoiceBtn.isSelected ){
            
            var rect = self.invoiceBtn.frame
            
            rect.origin.y = rect.origin.y + rect.size.height - 2
            rect.size.height = 2
            layer.frame = rect
            
            self.topContainer.layer.addSublayer(layer)
        }
        else{
         
         var rect = self.shipmentsBtn.frame
         
         rect.origin.y = rect.origin.y + rect.size.height - 3
         rect.size.height = 3
         layer.frame = rect
         
         self.topContainer.layer.addSublayer(layer)
         
         }
        
    }
    
}
