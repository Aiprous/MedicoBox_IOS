//
//  OrderTrackingViewController.swift
//  MedicoBox
//
//  Created by SBC on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderTrackingViewController: UIViewController {

    
    @IBOutlet weak var tblOrderItems: UITableView!
    @IBOutlet weak var mapView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblOrderItems.separatorStyle = .none
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
