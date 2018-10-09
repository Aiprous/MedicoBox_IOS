//
//  TransationDetailViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class TransationDetailViewController: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblTotalTax: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblTotalShipping: UILabel!
    
    @IBOutlet weak var lblCommission: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblAmount.text = "\u{20B9}" + " 200.00"
        self.lblPrice.text = "\u{20B9}" + " 278.00"
        self.lblTotalTax.text = "\u{20B9}" + " 0.00"
        self.lblTotalShipping.text = "\u{20B9}" + " 0.00"
        self.lblSubTotal.text = "\u{20B9}" + " 278.00"
        self.lblTotalPrice.text = "\u{20B9}" + " 278.00"
        self.lblCommission.text = "\u{20B9}" + " 0.00"

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
}
