//
//  AppDelegate.swift
//  MedicoBox
//
//  Created by SBC on 14/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces
import Firebase
import Fabric
import Crashlytics
import Alamofire
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    
    var window: UIWindow?
    var userProfileData: SignUpModelClass?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)
        navigationBarAppearace.barTintColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0, alpha: 1)
        
        
        if(UserDefaults.standard.value(forKey: "loginToken") as? String ?? "" == ""){
            
            let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSignInVC)
            let nvc: UINavigationController = UINavigationController(rootViewController: Controller)
            self.window?.rootViewController = nvc
            self.window?.makeKeyAndVisible()
        }
        else{
            
            self.callAPIGetCartData()
            self.callAPIGetCartID()
            createMenuView()
        }
        
        
        
        /*
         //Get Cart Id only once
         let returnValue: String = (UserDefaults.standard.object(forKey: "kKeyUserCartID") as? String)!
         kKeyUserCartID = returnValue;
         
         if(kKeyUserCartID == ""){
         
         self.callAPIGetCartID()
         
         }else{
         
         }
         */
        
        
        FIRApp.configure()
        Fabric.with([Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GMSServices.provideAPIKey("AIzaSyA6zN2d9EifRnGoBTVX_dSvOJ5I7jg2Sec")
        GMSPlacesClient.provideAPIKey("AIzaSyA6zN2d9EifRnGoBTVX_dSvOJ5I7jg2Sec")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("support@medicobox.com")
        Crashlytics.sharedInstance().setUserIdentifier("mbsupport@24 ")
        Crashlytics.sharedInstance().setUserName("Test User")
    }
    
    
    ///// GOOGLE LOGIN
    
    // [END openurl]
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    // [START signin_handler]
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // [START_EXCLUDE]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
            // [END_EXCLUDE]
        }
        guard let authentication = user.authentication else { return }
        //        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        // ...
    }
    // [END signin_handler]
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    
    ///// FACEBOOK LOGIN
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        GIDSignIn.sharedInstance().handle(url,
                                          sourceApplication: sourceApplication,
                                          annotation: annotation)
        return true
    }
    
    func application(application: UIApplication, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        //Even though the Facebook SDK can make this determinitaion on its own,
        //let's make sure that the facebook SDK only sees urls intended for it,
        //facebook has enough info already!
        let isFacebookURL = url.scheme != nil && url.scheme!.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
        if isFacebookURL {
            return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
        }
        return false
    }
    
    //    Pragma Mark: create menu
    func createMenuView() {
        
        // create viewController code...
        
        let homeViewController = kMainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let leftViewController = kMainStoryboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: homeViewController)
        
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        leftViewController.homeViewController = nvc
        if self.userProfileData != nil {
            leftViewController.userProfileData = self.userProfileData;
        }
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = homeViewController as? SlideMenuControllerDelegate
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
    }
    
    func setLoginToken(loginToken:String)  {
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(loginToken, forKey: "loginToken")
        kUserDefault.synchronize()
        
    }
    
    func getLoginToken() -> String {
        if let token = UserDefaults.standard.value(forKey: "loginToken")  {
            return token as! String
        }
        return ""
    }
    
    func setLoginUserData(loginUserData:SignUpModelClass)  {
        let myData = NSKeyedArchiver.archivedData(withRootObject: loginUserData)
        let kUserDefault = UserDefaults.standard
        kUserDefault.set(myData, forKey: "loginUserData")
        //        kUserDefault.set(loginUserData, forKey: "loginUserData")
        kUserDefault.synchronize()
    }
    
    func getLoginUserData() -> SignUpModelClass {
        
        let unarchivedObject = UserDefaults.standard.object(forKey: "loginUserData") as? NSData
        let loginUserData = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject! as Data) as? SignUpModelClass
        return loginUserData as! SignUpModelClass
        
    }
    
    
    
    //--------------------------------
    // MARK: - Get Cart Data API Call
    //--------------------------------
    
    func callAPIGetCartData() {
        
        let urlString = kKeyGetCartDataAPI;
        print(urlString)
        //        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                //                SVProgressHUD.dismiss()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        if((responseDict.value(forKey: "res")) != nil){
                            
                            let productsListArray = (responseDict.value(forKey: "res") as? NSArray ?? [] )!;
                            kKeyCartCount = String((productsListArray.count) as? Int ?? 0);
                            //                        UserDefaults.standard.set(productsListArray, forKey: "CartArray")
                            print(responseDict);
                            
                        }else {
                            
                            print("Your cart is empty. Please add items in your cart ")
                        }
                    }
                    else{
                        
                        print(responseDict.value(forKey: "message")as! String)
                        
                    }
                }
            })
        }
    }
    
    //--------------------------------
    // MARK: - Get Cart ID API Call
    //--------------------------------
    
    func callAPIGetCartID() {
        
        let urlString = kKeyGetCartID
        print(urlString)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "Authorization": "Bearer " + kAppDelegate.getLoginToken() ]
        
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                //                SVProgressHUD.dismiss()
                if let responseDict: String = resposeData.result.value as? String ?? "" {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        kKeyUserCartID = responseDict;
                        UserDefaults.standard.set(kKeyUserCartID, forKey: "kKeyUserCartID")
                    }
                    else{
                        
                    }
                }
            })
        }
    }
    
    
}
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

