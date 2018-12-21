

import Foundation
import UIKit

@available(iOS 10.0, *)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

//Base url of App
let BASEURL = "http://user8.itsindev.com/medibox"

//http://user8.itsindev.com/medibox
//#MARK: - API Call

//Login Page API
let kKeyGetLoginTokenAPI = BASEURL + "/API/login.php"
let kKeyGetLoginUserData = BASEURL + "/API/customer_self.php"


//Register API
let kKeyRegisterAPI = BASEURL + "/API/register.php"

//My Account API
let kKeyGetUserProfileData =  BASEURL + "/API/customer_self.php"

//Home Page API


/// Product Deatils B API
let kKeyGetProductDetailBData =  BASEURL + "/API/single_product.php?product_id="


// Cart API
let kKeyGetCartDataAPI = BASEURL  + "/API/get_cart_item.php"
let kKeyEditCartAPI = BASEURL  + "/index.php/rest/V1/carts/mine/items/"
let kKeyDeleteCartAPI = BASEURL + "/index.php/rest/V1/carts/mine/items/"
let kKeyGetCartID = BASEURL + "/index.php/rest/V1/carts/mine"

//LoginWithOTP
//http://user8.itsindev.com/medibox/API/otp_login.php
let kKeyLoginOTP = BASEURL + "/API/otp_login.php"
let kKeyVerifyOTP = BASEURL + "/API/verify-login-otp.php"
let kKeySetNewPassword = BASEURL + "/API/set-new-password.php"

//Google APIs
let cinstantbaseUrl1 = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyA6zN2d9EifRnGoBTVX_dSvOJ5I7jg2Sec=true"

// Mark: StoryBoard
let kMainStoryboard = UIStoryboard(name: "Main", bundle: nil)
let kPrescriptionStoryBoard = UIStoryboard(name: "Prescription", bundle: nil)
let kCartStoryBoard = UIStoryboard(name: "Cart", bundle: nil)
let kPharmacistStoryBoard = UIStoryboard(name: "Pharmacist", bundle: nil)


//MARK: UIViewControllers
let kSignUpVC = "SignUpViewController"
let kSignInVC = "SignInViewController"
let kVerifyOTPVC = "VerifyOTPViewController"
let kHomeVC = "HomeViewController"
let kForgotPasswordFromMobileNoVC = "ForgotPasswordFromMobileNoViewController"
let kSetNewPasswordVC = "SetNewPasswordViewController"
let kProductDescriptionVC = "ProductDescriptionViewController"
let kInstaOrdersListVC = "InstaOrdersListViewController"
let kInstaOrderAddVC = "InstaOrderAddViewController"
let kDiabetesCareListVC = "DiabetesCareList"
let kProductDetailAVC = "ProductDetailAViewController"
let kProductDetailBVC = "ProductDetailBViewController"
let kUploadPrescriptionVC = "UploadPrescriptionViewController"
let kUploadPresriptionSecondVC = "UploadPresriptionSecondVC"
let kSelectAddressVC = "SelectAddressViewController"
let kMyOrdersVC = "MyOrdersViewController"
let kOrderCancelVC = "OrderCancelViewController"
let kOrderPlacedThankYouVC = "OrderPlacedThankYouViewController"
let kOrderSummaryVC = "OrderSummaryViewController"
let kOrderPlacedVC = "OrderPlacedViewController"
let kBillingAddressVC = "BillingAddressVC"
let kEditBillingAddressVC = "EditBillingAddressVC"
let kPaymentDetailVC = "PaymentDetailViewController"
let kCartViewController = "CartViewController"
let kCartOrderSummaryVC = "CartOrderSummaryVC"
let kMyProfileAccountVC = "MyProfileViewController"
let kEditProfileVC  = "EditProfileViewController"
let kNotificationVC = "NotificationViewController"
let kOrderTrackingVC = "OrderTrackingViewController"
let kMyOrdersDetailsVC = "MyOrdersDetailsViewController"
let kSignUpDeliveryBoyVC = "SignUpDeliveryBoyViewController"
let kAddDeliveryBoyVC = "AddDeliveryBoyViewController"
let kProductsPharmacistVC = "ProductsPharmacistViewController"
let kTransactionListVC = "TransactionListViewController"
let kSellerOrderVC = "SellerOrderViewController"
let kTransationDetailVC = "TransationDetailViewController"
let kOrderDetailsProcessingItemsVC = "OrderDetailsProcessingItemsViewController"
let kPharmacistDashboardVC = "PharmacistDashboardViewController"
let kPharmacistOrderItemVC = "PharmacistItemOrderViewController"
let kPharmacistShipmentVC = "PharmacistShipmentViewController"
let kPharmacistInvoiceVC = "PharmacistInvoiceViewController"
let kPageVC = "PageViewController"
let kMoreInformationVC =  "MoreInformationViewController"
let kWarningsAndPrecautionsVC =  "WarningsAndPrecautionsViewController"
let kUsageAndWorkVC =  "UsageAndWorkViewController"
let kInteractionsAndSideEffectsVC =  "InteractionsAndSideEffectsViewController"
let kSettingsVC = "SettingsViewController"
let kProductDrugInfoVC = "ProductDrugInfoViewController"
let kSearchVC = "SearchViewController"
let kCategoryVC = "CategoryViewController"
let kSubCategoryVC = "SubCategoryViewController"

// MARK: Image Constant
let kbackgroundColor  =  UIColor.init(hexString: "#d7e0e7")
let KNavigationBarColor = UIColor.init(hexString: "#fbc525")
let kButtonBackgroundColor = UIColor.init(hexString: "#1f2c4c")

//MARK: Keys
//var kLoginRole = ""
var kKeyResponseLoginToken = ""
var kKeyUserCartID = ""
var kKeyCartCount = ""
var kKeyProductID = ""
var kKeyProductQty = ""
var kKeyProductItemID = ""
var kKeySkuID = ""
