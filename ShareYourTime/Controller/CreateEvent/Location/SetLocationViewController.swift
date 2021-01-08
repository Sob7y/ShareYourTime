//
//  SetLocationViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import GooglePlacesSearchController
import Pulsator

protocol LocationDelegate: class {
    func setLocation(lat:Double, lng:Double)
}

class SetLocationViewController: BaseViewController {
    
    @IBOutlet weak var mapView:GMSMapView!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var searchBtn:UIButton!
    @IBOutlet weak var confirmLocationBtn:UIButton!
    @IBOutlet private weak var mapImageView: UIImageView!
    @IBOutlet private weak var locationTitleLabel: UILabel!

    weak var delegate: LocationDelegate?
    var pulsator = Pulsator()
    var address: String? {
        didSet {
            locationTitleLabel.text = address
        }
    }

    var lat:Double!
    var lng:Double!
    let GoogleMapsAPIServerKey = "AIzaSyA1bvzB8d_uH6TbiStTNt9Cfa1c8Xu_QNo"

    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .address
        )
        controller.searchBar.showsCancelButton = false
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pulsator.position = mapImageView.layer.position
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidLoad()
//        pulsator.position = mapImageView.layer.position
//    }
    
    func setupView() {
        if UserDefaults.standard.value(forKey: Constant.keys.key_latitude) != nil {
            let lat = UserDefaults.standard.value(forKey: Constant.keys.key_latitude) as! Double
            let lng = UserDefaults.standard.value(forKey: Constant.keys.key_longitude) as! Double
            
            let location = CLLocationCoordinate2DMake(lat, lng)
            AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
        } else {
            let lat:Double = 30
            let lng:Double = 29
            
            let location = CLLocationCoordinate2DMake(lat, lng)
            AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
        }
        
        let image = UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate)
        searchBtn.setImage(image, for: .normal)
        searchBtn.tintColor = UIColor.lightSlateGray
        
        confirmLocationBtn.setTitle(Strings.sharedInstance.confirmLocation, for: .normal)
        
//        locationTitleLabel
        mapImageView.layer.superlayer?.insertSublayer(pulsator, below: mapImageView.layer)
        pulsator.numPulse = 3
        pulsator.radius = 100
        pulsator.start()
    }
    
    @IBAction func closeView(_ sender:Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func confirmLocation(_ sender:UIButton){
        delegate?.setLocation(lat:lat, lng: lng)
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func searchOnMap(_ sender:Any){
        present(placesSearchController, animated: true, completion: nil)
    }
    
//    lazy var placesSearchController: GooglePlacesSearchController = {
//        let controller = GooglePlacesSearchController(delegate: self,
//                                                      apiKey: GoogleMapsAPIServerKey,
//                                                      placeType: .address
//        )
//        return controller
//    }()
    
    func AddGoogleMapsWithLocation(location:CLLocationCoordinate2D, currentZoom:Float)
    {
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: currentZoom, bearing: 0, viewingAngle: 0)
        
        mapView.isBuildingsEnabled = true
        mapView.isMyLocationEnabled = true
        
//        do {
//            // Set the map style by passing the URL of the local file.
//            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
//                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
//            } else {
//                print("Unable to find style.json")
//            }
//        } catch {
//            print("The style definition could not be loaded: \(error)")
//        }
        
        mapView.delegate = self;
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.animate(to: camera)
    }

}

/*
extension SetLocationViewController:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        addMarkerToMap(lat: coordinate.latitude, lng: coordinate.longitude)
        delegate?.setLocation(lat:mapView.camera.target.latitude, lng: mapView.camera.target.longitude)
    }
    
    func addMarkerToMap(lat:Double, lng:Double){
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = ""
        marker.icon = UIImage(named:"location_marker")
        marker.map = mapView
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        lat = mapView.camera.target.latitude
        lng = mapView.camera.target.longitude
        //        delegate?.setRequestLocation(lat:mapView.camera.target.latitude, lng: mapView.camera.target.longitude)
    }
}
*/

extension SetLocationViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if (gesture) {
            print("dragged")
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        lat = mapView.camera.target.latitude
        lng = mapView.camera.target.longitude
        delegate?.setLocation(lat:mapView.camera.target.latitude, lng: mapView.camera.target.longitude)
        getAddress(lat: position.target.latitude, lng: position.target.longitude)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        self.latitude = coordinate.latitude
//        self.longitude = coordinate.longitude
//        addMarkerToMap(lat: coordinate.latitude, lng: coordinate.longitude)
//        getAddress(lat: coordinate.latitude, lng: coordinate.longitude)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        present(placesSearchController, animated: true, completion: nil)
    }
}

/*
extension SetLocationViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
}
*/

extension SetLocationViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(
            withLatitude: place.coordinate.latitude,
            longitude: place.coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        lat = place.coordinate.latitude
        lng = place.coordinate.longitude
       
        getAddress(lat: place.coordinate.latitude, lng: place.coordinate.longitude)
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.dismiss(animated: true, completion: nil) // dismiss after select place
    }
    
    func addMarkerToMap(lat: Double, lng: Double) {
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = ""
        marker.icon = UIImage(named: "map-marker")
        marker.map = mapView
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SetLocationViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        placesSearchController.isActive = false
        self.address = place.formattedAddress
//        mapView.clear()
//        let marker = GMSMarker()
//        marker.position = place.coordinate!
//        marker.title = ""
//        marker.icon = UIImage(named:"location_marker")
//        marker.map = mapView
        mapView.animate(toLocation: place.coordinate!)
    }
}

extension SetLocationViewController {
    //swiftlint:disable all
    func getAddress(lat: Double, lng: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lng
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, preferredLocale: Locale.autoupdatingCurrent, completionHandler:
            {(placemarks, error) in
                if (error != nil) {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                var pm: CLPlacemark!
                var userAddress: String?
                pm = placemarks?[0]
                if pm != nil {
                    if pm.subThoroughfare != nil {
                        userAddress = (userAddress ?? "") + pm.subThoroughfare! + ", "
                    }
                    if pm.thoroughfare != nil {
                        userAddress = (userAddress ?? "") + pm.thoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        userAddress = (userAddress ?? "") + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        userAddress = (userAddress ?? "") + pm.locality! + ", "
                    }
                    if pm.administrativeArea != nil {
                        userAddress = (userAddress ?? "") + pm.administrativeArea! + ", "
                    }
                    if pm.country != nil {
                        userAddress = (userAddress ?? "") + pm.country! + ", "
                    }
                    self.address = userAddress
                }
        })
    }
}
