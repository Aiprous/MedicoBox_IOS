//
//  OrderTrackingViewController.swift
//  MedicoBox
//
//  Created by SBC on 03/10/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class OrderTrackingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , CLLocationManagerDelegate, GMSMapViewDelegate,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var tblOrderItems: UITableView!
    @IBOutlet weak var lblPriceOrder: UILabel!
    
    @IBOutlet weak var gmsMapview: GMSMapView!
    
    //For map View
    var anInt: Int = 42
    var anOptionalInt: Int? = 42
    var anotherOptionalInt: Int?    // `nil` is the default when no value is provided
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    //    var gmsMapview =  GMSMapView()
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    var DriverStatus =  String()
    // The currently selected place.
    var selectedPlace: GMSPlace?
    var geocoderPick = CLGeocoder()
    var geocoderDrop = CLGeocoder()
    var polyline = GMSPolyline()
    var animationPolyline = GMSPolyline()
    var path = GMSPath()
    var animationPath = GMSMutablePath()
    var i: UInt = 0
    var timer: Timer!
    var user_location : CLLocationCoordinate2D = CLLocationCoordinate2D()
    var user_start_location : CLLocationCoordinate2D = CLLocationCoordinate2D()
    var marker = GMSMarker()
    var steps_array = [Steps]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tblOrderItems.separatorStyle = .none
    self.setNavigationBarItemBackButton()
       
        lblPriceOrder.text = "\u{20B9}" + " 350.00"

        self.navigationController?.isNavigationBarHidden = false;
        self.tblOrderItems.register(UINib(nibName: "OrderItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderItemsTableViewCell")
        tblOrderItems.delegate = self
        tblOrderItems.dataSource = self
        tblOrderItems.estimatedRowHeight = 130
        tblOrderItems.separatorStyle = .singleLine
        tblOrderItems.separatorColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tblOrderItems.frame.size.width, height: 1)
        footerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tblOrderItems.tableFooterView = footerView
        
        //MARK:-  Google Map
        gmsMapview.padding = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        gmsMapview.settings.myLocationButton = true
        gmsMapview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Add the map to the view, hide it until we've got a location update.
        placesClient = GMSPlacesClient.shared()
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
        self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters; // Will notify the LocationManager every 10 meters
        self.locationManager.desiredAccuracy = 1.0;
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItemBackButton()
        drowSourceToDestinationRoute()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        user_location = manager.location!.coordinate;
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 9.0)
        self.gmsMapview?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        
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
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            //            listLikelyPlaces(loc: location)
            
            self.setUpMarker(loc: location)
        }
        
    }
    
    //MARK:-
    func drowSourceToDestinationRoute()  {
        
        gmsMapview.clear()
        
        user_location = CLLocationCoordinate2D(latitude: 18.525500900000001, longitude: 73.867476300000007)
        user_start_location = CLLocationCoordinate2D(latitude: 19.076000000000001, longitude: 72.877758700000006)
        
        marker.position = CLLocationCoordinate2D(latitude: user_location.latitude, longitude: user_location.longitude)
        marker.title = "408, Dr Baba Saheb Ambedkar Rd, New Mangalwar Peth, Mangalwar Peth, Kasba Peth, Pune, Maharashtra 411011, India"
        //        marker.snippet = "ME"
        //        marker.icon = UIImage(named:"maps-and-flags")!.withRenderingMode(.alwaysTemplate)
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
        marker.map = gmsMapview
        let sourceLocation = user_location
        let destinationLocation = user_start_location
        getPolylineRoute(from: sourceLocation, to: destinationLocation)
        
    }
    
    func getdistancebetweensourceanddestination(from dict:Dictionary<String, Any>) -> (Int,Int) {
        let sourceLocation = CLLocationCoordinate2D(latitude: user_location.latitude , longitude: user_location.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: user_start_location.latitude, longitude: user_start_location.longitude)
        
        let dlocation = CLLocation(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)
        let slocation = CLLocation(latitude: sourceLocation.latitude, longitude: sourceLocation.longitude)
        
        let distance = slocation.distance(from: dlocation)
        let (distance_in_KM,meter) = metersToKiloMeters(meters: Int(distance))
        
        return (distance_in_KM,meter)
    }
    
    func metersToKiloMeters (meters : Int) -> (Int,Int) {
        return ((meters/1000), (meters%1000))
    }
    
    //MARK: -
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            //(("response : \(responseString)"))
            
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        let routes = json["routes"] as? [Any]
                        if (routes?.count)! > 0 {
                            let routeDict = routes?[0] as! Dictionary<String,Any>
                            var arrLeg = routeDict["legs"] as? [Any]
                            var dictleg = arrLeg?[0] as? Dictionary<String,Any>
                            let duration = dictleg?["duration"] as? Dictionary<String,Any>
                            let distance = dictleg?["distance"] as? Dictionary<String,Any>
                            let stpes = dictleg?["steps"] as? [Any]
                            //print(("response : \(stpes)"))
                            for case let dict as Dictionary<String,Any> in stpes! {
                                let step = Steps(step: dict)
                                self.steps_array.append(step)
                            }
                            let overview_polyline = routeDict["overview_polyline"] as? [AnyHashable: Any]
                            let polyString = overview_polyline?["points"] as?String
                            DispatchQueue.main.async {
                                
                                self.showPath(polyStr: polyString!)
                                //                                self.addMarker(From: routeDict)
                                
                                /* "end_address" = "CST Subway, Dhobi Talao, Chhatrapati Shivaji Terminus Area, Fort, Mumbai, Maharashtra 400001, India";
                                 "end_location" =     {
                                 lat = "18.9400869";
                                 lng = "72.83467759999999";
                                 };
                                 "start_address" = "408, Dr Baba Saheb Ambedkar Rd, New Mangalwar Peth, Mangalwar Peth, Kasba Peth, Pune, Maharashtra 411011, India";
                                 "start_location" =     {
                                 lat = "18.5254656";
                                 lng = "73.86745479999999";
                                 };
                                 */
                                
                                let startAddress = dictleg?["start_address"] as? String
                                let endAddress = dictleg?["end_address"] as? String
                                let startLocation = dictleg?["start_location"] as? Dictionary<String,Any>
                                let endLocation = dictleg?["end_location"] as? Dictionary<String,Any>
                                
                                let markerr = GMSMarker()
                                markerr.position = CLLocationCoordinate2D(latitude: self.user_start_location.latitude, longitude: self.user_start_location.longitude)
                                markerr.title = endAddress
                                //        marker.snippet = "ME"
                                //                                markerr.icon = UIImage(named:"maps-and-flags")!.withRenderingMode(.alwaysTemplate)
                                markerr.icon = GMSMarker.markerImage(with: UIColor.red)
                                markerr.map = self.gmsMapview
                                print(startLocation as Any,endLocation as Any)
                                
                            }
                        }
                    }
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = gmsMapview // Your map view
        polyline.strokeColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    func setUpLocation() {
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 50
        placesClient = GMSPlacesClient.shared()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    //Localtion manager Delegate
    
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
    /*
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
          
            let CITY = (containsPlacemark.locality != nil) ? containsPlacemark.locality! : ""
            let AREA = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality! : ""
            let  SUBAREA1 = (containsPlacemark.name != nil) ? containsPlacemark.name! : ""
            let SUBAREA2 = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality! : ""
            let STATE = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea! : ""
            let addressDictionary  = containsPlacemark.addressDictionary! as NSDictionary
            let address = containsPlacemark.addressDictionary?["FormattedAddressLines"] as? [String]
            //            print(STATE,addressDictionary)
            //            print(AREA,SUBAREA1,SUBAREA2)
            //            DRIVER_LOCATION = (address?.joined(separator: ", "))!
 
        }
 */
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error.localizedDescription)")
    }
    
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces(loc:CLLocation) {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            self.setUpMarker(loc: loc)
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
                
                print(self.likelyPlaces.count)
               /* for place in self.likelyPlaces{
                    
//                    self.setUpmarkers(place: place)
                }*/
            }
        })
    }
    func setUpMarker(loc:CLLocation) {
    
        let marker = GMSMarker()
        marker.position = loc.coordinate
        marker.title = "Current location"
        //        marker.icon = UIImage(named: "maps-and-flags")
        marker.icon = GMSMarker.markerImage(with: UIColor.magenta)
        marker.map = gmsMapview
        gmsMapview.camera = GMSCameraPosition.camera(withTarget: loc.coordinate, zoom: 7.5)
    }
    
    func setUpmarkers(place: GMSPlace){
        let marker = GMSMarker(position: (place.coordinate))
        marker.title = place.name
        marker.map = gmsMapview
        
    }
    
    
    
    
    //MARK:- Table View Delegate And DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellObj = tableView.dequeueReusableCell(withIdentifier: "OrderItemsTableViewCell") as! OrderItemsTableViewCell
        
        //        cellObj.lblOrderPrice.text = "\u{20B9}" + " 278.00"
        
        if(indexPath.row == 0){
            
            cellObj.lblTitleOrderItems.text = "Horicks Lite Badam Jar 450 gm"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblPriceOrderItems.underline()
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            //            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            
        }
        else if(indexPath.row == 1){
            
            cellObj.lblTitleOrderItems.text = "Combiflam Lcy Hot Fast Pain Relief Spray"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblPriceOrderItems.underline()
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")
            //            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            
        }
        else if(indexPath.row == 2){
            
            cellObj.lblTitleOrderItems.text = "Horicks Lite Badam Jar 450 gm"
            cellObj.lblSubTitleOrderItems.text = "Ecom Express (PayTM)"
            cellObj.lblTrasOrderItems.text = "Tracking ID"
            cellObj.lblPriceOrderItems.text = "1732938344"
            cellObj.lblMRPRateOrderItems.isHidden = true;
            cellObj.lblMRP.isHidden = true;
            cellObj.lblPriceOrderItems.underline()
//            cellObj.logoOrderItems.image = #imageLiteral(resourceName: "rx_logo")
            cellObj.imgOrderItems.image = #imageLiteral(resourceName: "capsules-icon")

        }
        
        cellObj.selectionStyle = .none
        return cellObj
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 98
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:OrderItemsTableViewCell = tableView.cellForRow(at: indexPath) as! OrderItemsTableViewCell
        
        //        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kOrderCancelVC)
        //        self.navigationController?.pushViewController(Controller!, animated: true)
        //
    }
   
    @IBAction func btnCancelOrderAction(_ sender: Any) {
        
        let Controller = self.storyboard?.instantiateViewController(withIdentifier: kOrderCancelVC)
        self.navigationController?.pushViewController(Controller!, animated: true)
    }
}
