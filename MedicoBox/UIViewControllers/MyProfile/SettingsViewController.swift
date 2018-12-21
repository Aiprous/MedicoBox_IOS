//
//  SettingsViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 01/11/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UISearchBarDelegate {
    var searchBar :UISearchBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        //show navigationbar with back button
        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItem(searchBar: searchBar!)
        self.searchBar?.delegate = self;
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
        
       
        self.navigationController?.isNavigationBarHidden = false;
    }
}