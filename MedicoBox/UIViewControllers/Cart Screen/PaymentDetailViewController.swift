//
//  PaymentDetailViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UIViewController, UISearchBarDelegate {
    var searchBar :UISearchBar?

    @IBOutlet weak var lblMrpTotalOrder: UILabel!
    @IBOutlet weak var lblPriceDiscountOrder: UILabel!
    
    @IBOutlet weak var lblShippingChargesOrder: UILabel!
    
    @IBOutlet weak var lblTotalSavedOrder: UILabel!
    
    @IBOutlet weak var lblAmountPaidOrder: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;        self.navigationController?.isNavigationBarHidden = false;
        
//        lblPriceOrder.text = "\u{20B9}" + " 350.00"
        
        lblMrpTotalOrder.text = "\u{20B9}" + " 350.00"
        lblPriceDiscountOrder.text = "- "  + "\u{20B9}" + " 35.00"
//        lblShippingChargesOrder.text =  "0"
        lblTotalSavedOrder.text = "\u{20B9}" + " 30.00"
        lblAmountPaidOrder.text = "\u{20B9}" + " 350.00"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func placeOrderAction(_ sender: Any) {
        
        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kOrderPlacedThankYouVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    

}
