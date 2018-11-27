//
//  EditProfileViewController.swift
//  MedicoBox
//
//  Created by SBC on 01/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class EditProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var userProfileData: SignUpModelClass?
    var myProfileData = [SignUpModelClass]()
    var DateString = String();
    var tomorrowString = String();
    var strDate = "";
    
    
    @IBOutlet weak var tblAddressField: UITableView!
    let arrayofText:NSArray = ["First name","Last name","Mobile number", "Email ID"]//,"Gender", "DOB", "Password", "Confirm Password"]
    var userProfileDataArray = NSArray();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell for tableview
        tblAddressField.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        tblAddressField.estimatedRowHeight = 65
        tblAddressField.separatorStyle = .none
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblAddressField.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblAddressField.tableFooterView = footerView
        
        //show navigationbar with back button
        self.setNavigationBarItemBackButton()
        self.navigationController?.isNavigationBarHidden = false;
        GetUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        tblAddressField.frame = CGRect(x: tblAddressField.frame.origin.x, y: tblAddressField.frame.origin.y, width: tblAddressField.frame.size.width, height: (CGFloat(65*arrayofText.count)));
        //
        //        self.view.setNeedsUpdateConstraints()
        if userProfileData != nil {
            tblAddressField.reloadData()
        }
        
    }
    @IBAction func SaveBtnAction(_ sender: Any) {
        
        UpdateUserInfo()
        //        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Table View Delegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayofText.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
        
        cellObj.textField.placeholder = arrayofText[indexPath.row] as? String
        if (userProfileData != nil) {
            switch arrayofText[indexPath.row] as? String {
            case "First name": cellObj.textField.text = userProfileData?.firstname
            break;
            case "Last name": cellObj.textField.text = userProfileData?.lastname
            break;
            case "Mobile number": cellObj.textField.text = userProfileData?.mobileNumber
            break;
            case "Email ID": cellObj.textField.text = userProfileData?.email
            break;
            case "Gender": cellObj.textField.text = "\(String(describing: userProfileData!.gender))"
            break;
            case "DOB": cellObj.textField.text = userProfileData?.dob
            break;
            case "Password": cellObj.textField.isSecureTextEntry = true
            break;
            case "Confirm Password": cellObj.textField.isSecureTextEntry = true
            break;
            default:
                break;
            }
        }
        
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 65
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
          let cell:AddressTableViewCell = tableView.cellForRow(at: indexPath) as! AddressTableViewCell
        
                switch arrayofText[indexPath.row] as? String {
                    
                case "DOB":
                
                let vc = UIViewController()
                vc.preferredContentSize = CGSize(width: 250,height: 300)
                let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
                vc.view.addSubview(pickerView)
                pickerView.datePickerMode = UIDatePickerMode.date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let today = Date()
                if let tomorrow = today.tomorrow {
                    tomorrowString = dateFormatter.string(from: tomorrow)
                    print("\(tomorrowString)")
                }
                pickerView.maximumDate = dateFormatter.date(from: tomorrowString)
                
                pickerView.addTarget(self, action: #selector(EditProfileViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
                
                let editRadiusAlert = UIAlertController(title: "Choose Date", message: "", preferredStyle: UIAlertControllerStyle.alert)
                editRadiusAlert.setValue(vc, forKey: "contentViewController")
                
                editRadiusAlert.addAction(UIAlertAction(title: "Set Date", style: .default, handler: {(action) -> Void in
                    
                    let dateFormatter = DateFormatter()
//                    2010-08-29 02:04:51
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateInString = dateFormatter.string(from: pickerView.date);
                    
                    self.strDate = dateInString
                    cell.textField.text = self.strDate;
                    
                }))
                editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(editRadiusAlert, animated: true)
                    break;
                    
                case "Gender":
                    
                     break;
                    
                default:
                    break;
               
        }
        
        
    }
    
    
    // Make a dateFormatter in which format you would like to display the selected date in the textfield.
    @objc func datePickerValueChanged(sender:UIDatePicker) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        DateString = dateFormatter.string(from: sender.date)
        return DateString
    }

    //--------------------------------
    // MARK: - Get Edit Profile API Call
    //--------------------------------
    
    func UpdateUserInfo()  {
        
        let urlString =  BASEURL + "/index.php/rest/V1/customers/me"
        
        print(urlString)
        
        SVProgressHUD.show()
        /* {
         "customer":{
         "confirmation": "string",
         "dob": "2010-08-29 02:04:51",
         "email": "geet@123.com",
         "firstname": "Geet",
         "lastname": "Geet",
         "middlename": "",
         "prefix": "MS",
         "suffix": "",
         "gender": "0",
         "store_Id": 1,
         "taxvat": "string",
         "websiteId": 1
         }
         }*/
        var param = [String: Any] ()
        param["websiteId"]         = 1
        param["id"]                = self.userProfileData?.id ?? 0
        param["email"]             = self.userProfileData?.email ?? ""
        param["dob"]               = "2010-08-29 02:04:51"
        param["firstname"]         = self.userProfileData?.firstname ?? ""
        param["lastname"]          = self.userProfileData?.lastname ?? ""
        param["confirmation"]      = "string"
        param["prefix"]            = "MS"
        param["gender"]            = 0
        param["store_Id"]          = 1
        param["taxvat"]            = "string"
        
        var customerParam = [String: Any] ()
        customerParam["customer"]  = param
        
        CustomerInfo .dataTask_PUT(Foundation.URL(string: urlString)!, method: .put, param: customerParam) { (response) in
            
            SVProgressHUD.dismiss()
            switch response{
                
            case .success(let dictionary as [String: Any]):
                
                print(dictionary)
                
                if (dictionary["id"] != nil) {
                    self.userProfileData = SignUpModelClass(signupModel: dictionary as NSDictionary)
                    self.showToast(message : "Profile updated successfully")
                }else{
                    print(dictionary["message"] ?? "")
                    self.showToast(message : dictionary["message"] as? String ?? "")
                }
                break
            case .failure( _):
                break
            default:
                break
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //--------------------------------
    // MARK: - Get My Profile API Call
    //--------------------------------
    
    func GetUserInfo()  {
        
        let urlString = kKeyGetUserProfileData
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        print(responseDict);
                        let jsonString = responseDict.value(forKey: "response")as? String
                        let jsonData = jsonString?.data(using: .utf8)!
                        let dictionary: NSDictionary = try! JSONSerialization.jsonObject(with: jsonData!, options: .mutableLeaves)as! NSDictionary
                        print(dictionary as Any)
                        self.userProfileData = SignUpModelClass(signupModel: dictionary)
                        let signup = SignUpModelClass(signupModel: dictionary )
                        self.myProfileData.append(signup)
                        
                     
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }
    
}
