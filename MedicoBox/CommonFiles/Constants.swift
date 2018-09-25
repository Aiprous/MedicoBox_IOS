

import Foundation
import UIKit

let storyboard = UIStoryboard(name: "Main", bundle: nil)
@available(iOS 10.0, *)
let appDelegate = UIApplication.shared.delegate as? AppDelegate

//Base url of App
let BASEURL = ""

//Google APIs
let cinstantbaseUrl1 = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyAvcch62krh39WhOUx_ues02Xz-_oQZ3NA=true"

//Menu buttons on Navigation Bar (Right and Left) Buttons
var menuBtn = UIButton();
var rightBarBtn = UIButton();
var API_TOKEN = " "

//APP Font
var APPFONT = "SanFranciscoText"
var NAVIGATION_BAR_COLOR = #colorLiteral(red: 0.9503795505, green: 0.8861361742, blue: 0.2147655487, alpha: 1)

//View Controllers
var SIGNUP_VCID = "SignUpVCID"
var SIGNIN_VCID = "SignInVCID"
var VERIFY_OTP_VCID = "VerifyOTPVCID"
var HOME_VCID = "HomeVCID"
var MENU_VCID = "MenuVCID"
var FORGOT_PASSWORD_VCID = "ForgotPasswordFromMobileNoVCID"
var SET_NEW_PASSWORD_VCID = "SetNewPasswordVCID"
var PRODUCT_DESC_VCID = "ProductDescriptionVCID"
var INSTA_ORDERS_LIST_VCID = "InstaOrdersListVCID"
