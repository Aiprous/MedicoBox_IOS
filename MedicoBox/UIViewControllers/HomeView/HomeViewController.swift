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

class HomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, FSPagerViewDataSource,FSPagerViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet weak var medicoSearchBar: UISearchBar!
    @IBOutlet weak var FeaturedProductsCollectionView: UICollectionView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnLocation: UIButton!

    @IBOutlet weak var lblCurrentLocation: UILabel!
    var locationManager = CLLocationManager()

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        /// Search Bar Design Style
        if let textfield = medicoSearchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.textColor = UIColor.gray
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 1)
                backgroundview.layer.cornerRadius = 20
                backgroundview.clipsToBounds = true
            }
        }
        
        
        // badge label
        self.addBadgeLabel()
        
        //Collection View Add delegate and view Design
        self.FeaturedProductsCollectionView.register(UINib(nibName: "FeaturedProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedProductsCollectionCellID")
        
        FeaturedProductsCollectionView.dataSource = self
        FeaturedProductsCollectionView.delegate = self
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true;
        super.viewWillAppear(animated)
        
        locationManager.startUpdatingLocation()
        _ = CLLocationManager .authorizationStatus()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()    }
    
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
        label.text = "3"
        btnCart.addSubview(label);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        if(collectionView == FeaturedProductsCollectionView)
        {
            numberCount = 8;
            
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
    
    //MARK:- FSPager Delegate And DataSource
    
    //    var imagesNameArray = NSArray();
    fileprivate var imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    
    /// Asks your data source object for the number of items in the pager view.
    @objc(numberOfItemsInPagerView:) func numberOfItems(in pagerView: FSPagerView) -> Int {
        var numberCount:Int = Int()
        
        if(pagerView == firstPagerView){
            
            numberCount = self.imageNames.count
            
        }else{
            
            numberCount = self.imageNames.count
        }
        
        return numberCount;
    }
    
    @objc(pagerView:cellForItemAtIndex:) func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        
        
        if(pagerView == firstPagerView){
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellFirst", at: index)
            
            cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
            return cell
            
        }else{
            
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellSecond", at: index)
            
            /*  let dictObj = self.imagesNameArray[index] as! NSDictionary
             
             let URLstr = BASEURL + "/" + (dictObj.value(forKey: "file_name") as? String)!
             
             let urlimg = URL.init(string: URLstr)
             if urlimg != nil
             {
             cell.imageView?.sd_setImage(with: urlimg! , completed: { (image, error, cacheType, imageURL) in
             
             cell.imageView?.image = image
             })
             }
             */
            cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            cell.imageView?.contentMode = .scaleToFill   //.scaleAspectFill
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
            self.firstPageControl.numberOfPages = self.imageNames.count
            //            self.pageControl.contentHorizontalAlignment = .center
            self.firstPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.firstPageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
            self.firstPageControl.setFillColor(.gray, for: .normal)
            self.firstPageControl.setFillColor(.white, for: .selected)
            
        }
    }
    
    @IBOutlet weak var secondPageControl: FSPageControl!
        {
        didSet {
            self.firstPageControl.numberOfPages = self.imageNames.count
            //            self.pageControl.contentHorizontalAlignment = .center
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
        
        let Controller = kMainStoryboard.instantiateViewController(withIdentifier: kDiabetesCareListVC)
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
        self.locationManager.startUpdatingLocation()
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
            
//            AREA = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality! : ""
//
//            SUBAREA1 = (containsPlacemark.name != nil) ? containsPlacemark.name! : ""
//
//            SUBAREA2 = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality! : ""
//
//            STATE = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea! : ""
            
            let addressDictionary  = containsPlacemark.addressDictionary! as NSDictionary
            let address = containsPlacemark.addressDictionary?["FormattedAddressLines"] as? [String]
            //            print(STATE,addressDictionary)
            //            print(AREA,SUBAREA1,SUBAREA2)
//            USER_ADDRESS = (address?.joined(separator: ", "))!
            lblCurrentLocation.text = CITY
//            lblLandMark.text =  address?.joined(separator: ", ")
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
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        print("autocomplete")
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        self.dismiss(animated: true, completion: nil) // dismiss after select place
       
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("ERROR AUTO COMPLETE \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
}
