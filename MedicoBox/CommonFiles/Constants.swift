

import Foundation
import UIKit


@available(iOS 10.0, *)
let appDelegate = UIApplication.shared.delegate as? AppDelegate
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

//Base url of App
let BASEURL = "http://user8.itsindev.com/medibox/index.php/rest/V1"

//Google APIs
let cinstantbaseUrl1 = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyA6zN2d9EifRnGoBTVX_dSvOJ5I7jg2Sec=true"

//Menu buttons on Navigation Bar (Right and Left) Buttons

let API_TOKEN = " "

//APP Font
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


// MARK: Image Constant
let kbackgroundColor  =  UIColor.init(hexString: "#d7e0e7")
let KNavigationBarColor = UIColor.init(hexString: "#fbc525")
let kButtonBackgroundColor = UIColor.init(hexString: "#1f2c4c")

//MARK: Keys
//var kLoginRole = ""
