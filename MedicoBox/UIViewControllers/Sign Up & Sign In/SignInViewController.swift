//
//  SignInViewController.swift
//  MedicoBox
//
//  Created by SBC on 18/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import SVProgressHUD
import SDWebImage

class SignInViewController: UIViewController,UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var btnSignIn: UIButton!
    
     @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var btnSignInwithOTP: UIButton!
    
    @IBOutlet weak var btnSignInwithFacebook: UIButton!
    
    @IBOutlet weak var btnSignInwithGoogle: UIButton!
    
    @IBOutlet weak var btnSignUpHere: UIButton!
    
    @IBOutlet var popUpBG: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var txtMobileEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        self.navigationController?.isNavigationBarHidden = true;

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func btnSignInAction(_ sender: Any) {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.createMenuView()
            
//        self.callSellerLoginAPI()
    }
    
    @IBAction func btnSignInWithOTPAction(_ sender: Any) {

        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kVerifyOTPVC)
 self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    @IBAction func btnSignUpHereAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignUpVC)
 self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        

        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kForgotPasswordFromMobileNoVC)

        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnSignInWithFacebookAction(_ sender: Any) {
        self.startExecutionForFacebookLogin()

    }
    
    @IBAction func btnSignInWithGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()

    }
   
    // MARK: - Facebook Login Implementation
    func startExecutionForFacebookLogin() -> Void
    {
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.web
        loginManager.logOut()
        
        loginManager.logIn(withReadPermissions: ["public_profile","email"], from: self) { (loginResult:FBSDKLoginManagerLoginResult?, error:Error?) in
            
            if (error != nil) {
                print("Error")
            }
            else if (loginResult?.isCancelled)!{
                print("Cancelled")
            }
            else {
                self.fetchUserInfoFromFacebook()
            }
        }
    }
    
    func fetchUserInfoFromFacebook() -> Void {
        
        if (FBSDKAccessToken.current() != nil) {
            
            let fbAccessToken = FBSDKAccessToken.current().tokenString
            
            let request = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "email,name,first_name,last_name,picture.type(large)"])
            request?.start(completionHandler: { (connection, result, error) in
                
                if (error == nil){
                    
                    if let responseDict : NSDictionary = result as? NSDictionary {
                        
                        print(responseDict);
                        
//                        self.firstNameString = responseDict.value(forKey: "first_name") as! String
//                        self.lastNameString = responseDict.value(forKey: "last_name") as! String
//                        self.emailIdString = responseDict.value(forKey: "email") as! String
                        
                        let a = responseDict.value(forKey: "picture") as! NSDictionary
                        let b = a.value(forKey: "data") as! NSDictionary
                        
//                        USER_FIRST_NAME = self.firstNameString
//                        USER_LAST_NAME = self.lastNameString
//                        USERNAME = self.emailIdString
//                        ACCOUNT_TYPE = "facebook"
//
//                        USER_PROFILE = b.value(forKey: "url") as! String
                       
                    }
                    
                    
                    let userData = result as! Dictionary<String, Any>
                    FBSDKAccessToken.refreshCurrentAccessToken({ (connection, result, error) in
                    })
                    self.fbLoginSuccessCall(userInfo: userData, token: fbAccessToken!)
                    
//                    self.callLoginAPI()
                }
                else {
                    print("Error in getting token")
                }
            })
        }
        else {
            print("Token not found !")
        }
    }
    
    func fbLoginSuccessCall(userInfo:[String:Any], token accessToken: String) -> Void {
        var dataDict = [String:Any]()
        dataDict = userInfo as Dictionary
        print(dataDict)
        
    }
 
    
    //MARK: - GIDSignInDelegate and GIDSignInUIDelegate
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(userId ?? "")
            print(idToken ?? "")
            print(fullName ?? "")
            print(givenName ?? "")
            print(familyName ?? "")
            print(email ?? "")
            // ...
            var dataDict = Dictionary<String,Any>()
            dataDict["social_name"] = fullName
            dataDict["social_email"] = email
            dataDict["social_site_name"] = "Google"
 
            print(dataDict)
//            self.callLoginAPI()

            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kHomeVC)

            self.navigationController?.pushViewController(Controller, animated: true)
            
        } else {
            
            print("\(error.localizedDescription)")
            
        }
    }
    
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                                  object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
//                self.statusText.text = userInfo["statusText"]!
            }
        }
    }
    
    func showPopUp() -> Void {
        
        self.popUpView.isHidden = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.popUpView.frame = (appDelegate.window?.bounds)!
        appDelegate.window?.addSubview(popUpView)
        self.view .bringSubview(toFront: popUpView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutside(sender:))
        )
        popUpBG.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapOutside(sender: UITapGestureRecognizer) {
        self.popUpView.isHidden = true
        print("Please Help!")
    }
    
    
    //--------------------------
    // MARK: - Login API Call
    //--------------------------
    
    func callLoginAPI() {
        
        var paraDict = NSMutableDictionary()
        var customerArr = NSDictionary()
        
         customerArr = ["email":"geet3@mitash.com","firstname":"geet","lastname":"Geet","store_id":"0"]
        paraDict =  ["customer": customerArr, "password": "ffggter.s@888"] as NSMutableDictionary
        
//        let jsonData1 = try! JSONSerialization.data(withJSONObject: paraDict, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let jsonString = NSString(data: jsonData1, encoding: String.Encoding.utf8.rawValue)! as String
//        print(paraDict) //, " \n ", jsonString)

        var i = Int()
        i = 0;
        let urlString = BASEURL+"/customers"
        let params: [String : Any]
        params = [
            "customer": [
                "email": "Geet@mitash.com",
                "firstname": "Geet",
                "lastname": "geet",
                "store_id": i
            ],
            "password": "ffggter.s@888"
            ] as [String : Any]
        
        print(urlString, paraDict)
        SVProgressHUD.show()
      
        let headers: HTTPHeaders = [
            "Authorization": "Info XXX",
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
                if let responseDict : NSArray = resposeData.result.value as? NSArray {
                
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.createMenuView()
                            print(responseDict);
                       
                    }
                   else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
                }
            })
        }
    }

    func callSellerLoginAPI() {
        
        var paraDict = NSMutableDictionary()
        paraDict =  ["username": "peters@mitash.com", "password": "Peter.s@888"] as NSMutableDictionary
        
        let urlString = "https://user8.itsindev.com/medibox/API/login.php"
//        let urlString = BASEURL + "/integration/customer/token"
        print(urlString, paraDict)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "bearer " + "KJF73RWHFI23R" ]
        
        Alamofire.request(urlString, method: .post, parameters: (paraDict as! [String : Any]), encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                
//                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.createMenuView()
                        print(resposeData.result.value);
                    }
                    else{
                        
//                        print(responseDict.value(forKey: "message")as! String)
//                        self.showToast(message : responseDict.value(forKey: "message")as! String)
                    }
//                }
            })
        }
    }

}

extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: []),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}
