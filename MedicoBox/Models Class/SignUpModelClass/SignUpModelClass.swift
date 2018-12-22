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

class SignUpModelClass: NSObject, NSCoding {
    
    static var sharedInstance = SignUpModelClass()
    var addresses = NSArray();
    var custom_attributes = NSArray();
    var extension_attributes = NSDictionary();
    var email = String()
    var firstname = String()
    var lastname = String()
    var created_in = String()
    var updated_at = String()
    var created_at = String()
    var group_id = Int()
    var id = Int()
    var store_id = Int()
    var website_id = Int()
    var disable_auto_group_change = Int()
    var is_subscribed = Int()
    var default_billing = Int()
    var default_shipping = Int()
    
    init(signupModel:NSDictionary) {
        super.init()
        loadSignUpData(signupModel: signupModel)
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.addresses, forKey: "addresses")
        aCoder.encode(self.custom_attributes, forKey: "custom_attributes")
        aCoder.encode(self.extension_attributes, forKey: "extension_attributes")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.firstname, forKey: "firstname")
        aCoder.encode(self.lastname, forKey: "lastname")
        aCoder.encode(self.created_in, forKey: "created_in")
        aCoder.encode(self.updated_at, forKey: "updated_at")
        aCoder.encode(self.created_at, forKey: "created_at")
        aCoder.encode(self.group_id, forKey: "group_id")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.store_id, forKey: "store_id")
        aCoder.encode(self.website_id, forKey: "website_id")
        aCoder.encode(self.disable_auto_group_change, forKey: "disable_auto_group_change")
        aCoder.encode(self.is_subscribed, forKey: "is_subscribed")
        aCoder.encode(self.default_billing, forKey: "default_billing")
        aCoder.encode(self.default_shipping, forKey: "default_shipping")
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.addresses = aDecoder.decodeObject(forKey:  "addresses")as? NSArray ?? [];
        self.custom_attributes =  aDecoder.decodeObject(forKey: "custom_attributes")as? NSArray ?? [];
        self.extension_attributes =  aDecoder.decodeObject(forKey: "extension_attributes")as? NSDictionary ?? [:];
        self.email = aDecoder.decodeObject(forKey: "email")as? String ?? ""
        self.firstname = aDecoder.decodeObject(forKey: "firstname")as? String ?? ""
        self.lastname = aDecoder.decodeObject(forKey:  "lastname")as? String ?? ""
        self.lastname = aDecoder.decodeObject(forKey:  "created_in")as? String ?? ""
        self.lastname = aDecoder.decodeObject(forKey: "updated_at")as? String ?? ""
        self.lastname = aDecoder.decodeObject(forKey:  "created_at")as? String ?? ""
        self.group_id = aDecoder.decodeObject(forKey: "group_id")as? Int ?? 0
        self.id = aDecoder.decodeObject(forKey: "id")as? Int ?? 0
        self.store_id = aDecoder.decodeObject(forKey: "store_id")as? Int ?? 0
        self.website_id = aDecoder.decodeObject(forKey:  "website_id")as? Int ?? 0
        self.disable_auto_group_change = aDecoder.decodeObject(forKey:  "disable_auto_group_change")as? Int ?? 0
        self.is_subscribed = aDecoder.decodeObject(forKey:  "is_subscribed")as? Int ?? 0
        self.default_billing = aDecoder.decodeObject(forKey: "default_billing")as? Int ?? 0
        self.default_shipping = aDecoder.decodeObject(forKey: "default_shipping")as? Int ?? 0
    }
    
    func loadSignUpData(signupModel: NSDictionary){
        
        addresses =  signupModel["addresses"]as? NSArray ?? [];
        custom_attributes =  signupModel["custom_attributes"]as? NSArray ?? [];
        extension_attributes =  signupModel["extension_attributes"]as? NSDictionary ?? [:];
        email = signupModel["email"] as? String ?? ""
        firstname = signupModel["firstname"] as? String ?? ""
        lastname = signupModel["lastname"] as? String ?? ""
        created_in = signupModel["created_in"] as? String ?? ""
        updated_at = signupModel["updated_at"] as? String ?? ""
        created_at = signupModel["created_at"] as? String ?? ""
        group_id = signupModel["group_id"] as? Int ?? 0
        id = signupModel["id"] as? Int ?? 0
        store_id = signupModel["store_id"] as? Int ?? 0
        website_id = signupModel["website_id"] as? Int ?? 0
        store_id = signupModel["store_id"] as? Int ?? 0
        disable_auto_group_change = signupModel["disable_auto_group_change"] as? Int ?? 0
        is_subscribed = extension_attributes["is_subscribed"] as? Int ?? 0
        default_billing = signupModel["default_billing"] as? Int ?? 0
        default_shipping = signupModel["default_shipping"] as? Int ?? 0
    }
    
    class SignUpModelClass: NSObject {
        static let sharedInstance : SignUpModelClass = {
            let instance = SignUpModelClass()
            return instance
        }()
    }
    
}
