//
//  MyProfileViewController.swift
//  MedicoBox
//
//  Created by SBC on 01/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setNavigationBarItem()
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func editProfileAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kEditProfileVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
   

}
