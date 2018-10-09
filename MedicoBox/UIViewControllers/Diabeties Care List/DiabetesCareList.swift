//
//  DiabetesCareList.swift
//  MedicoBox
//
//  Created by SBC on 22/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class DiabetesCareList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var diabetesTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false;
        // Do any additional setup after loading the view.
        diabetesTblView.register(UINib(nibName: "DiabetesCareCell", bundle: nil), forCellReuseIdentifier: "DiabetesCareCell")
        diabetesTblView.estimatedRowHeight = 130
        diabetesTblView.separatorStyle = .none
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    //MARK:- Table View Delegate And DataSource
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "DiabetesCareCell") as! DiabetesCareCell
        cellObj.lblMRP.text = "\u{20B9}" + "135.00"
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0 {
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailAVC)
            self.navigationController?.pushViewController(Controller, animated: true)
        }else{
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailBVC)

            self.navigationController?.pushViewController(Controller, animated: true)
        }
        
    }

    

}
