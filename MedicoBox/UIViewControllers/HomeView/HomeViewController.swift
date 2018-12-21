//
//  HomeViewController.swift
//  MedicoBox
//
//  Created by NCORD LLP on 19/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FSPagerView
import Alamofire
import SVProgressHUD
import SDWebImage
import CoreLocation

class HomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, FSPagerViewDataSource,FSPagerViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var medicoSearchBar: UISearchBar!
    @IBOutlet weak var FeaturedProductsCollectionView: UICollectionView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnLocation: UIButton!

    @IBOutlet weak var lblCurrentLocation: UILabel!
    var locationManager = CLLocationManager()
    var featuredProductsArray =  NSArray();
    var imageArray =  NSArray();
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        medicoSearchBar.delegate = self;
        if(kKeyCartCount != "0" && kKeyCartCount != ""){

            // badge label
            self.btnCart.isHidden = false;
            self.addBadgeLabel()
            
        }else{
            
            self.btnCart.isHidden = true;
            self.showToast(message: "Your cart is empty");
        }
        /// Search Bar Design Style
        if let textfield = medicoSearchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
//            textfield.delegate = self
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 20
                backgroundview.clipsToBounds = true
            }
        }
        
        //Collection View Add delegate and view Design
        self.FeaturedProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductsCollectionCellID")
        
        FeaturedProductsCollectionView.dataSource = self
        FeaturedProductsCollectionView.delegate = self
        
        _ = CLLocationManager .authorizationStatus()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
        self.view.isUserInteractionEnabled = false
        callAPIGetCartData()
    }
    
    func addBadgeLabel() {
        
        let label = UILabel(frame: CGRect(x: 17, y: -07, width: 15, height: 15))
        label.layer.borderColor =  UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.font = label.font.withSize(10)
        label.backgroundColor = .red
        label.text = kKeyCartCount
        btnCart.addSubview(label);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   //MARK:- SearchBar Delegate And DataSource
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.view .endEditing(true)
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kSearchVC)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        if(collectionView == FeaturedProductsCollectionView)
        {
            numberCount = featuredProductsArray.count;
            
        }
        return numberCount;
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        if(collectionView == FeaturedProductsCollectionView)
        {
            // get a reference to our storyboard cell
            let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedProductsCollectionCellID", for: indexPath as IndexPath) as! FeaturedProductCollectionViewCell
            
             let dictObj = featuredProductsArray.object(at: indexPath.row) as! NSDictionary
            
            cellObj.lblTitleFeaturedProducts.text = (dictObj.value(forKey: "name") as? String ?? "")!;
            cellObj.lblPriceFeaturedProducts.text =  "\u{20B9} " + (dictObj.value(forKey: "final_price") as? String ?? "")!;
            
            let price = Float(dictObj.value(forKey: "price") as? String ?? "")!
            let finalPrice  = Float(dictObj.value(forKey: "final_price") as? String ?? "")!
            //Calculate Discount 
                let offer: Float = price  - finalPrice;
                let discount: Float = offer / price * 100;
                let intdiscount = Int(discount);
            
            if(intdiscount == 0){
                
                cellObj.lblOfferPriceFeaturedProducts.text =  "No Offer";
                
            }else {
                
                cellObj.lblOfferPriceFeaturedProducts.isHidden = false;
                cellObj.lblOfferPriceFeaturedProducts.text =  String(intdiscount) + "% Off";
            }
                //strikeOnLabel
                let strikePrice = price
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .currency
                currencyFormatter.currencyCode = "INR"
                let priceInINR = currencyFormatter.string(from: strikePrice as NSNumber)
                let attributedString = NSMutableAttributedString(string: priceInINR!)
                attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
                cellObj.lblOfferFeaturedProducts.attributedText = attributedString;
            
            let URLstr =  (dictObj.value(forKey: "small_image") as? String ?? "")!
            let url = URL.init(string: URLstr )
            if url != nil
            {
                cellObj.imgFeaturedProducts.sd_setImage(with: url! , completed: { (image, error, cacheType, imageURL) in
                    
                    cellObj.imgFeaturedProducts.image = image
                    
                })
            }
            return cellObj;
        }
        
        return CommomCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == FeaturedProductsCollectionView)
        {
            let cell = collectionView.cellForItem(at: indexPath) as! FeaturedProductCollectionViewCell
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var value:CGSize = CGSize()
        if(collectionView == FeaturedProductsCollectionView)
        {
            value = CGSize(width: 204, height: 327)
        }
        
        return value;
    }
    
 /*   func strikeOnLabel(price: String){
        
        var priceNumber = NSNumber()
        if let myInteger = Int(price) {
             priceNumber = NSNumber(value:myInteger)
        }
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "INR"
        let priceInINR = currencyFormatter.string(from: priceNumber as NSNumber)
        
        let attributedString = NSMutableAttributedString(string: priceInINR!)
        
        // Swift 4.2 and above
        //        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        // Swift 4.1 and below
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        
        let priceAttributedString = attributedString.string
        return priceAttributedString;
        
    }
    */
    
    
    //MARK:- FSPager Delegate And DataSource
    
    //    var imagesNameArray = NSArray();
//    fileprivate var imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        var numberCount:Int = Int()
        
        if(pagerView == firstPagerView){
            
            numberCount = self.imageArray.count
            
        }else{
            
            numberCount = self.imageArray.count
        }
        
        return numberCount;
    }
    
    @objc(pagerView:cellForItemAtIndex:) func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        
        
        if(pagerView == firstPagerView){
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellFirst", at: index)
            
            let URLstr = self.imageArray[index] as! String
            let urlimg = URL.init(string: URLstr)
            if urlimg != nil
            {
                cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
                    
                    cell.imageView?.image = image
                })
            }
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            return cell
            
        }else{
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellSecond", at: index)
            
             let URLstr = self.imageArray[index] as! String
             let urlimg = URL.init(string: URLstr)
             if urlimg != nil
             {
                 cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
                 
                 cell.imageView?.image = image
             })
            }
 
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            return cell
            
        }
        
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if(pagerView == firstPagerView){
            
            pagerView.deselectItem(at: index, animated: true)
            
        }else{
            
            pagerView.deselectItem(at: index, animated: true)
            
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
        if(pagerView == firstPagerView){
            
            guard self.firstPageControl.currentPage != pagerView.currentIndex else {
                return
            }
            self.firstPageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
            
        }else{
            
            guard self.secondPageControl.currentPage != pagerView.currentIndex else {
                return
            }
            self.secondPageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
        }
    }
    
    @IBOutlet weak var firstPagerView: FSPagerView!
        {
        didSet {
            self.firstPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellFirst")
        }
        
    }
    
    @IBOutlet weak var secondPagerView: FSPagerView!
        {
        didSet {
            self.secondPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cellSecond")
        }
        
    }
    
    @IBOutlet weak var firstPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imageArray.count
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setStrokeColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(.gray, for: .selected)
            
        }
    }
    
    @IBOutlet weak var secondPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imageArray.count
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setFillColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(.white, for: .selected)
            
        }
    }
    
    fileprivate var styleIndex = 0 {
        
        didSet {
            // Clean up
            self.firstPageControl.setStrokeColor(nil, for: .normal)
            self.firstPageControl.setStrokeColor(nil, for: .selected)
            self.firstPageControl.setFillColor(nil, for: .normal)
            self.firstPageControl.setFillColor(nil, for: .selected)
            self.firstPageControl.setImage(nil, for: .normal)
            self.firstPageControl.setImage(nil, for: .selected)
            self.firstPageControl.setPath(nil, for: .normal)
            self.firstPageControl.setPath(nil, for: .selected)
            
            self.secondPageControl.setStrokeColor(nil, for: .normal)
            self.secondPageControl.setStrokeColor(nil, for: .selected)
            self.secondPageControl.setFillColor(nil, for: .normal)
            self.secondPageControl.setFillColor(nil, for: .selected)
            self.secondPageControl.setImage(nil, for: .normal)
            self.secondPageControl.setImage(nil, for: .selected)
            self.secondPageControl.setPath(nil, for: .normal)
            self.secondPageControl.setPath(nil, for: .selected)
            
            switch self.styleIndex {
            case 0:
                // Default
                // Automatic Sliding
                
                break
            case 1:
                // Ring
                self.firstPageControl.setStrokeColor(.green, for: .normal)
                self.firstPageControl.setStrokeColor(.green, for: .selected)
                self.firstPageControl.setFillColor(.green, for: .selected)
                self.secondPageControl.setStrokeColor(.green, for: .normal)
                self.secondPageControl.setStrokeColor(.green, for: .selected)
                self.secondPageControl.setFillColor(.green, for: .selected)
                
            case 2:
                // Image
                self.firstPageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.firstPageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
                self.secondPageControl.setImage(UIImage(named:"icon_footprint"), for: .normal)
                self.secondPageControl.setImage(UIImage(named:"icon_cat"), for: .selected)
                
            default:
                break
            }
            
            self.firstPagerView.reloadData()
            self.secondPagerView.reloadData()
            
        }
        
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        
        self.toggleLeft()
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    @IBAction func btnMEDICINESAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kCategoryVC)
 self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    
    @IBAction func btnLABTESTSAction(_ sender: Any) {
        
    }
    
    @IBAction func btnINSTAORDERSAction(_ sender: Any) {
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kInstaOrdersListVC)
 self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    @IBAction func btnECONSULTATIONAction(_ sender: Any) {
        
    }
    
    @IBAction func uploadPrescriptionAction(_ sender: Any) {

        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kUploadPrescriptionVC)
        self.navigationController?.pushViewController(Controller, animated: true)
        
    }
    @IBAction func cartBtnAction(_ sender: Any) {
        
        let Controller = kCartStoryBoard.instantiateViewController(withIdentifier: kCartViewController)
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
     @IBAction func btnLocationAction(_ sender: Any) {
    
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.present(autoCompleteController, animated: true, completion: nil)
        
    }
    
    //MARK: Location show
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)-> Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
          let  CITY = (containsPlacemark.locality != nil) ? containsPlacemark.locality! : ""

//            let addressDictionary  = containsPlacemark.addressDictionary! as NSDictionary
//            let address = containsPlacemark.addressDictionary?["FormattedAddressLines"] as? [String]
            self.lblCurrentLocation.text = CITY

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location:\(error.localizedDescription)")
    }
    
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                completion(country, city)
            }
        }
    }
    
    //-------------------------------------------
    // MARK: - Get Featured Products API Call
    //-------------------------------------------
    
    func callAPIGetProducts() {
        
        let urlString = BASEURL +  "/API/featured-products.php"
        SVProgressHUD.show()
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                self.view .isUserInteractionEnabled = true

                if let responseDict : NSArray = resposeData.result.value as? NSArray {
                    self.callAPIGetBannerImages()
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        print(responseDict);
                        
                        self.featuredProductsArray = responseDict;
                        self.FeaturedProductsCollectionView.reloadData()
                    }
                    else{
                        
                        self.showToast(message: responseDict.value(forKey: "message") as! String)
                        
                        print(responseDict.value(forKey: "message") as! String );
                        
                    }
                }
            })
        }
    }
    
    //-------------------------------------------
    // MARK: - Get Banners Images API Call
    //-------------------------------------------
    
    func callAPIGetBannerImages() {
        
        let urlString = BASEURL +  "/API/home-banners.php"
        print(urlString);
        SVProgressHUD.show()
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                SVProgressHUD.dismiss()
                self.view .isUserInteractionEnabled = true
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        print(responseDict);
                        
                        self.imageArray = responseDict.value(forKey: "response")as! NSArray;
                        self.firstPagerView.reloadData()
                        self.secondPagerView.reloadData()

                    }
                    else{
                        
                        self.showToast(message: responseDict.value(forKey: "message") as! String)
                        print(responseDict.value(forKey: "message") as! String );
                        
                    }
                    
                }
            })
        }
    }
    
    
    //--------------------------------
    // MARK: - Get Cart Data API Call
    //--------------------------------
    
    func callAPIGetCartData() {
        
        let urlString = kKeyGetCartDataAPI;
        print(urlString)
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Cache-Control": "no-cache",
            "authorization": "Bearer " + kAppDelegate.getLoginToken()]
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (resposeData) in
            
            DispatchQueue.main.async(execute: {() -> Void in
                //                SVProgressHUD.dismiss()
                self.callAPIGetProducts()
                
                if let responseDict : NSDictionary = resposeData.result.value as? NSDictionary {
                    
                    if ( resposeData.response!.statusCode == 200 || resposeData.response!.statusCode == 201)
                    {
                        
                        if((responseDict.value(forKey: "res")) != nil){
                            
                            let productsListArray = (responseDict.value(forKey: "res") as? NSArray ?? [] )!;
                            kKeyCartCount = String((productsListArray.count) as? Int ?? 0);
                            print(responseDict);
                            self.viewDidLoad()
                            
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
    
}

//-----------------------------------------------------------------
// MARK: - GMSAutocompleteViewControllerDelegate For Location
//-----------------------------------------------------------------


extension HomeViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        
        let addressComponents = place.addressComponents

        for component in addressComponents! {
            if component.type == "locality" {
                print(component.name)
                self.lblCurrentLocation.text = component.name
            }
        }
        self.locationManager.stopUpdatingLocation()
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
