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

class SignInViewController: UIViewController,UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate {

    @IBOutlet weak var btnSignIn: UIButton!
    
     @IBOutlet weak var btnForgotPassword: UIButton!
    
    @IBOutlet weak var btnSignInwithOTP: UIButton!
    
    @IBOutlet weak var btnSignInwithFacebook: UIButton!
    
    @IBOutlet weak var btnSignInwithGoogle: UIButton!
    
    @IBOutlet weak var btnSignUpHere: UIButton!
    
    @IBOutlet var popUpBG: UIImageView!
    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignInViewController.receiveToggleAuthUINotification(_:)),
                                               name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),
                                               object: nil)
        
//        statusText.text = "Initialized Swift app..."
        toggleAuthUI()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func btnSignInAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createMenuView()
    }
    
    @IBAction func btnSignInWithOTPAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: VERIFY_OTP_VCID)
        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    @IBAction func btnSignUpHereAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: SIGNUP_VCID)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: FORGOT_PASSWORD_VCID)
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
                    
//                    self.callAPI_getLoginAPI()
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
            
//            USER_FIRST_NAME = givenName! //first Name
//            USER_LAST_NAME = familyName! //last Name
//            USERNAME = email!
//            ACCOUNT_TYPE = "google"
            print(dataDict)
//            self.callAPI_getLoginAPI()
            
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: HOME_VCID)
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
    
    // [START toggle_auth]
    func toggleAuthUI() {
        /*
         if GIDSignIn.sharedInstance().hasAuthInKeychain() {
         // Signed in
         signInButton.isHidden = true
         signOutButton.isHidden = false
         disconnectButton.isHidden = false
         } else {
         signInButton.isHidden = false
         signOutButton.isHidden = true
         disconnectButton.isHidden = true
         statusText.text = "Google Sign in\niOS Demo"
         }
         */
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
            self.toggleAuthUI()
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
    
    
}
