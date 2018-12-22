//
//  OrderCancelViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderCancelViewController: UIViewController, UISearchBarDelegate {
    var searchBar :UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar!.delegate = self
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
          self.navigationController?.isNavigationBarHidden = false;
    }
    
    
    //MARK:- SearchBar Delegate And DataSource
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view .endEditing(true)
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSearchVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnConfirmAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
        
    }
    
}
