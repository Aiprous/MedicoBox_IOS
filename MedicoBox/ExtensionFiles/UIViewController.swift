//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        
//        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "cart")!)
        self.addTitleSearchBar()
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    func setNavigationBarItemBackButton() {
        
        //        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)
        self.addLeftBarButtonWithBackImage(UIImage(named: "back-arrow")!)
        self.addRightBarButtonWithImage(UIImage(named: "cart")!)
        self.addTitleSearchBar()
//        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.removeRightGestures()
//        self.slideMenuController()?.addLeftGestures()
//        self.slideMenuController()?.addRightGestures()
    }
    
    public func addLeftBarButtonWithBackImage(_ buttonImage: UIImage) {
        
        // button
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        leftButton.setBackgroundImage(buttonImage, for: .normal)
        leftButton.addTarget(self, action: #selector(self.backView), for: .touchUpInside)
        let leftBarButtomItem = UIBarButtonItem(customView: leftButton)
        
        let iconButton:UIButton = UIButton(type: UIButtonType.custom)
        iconButton.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        iconButton.setImage(UIImage(named: "plus_AppIcon"), for: .normal)
        let leftIconBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: iconButton)
        navigationItem.leftBarButtonItems = [leftBarButtomItem, leftIconBarButtonItem]
        
    }
    
    @objc public func backView(){
        self.navigationController?.popViewController(animated: true)
    }
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
