

import Foundation
import UIKit


@available(iOS 10.0, *)
let appDelegate = UIApplication.shared.delegate as? AppDelegate
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

//Base url of App
let BASEURL = ""

//Google APIs
let cinstantbaseUrl1 = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyAvcch62krh39WhOUx_ues02Xz-_oQZ3NA=true"

//Menu buttons on Navigation Bar (Right and Left) Buttons

let API_TOKEN = " "

//APP Font
// Mark: StoryBoard
let kMainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let kPrescriptionStoryBoard = UIStoryboard(name: "Prescription", bundle: nil)
let kCartStoryBoard = UIStoryboard(name: "Cart", bundle: nil)

//View Controllers
let SIGNUP_VCID = "SignUpVCID"
let SIGNIN_VCID = "SignInVCID"
let VERIFY_OTP_VCID = "VerifyOTPVCID"
let HOME_VCID = "HomeViewController"
let MENU_VCID = "MenuVCID"
let FORGOT_PASSWORD_VCID = "ForgotPasswordFromMobileNoVCID"
let SET_NEW_PASSWORD_VCID = "SetNewPasswordVCID"
let PRODUCT_DESC_VCID = "ProductDescriptionVCID"
let INSTA_ORDERS_LIST_VCID = "InstaOrdersListVCID"
let INSTA_ORDER_ADD_VCID = "InstaOrderAddVCID"
let DIBETES_CARE_LIST_VCID = "DiabetesCareList"
let PRODUCT_DETAIL_A_VCID = "ProductDetailAViewController"
let PRODUCT_DETAIL_B_VCID = "ProductDetailBViewController"
let UPLOAD_PRESCRIPTION_VCID = "UploadPrescriptionViewController"
let UPLOAD_PRESCRIPTION_SECOND_VCID = "UploadPresriptionSecondVC"
let UPLOAD_PRESCRIPTION_SELECT_ADDRESS_VCID = "SelectAddressViewController"
let kOrderSummaryVC = "OrderSummaryViewController"
let kOrderPlacedVC = "OrderPlacedViewController"
let kBillingAddressVC = "BillingAddressVC"
let kPaymentDetailVC = "PaymentDetailViewController"
let kCartViewController = "CartViewController"
let kCartOrderSummaryVC = "CartOrderSummaryVC"

// MARK: Image Constant
let kbackgroundColor  =  UIColor.init(hexString: "#d7e0e7")
let KNavigationBarColor = UIColor.init(hexString: "#fbc525")
let kButtonBackgroundColor = UIColor.init(hexString: "#1f2c4c")

