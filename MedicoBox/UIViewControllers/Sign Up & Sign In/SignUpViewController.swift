//
//  SignUpViewController.swift
//  MedicoBox
//
//  Created by SBC on 14/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
        
//        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignUpDeliveryBoyVC)
//
//        self.navigationController?.pushViewController(Controller, animated: true)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        

        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignInVC)

        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
}

