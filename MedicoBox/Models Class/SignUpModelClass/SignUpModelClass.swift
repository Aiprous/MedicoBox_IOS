//
//  SignUpModelClass.swift
//  MedicoBox
//
//  Created by NCORD LLP on 12/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//


///// MARK:-  Data Response

/*
 {
 addresses =     (
 );
 "created_at" = "2018-10-12 10:08:06";
 "created_in" = English;
 "disable_auto_group_change" = 0;
 email = "Abc@gmail.com";
 "extension_attributes" =     {
 "is_subscribed" = 0;
 };
 firstname = Abc;
 "group_id" = 1;
 id = 80;
 lastname = Geet;
 "store_id" = 1;
 "updated_at" = "2018-10-12 10:08:06";
 "website_id" = 1;
 }
 
 */


import UIKit

class SignUpModelClass: NSObject {
    
    static var sharedInstance = SignUpModelClass()
    var addresses = NSArray();
    var extension_attributes = NSDictionary();
    var email = String()
    var firstname = String()
    var lastname = String()
    var created_in = String()
    var updated_at = String()
    var created_at = String()
    var group_id = Int()
    var id = Int()
    var gender = Int()
    var prefix = String()
    var store_id = Int()
    var website_id = Int()
    var disable_auto_group_change = Int()
    var is_subscribed = Int()
    var mobileNumber = String()
    var signupModel_Dict = Dictionary<String, Any>()
    var dob = String()
    
    init(signupModel:Dictionary<String, Any>) {
        super.init()
        self.signupModel_Dict = signupModel
        loadSignUpData()
    }
    
    func loadSignUpData(){
        
        addresses =  self.signupModel_Dict["addresses"]as! NSArray
        extension_attributes =  self.signupModel_Dict["extension_attributes"]as! NSDictionary
        email = self.signupModel_Dict["email"] as! String
        firstname = self.signupModel_Dict["firstname"] as! String
        lastname = self.signupModel_Dict["lastname"] as! String
        created_in = self.signupModel_Dict["created_in"] as! String
        updated_at = self.signupModel_Dict["updated_at"] as! String
        created_at = self.signupModel_Dict["created_at"] as! String
        group_id = self.signupModel_Dict["group_id"] as! Int
        id = self.signupModel_Dict["id"] as! Int
        store_id = self.signupModel_Dict["store_id"] as! Int
        website_id = self.signupModel_Dict["website_id"] as! Int
        store_id = self.signupModel_Dict["store_id"] as! Int
        disable_auto_group_change = self.signupModel_Dict["disable_auto_group_change"] as! Int
        is_subscribed = extension_attributes["is_subscribed"] as! Int
        gender = self.signupModel_Dict["gender"] as? Int ?? 0
        dob = self.signupModel_Dict["dob"] as! String
        prefix = self.signupModel_Dict["prefix"] as! String
    }
    
    class SignUpModelClass: NSObject {
        static let sharedInstance : SignUpModelClass = {
            let instance = SignUpModelClass()
            return instance
        }()
    }
    
}
