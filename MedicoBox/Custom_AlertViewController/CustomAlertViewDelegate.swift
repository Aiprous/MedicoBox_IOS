//
//  CustomAlertViewDelegate.swift
//  CustomAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

protocol CustomAlertViewDelegate: class {
    func okButtonTapped(selectedOption: String, textFieldValue: String)
    func saveButtonTapped(wishlist_name_id:String)
}