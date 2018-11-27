//
//  ProductDrugInfoViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 02/11/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

struct SectionInfo {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class ProductDrugInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet weak var tblProductDrugInfo: UITableView!
    var sections = [SectionInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set attributed text on a UILabel
//        let title = "Usage & Work"
        let subTitle = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
//
//
//        let titleAttribute = [NSAttributedStringKey.font: UIFont(name: "Open Sans-Bold", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
//        let titleSubAttribute = [NSAttributedStringKey.font: UIFont(name: "Open Sans", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
//        let titleString = NSAttributedString(string: title, attributes: titleAttribute)
//        let subTitleString = NSAttributedString(string: subTitle, attributes: titleSubAttribute)
//
//        let finalString: String =  titleString.string +  "\n" + subTitleString.string;
        
        sections = [
            SectionInfo(name: "  Usage & Work", items: [subTitle], collapsed: false),
            SectionInfo(name: "  Interaction & Side Effects", items: ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."], collapsed: false),
            SectionInfo(name: "  Warning & Precautions", items: ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."], collapsed: false),
            SectionInfo(name: "  More Information", items: ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."], collapsed: false),
        ]
        
        // Do any additional setup after loading the view.
        tblProductDrugInfo.register(UINib(nibName: "ProductDrugInfoSubTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDrugInfoSubTableViewCell")
        tblProductDrugInfo.estimatedRowHeight = 62
        tblProductDrugInfo.separatorStyle = .singleLine
        tblProductDrugInfo.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblProductDrugInfo.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblProductDrugInfo.tableFooterView = footerView
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].collapsed) {
            return UITableViewAutomaticDimension
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].name, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDrugInfoSubTableViewCell") as! ProductDrugInfoSubTableViewCell
        cell.lblDesc.text = sections[indexPath.section].items[indexPath.row]
//        cell.lblDesc.frame.size.height = cell.lblDesc.optimalHeight
        let font = UIFont(name: "Open Sans", size: 17.0)
        let height = heightForView(text: cell.lblDesc.text!, font: font!, width: 100.0)
        cell.lblDesc.frame.size.height = height;
        cell.selectionStyle = .none;
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        if sections[section].collapsed {
            sections[section].collapsed = !sections[section].collapsed;
            header.img.image = #imageLiteral(resourceName: "downArrow_yellow");
        }else{
            header.img.image = #imageLiteral(resourceName: "up-arrow-yellow");

            sections[0].collapsed = false;
            sections[1].collapsed = false;
            sections[2].collapsed = false;
            sections[3].collapsed = false;
            sections[section].collapsed = !sections[section].collapsed;
        }
        tblProductDrugInfo.reloadData()
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
   
}
