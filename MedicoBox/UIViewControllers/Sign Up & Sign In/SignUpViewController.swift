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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: SIGNIN_VCID)
        self.navigationController?.pushViewController(Controller!, animated: true)
        
    }
}

