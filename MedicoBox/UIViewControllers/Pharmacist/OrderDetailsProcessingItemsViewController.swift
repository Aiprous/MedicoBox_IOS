//
//  OrderDetailsProcessingItemsViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 08/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class OrderDetailsProcessingItemsViewController: UIViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var itemsOrderedBtn: UIButton!
    @IBOutlet weak var itemsOrderedBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var invoiceBtn: UIButton!
    @IBOutlet weak var invoiceBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shipmentsBtn: UIButton!
    @IBOutlet weak var shipmentsBtnBottomConstraint: NSLayoutConstraint!
    var pageViewController = UIPageViewController()
    var pageViewArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemsOrderedBtn.isSelected = true
        self.invoiceBtn.isSelected = false
        self.shipmentsBtn.isSelected = false
        
       
        self.itemsOrderedBottomConstraint.constant = 2
        self.invoiceBtnBottomConstraint.constant = 0
        self.shipmentsBtnBottomConstraint.constant = 0
        self.topContainer.layoutIfNeeded()
        
        self.itemsOrderedBtn.setTitleColor(.black, for: .selected)
        self.invoiceBtn.setTitleColor(.black, for: .selected)
        self.shipmentsBtn.setTitleColor(.black, for: .selected)
        
        
        //Pageviewcontroller setup
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let page1: UIViewController! = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kPharmacistOrderItemVC)
        let page2: UIViewController! = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kPharmacistInvoiceVC)
        let page3: UIViewController! = kPharmacistStoryBoard.instantiateViewController(withIdentifier: kPharmacistShipmentVC)
        
        pageViewArray.append(page1);
        pageViewArray.append(page2);
        pageViewArray.append(page3);
        self.addChildViewController(pageViewController)
        self.pageViewController.view.frame = self.containerView.bounds
        self.containerView.addSubview(self.pageViewController.view)
        self.pageViewController.setViewControllers([pageViewArray[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        if( self.itemsOrderedBtn.isSelected) {
            
        }else if( self.invoiceBtn.isSelected){
            
        }else{
            
        }
    }
   
    //MARK:// Button action
    @IBAction func topActionBtnTapped(_ sender: UIButton) {
        
        let btn = sender
        if (btn == self.itemsOrderedBtn){
            
            if !btn.isSelected {
                
                self.topBtnClickAnimation(self.itemsOrderedBtn)
                self.pageViewController .setViewControllers([pageViewArray[0]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
            }
            
        }else if (btn == self.invoiceBtn){
            
            if !btn.isSelected {
                
                self.topBtnClickAnimation(self.invoiceBtn)
                self.pageViewController .setViewControllers([pageViewArray[1]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            }
        }
        else{
         
         if !btn.isSelected {
            self.topBtnClickAnimation(btn)
            self.pageViewController .setViewControllers([pageViewArray[2]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            }
        }
    }
    
    func topBtnClickAnimation(_ sender:UIButton) {
        let btn = sender
        if (btn == self.itemsOrderedBtn){
            
            if !btn.isSelected {
                
                btn.isSelected = true
                self.itemsOrderedBtn.isSelected = true
                self.invoiceBtn.isSelected = false
                self.shipmentsBtn.isSelected = false
                self.itemsOrderedBottomConstraint.constant = 2
                self.invoiceBtnBottomConstraint.constant = 0
                self.shipmentsBtnBottomConstraint.constant = 0
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.topContainer.layoutIfNeeded()
                })
                
            }
            
        }else if (btn == self.invoiceBtn){
            
            if !btn.isSelected {
                
                btn.isSelected = true
                self.itemsOrderedBtn.isSelected = false
                self.invoiceBtn.isSelected = true
                self.shipmentsBtn.isSelected = false
                self.itemsOrderedBottomConstraint.constant = 0
                self.invoiceBtnBottomConstraint.constant = 2
                self.shipmentsBtnBottomConstraint.constant = 0
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.topContainer.layoutIfNeeded()
                })
               
            }
        }
        else{
            
            if !btn.isSelected {
                btn.isSelected = true
                self.itemsOrderedBtn.isSelected = false
                self.invoiceBtn.isSelected = false
                self.shipmentsBtn.isSelected = true
                self.itemsOrderedBottomConstraint.constant = 0
                self.invoiceBtnBottomConstraint.constant = 0
                self.shipmentsBtnBottomConstraint.constant = 2
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.topContainer.layoutIfNeeded()
                })
                
            }
        }
    }
    
    //Feature use
    func updateBottomHighLighter() {
        
        let layer = CALayer()
        
        layer.backgroundColor = UIColor.blue.cgColor
        
        layer.name = "bootomLayerBlue"
        
        
        if self.itemsOrderedBtn.isSelected {
            
            var rect = self.itemsOrderedBtn.frame
            
            rect.origin.y = rect.origin.y + rect.size.height - 2
            rect.size.height = 2
            layer.frame = rect
            
            self.topContainer.layer.addSublayer(layer)
            
        }else if(self.invoiceBtn.isSelected ){
            
            var rect = self.invoiceBtn.frame
            
            rect.origin.y = rect.origin.y + rect.size.height - 2
            rect.size.height = 2
            layer.frame = rect
            
            self.topContainer.layer.addSublayer(layer)
        }
        else{
         
         var rect = self.shipmentsBtn.frame
         
         rect.origin.y = rect.origin.y + rect.size.height - 3
         rect.size.height = 3
         layer.frame = rect
         
         self.topContainer.layer.addSublayer(layer)
         
         }
        
    }

// MARK: - PageViewController DataSource

func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    guard let viewControllerIndex = pageViewArray.index(of: viewController) else {
        return nil
    }
    
    switch viewControllerIndex {
    case 0: self.topBtnClickAnimation(self.itemsOrderedBtn); break;
    case 1: self.topBtnClickAnimation(self.invoiceBtn); break;
    case 2: self.topBtnClickAnimation(self.shipmentsBtn); break;
    default:break;
    }
    let nextIndex = viewControllerIndex + 1
    
    let pageViewControllersCount = pageViewArray.count
    
    guard pageViewControllersCount != nextIndex else {
        return nil
    }
    
    guard pageViewControllersCount > nextIndex else {
        return nil
    }
//    let currentIndex = pageViewArray.index(of: viewController)
//    let nextIndex = abs((currentIndex! + 1) % pageViewArray.count)
    
    
    return pageViewArray[nextIndex]
}

func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    guard let viewControllerIndex = pageViewArray.index(of: viewController) else {
        return nil
    }
    switch viewControllerIndex {
    case 0: self.topBtnClickAnimation(self.itemsOrderedBtn); break;
    case 1: self.topBtnClickAnimation(self.invoiceBtn); break;
    case 2: self.topBtnClickAnimation(self.shipmentsBtn); break;
    default:break;
    }
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
        return nil
    }
    
    guard pageViewArray.count > previousIndex else {
        return nil
    }
    
//    let currentIndex = pageViewArray.index(of: viewController)
//    let previousIndex = abs((currentIndex! - 1) % pageViewArray.count)
    
    return pageViewArray[previousIndex]
}

}
