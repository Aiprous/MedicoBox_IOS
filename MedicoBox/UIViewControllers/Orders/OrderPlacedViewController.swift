//
//  OrderPlacedViewController.swift
//  MedicoBox
//
//  Created by SBC on 28/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderPlacedViewController: UIViewController, UISearchBarDelegate {
    var searchBar :UISearchBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.navigationController?.isNavigationBarHidden = false;
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}
