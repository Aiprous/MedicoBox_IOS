//
//  OrderCancelViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderCancelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //show navigationbar with back button
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        // Do any additional setup after loading the view.
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
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
        
    }
    
}
