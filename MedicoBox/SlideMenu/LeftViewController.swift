//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenuUser: Int {
    case home = 0
    case orders
    case medicines
    case labtests
    case account
    case cart
    case notifications
    case settings
    case logout
}

enum LeftMenuPharma: Int {
    case home = 0
    case orders
    case medicines
    case labtests
    case account
    case cart
    case notifications
    case settings
    case logout
}

struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenuUser)
    func changePharmaViewController(_ menu:LeftMenuPharma)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    //    var menus = ["Main", "Swift", "NonMenu"]
    var iconArray = ["home","box","capsules","syringe","user","cart","ic_notifications_black_24dp","settings","logout"]
     var iconArray1 = ["home","box","user","cart","ic_notifications_black_24dp","plus","transaction","logout"]
    
    var homeViewController: UIViewController!
    var diabetesCareViewController: UIViewController!
    var productDetailAViewController: UIViewController!
    var myOrdersViewController: UIViewController!
    var myProfileViewController : UIViewController!
    var notificationViewController : UIViewController!
    var productsPharmacistViewController: UIViewController!
    var transactionListViewController: UIViewController!
    var orderDetailsProcessingItemsViewController: UIViewController!


    var imageHeaderView: ImageHeaderView!
    var sections = [Section]()
    var sections1 = [Section]()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

                sections = [
                    Section(name: "Home", items: []),
                    Section(name: "Orders", items: ["Medicines", "Lab Tests"]),
                    Section(name: "Account", items: []),
                    Section(name: "Cart", items: []),
                    Section(name: "Notifications", items: []),
                    Section(name: "Settings", items: []),
                    Section(name: "Logout", items: []),
                ]
        sections1 = [
            Section(name: "Dashboard", items: []),
            Section(name: "Orders", items: []),
            Section(name: "Profile", items: []),
            Section(name: "Products", items: []),
            Section(name: "Notifications", items: []),
            Section(name: "Add Delivery Boy", items: []),
            Section(name: "Transactions", items: []),
            Section(name: "Logout", items: []),
        ]
        
        //        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        self.tableView.tableFooterView = UIView(frame: .zero)
   
        let homeViewController1 = kMainStoryboard.instantiateViewController(withIdentifier: kHomeVC)
        
        self.homeViewController = UINavigationController(rootViewController: homeViewController1)
        
        let diabetiesViewController = kMainStoryboard.instantiateViewController(withIdentifier: kDiabetesCareListVC)
       
        self.diabetesCareViewController = UINavigationController(rootViewController: diabetiesViewController)
        
        let myProfileVC = kMainStoryboard.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        self.myProfileViewController = UINavigationController(rootViewController: myProfileVC)

        let productDetailViewController = kMainStoryboard.instantiateViewController(withIdentifier: kProductDetailAVC)
        self.productDetailAViewController = UINavigationController(rootViewController: productDetailViewController)
        
        let myOrderViewController = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kMyOrdersVC)
        self.myOrdersViewController = UINavigationController(rootViewController: myOrderViewController)

        let productsPharmacistViewController = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kProductsPharmacistVC)
        self.productsPharmacistViewController = UINavigationController(rootViewController: productsPharmacistViewController)
        
        let orderDetailsProcessingItemsViewController = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kOrderDetailsProcessingItemsVC)
        self.orderDetailsProcessingItemsViewController = UINavigationController(rootViewController: orderDetailsProcessingItemsViewController)
        
        
        let transactionListViewController = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kTransactionListVC)
        self.transactionListViewController = UINavigationController(rootViewController: transactionListViewController)
        
        let notificationVC = kMainStoryboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.notificationViewController = UINavigationController(rootViewController: notificationVC)

        
        //        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    //Mark:- Left menu protocol methods
    
    func changeViewController(_ menu: LeftMenuUser) {
        switch menu {
        case .home, .logout :
            self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
            

        case .medicines: self.slideMenuController()?.changeMainViewController(self.myOrdersViewController, close: true)

        case .account:             self.slideMenuController()?.changeMainViewController(self.myProfileViewController, close: true)

     
        case .notifications:
            self.slideMenuController()?.changeMainViewController(self.notificationViewController, close: true)
            
        case .cart:
            self.slideMenuController()?.changeMainViewController(self.transactionListViewController, close: true)
            
        case .labtests:
             self.slideMenuController()?.changeMainViewController(self.productsPharmacistViewController, close: true)
            
        case  .settings:
            self.slideMenuController()?.changeMainViewController(self.orderDetailsProcessingItemsViewController, close: true)
            
        default: break
        }
    }
    
    func changePharmaViewController(_ menu: LeftMenuPharma) {
        switch menu {
        case .home, .logout :
            self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
            
            
        case .medicines: self.slideMenuController()?.changeMainViewController(self.myOrdersViewController, close: true)
            
        case .account:             self.slideMenuController()?.changeMainViewController(self.myProfileViewController, close: true)
            
            
        case .notifications:
            self.slideMenuController()?.changeMainViewController(self.notificationViewController, close: true)
            
        case .cart:
            self.slideMenuController()?.changeMainViewController(self.transactionListViewController, close: true)
            
        case .labtests:
            self.slideMenuController()?.changeMainViewController(self.productsPharmacistViewController, close: true)
            
        case  .settings:
            self.slideMenuController()?.changeMainViewController(self.orderDetailsProcessingItemsViewController, close: true)
            
        default: break
        }
    }
}



extension LeftViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        // Header has fixed height
        if row == 0 {
            return 55.0
        }
        
        return sections[section].collapsed! ? 0 : 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        if sections[section].name == "Orders" {
            
            if let menu = LeftMenuUser(rawValue: sections[section].collapsed! ? section : section+row) {
                self.changeViewController(menu)
            }
        }else {
            if section > 1 {
                if let menu = LeftMenuUser(rawValue: section+2) {
                    self.changeViewController(menu)
                }
            }else{
                if let menu = LeftMenuUser(rawValue: section) {
                    self.changeViewController(menu)
                }
            }
        }
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        if self.tableView == scrollView {
    //
    //        }
    //    }
}
extension LeftViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // For section 1, the total count is items count plus the number of headers
        var count = sections.count
        
        for section in sections {
            count += section.items.count
        }
        return count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        
      /* var tableData:[SignUpModelClass] = SignUpModelClass.sharedInstance()
        let artistAndAlbum = tableData[section]
        imageHeaderView.lblName.text = artistAndAlbum.firstname + artistAndAlbum.lastname
        imageHeaderView.lblEmailID.text = artistAndAlbum.email
        imageHeaderView.profileImage.image = #imageLiteral(resourceName: "doctor")
 */
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell
            cell.titleLabel.text = sections[section].name
            cell.toggleButton.tag = section
            cell.iconImageView.image = UIImage.init(named: iconArray[section])
            if section > 1 {
                cell.iconImageView.image = UIImage.init(named: iconArray[section+2])
            }
            if sections[section].items.count > 0 {
                cell.toggleButton.isHidden = false;
                cell.toggleButton.addTarget(self, action: #selector(LeftViewController.toggleCollapse), for: .touchUpInside)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "subCell") as! SubCell
            cell.lblTitle.text = sections[section].items[row - 1]
            cell.imgIcon.image = UIImage.init(named: iconArray[section+row])
            return cell
        }
        
    }
   /*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageHeaderView") as! ImageHeaderView
        var tableData:[SignUpModelClass] = [SignUpModelClass]()
        let artistAndAlbum = tableData[section]
        cell.lblName.text = artistAndAlbum.firstname + artistAndAlbum.lastname
        cell.lblEmailID.text = artistAndAlbum.email
        cell.profileImage.image = #imageLiteral(resourceName: "doctor")
        return self.imageHeaderView;
    }
    */
    //
    // MARK: - Event Handlers
    //
    @objc func toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed!
        
        let indices = getHeaderIndices()
        
        let start = indices[section]
        let end = start + sections[section].items.count
        
        tableView.beginUpdates()
        for i in start ..< end + 1 {
            tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    //
    // MARK: - Helper Functions
    //
    func getSectionIndex(_ row: NSInteger) -> Int {
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    func getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        
        return index
    }
    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        for section in sections {
            indices.append(index)
            index += section.items.count + 1
        }
        
        return indices
    }
}
