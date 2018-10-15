//
//  PharmacistDashboardViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 09/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class PharmacistDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblLifetimeSales: UILabel!
    @IBOutlet weak var lblRemainingAmount: UILabel!
    @IBOutlet weak var lblTotalPayout: UILabel!
    @IBOutlet weak var tblTopSellingProductsList: UITableView!
    @IBOutlet weak var barChart: BasicBarChart!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false;
        
        
        self.lblTotalPayout.text = "\u{20B9}" + " 2000.00"
        self.lblRemainingAmount.text = "\u{20B9}" + " 1000.00"
        self.lblLifetimeSales.text = "\u{20B9}" + " 125200.00"
        self.tblTopSellingProductsList.register(UINib(nibName: "TopSellingProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "TopSellingProductsTableViewCell")
        tblTopSellingProductsList.delegate = self
        tblTopSellingProductsList.dataSource = self
        tblTopSellingProductsList.estimatedRowHeight = 130
//        tblTopSellingProductsList.separatorStyle = .none
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemPharm()
    }
    override func viewDidAppear(_ animated: Bool) {
        let dataEntries = generateDataEntries()
        barChart.dataEntries = dataEntries
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// MARK: Chart
    
    func generateDataEntries() -> [BarEntry] {

        let colors = [#colorLiteral(red: 0.1220000014, green: 0.172999993, blue: 0.2980000079, alpha: 1)]
        var result: [BarEntry] = []
        for i in 0..<7 {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            var days = [String]()
            days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
            result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: days[i % days.count]))
        }
        return result
    }
    
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "TopSellingProductsTableViewCell") as! TopSellingProductsTableViewCell
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 94
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:TopSellingProductsTableViewCell = tableView.cellForRow(at: indexPath) as! TopSellingProductsTableViewCell
        
        
        
    }
    
}
