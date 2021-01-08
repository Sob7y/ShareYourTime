//
//  ExploreDetailsLocationCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import GoogleMaps

class ExploreDetailsLocationCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var mapView: GMSMapView!
        
    var event: ExploreEventModel? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bind()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup() {
        guard let event = event else { return }
        let location = CLLocationCoordinate2DMake((event.latitude ?? 0), (event.longitude ?? 0))
        AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
        addMarkerToMap(lat: (event.latitude ?? 0), lng: (event.longitude ?? 0))
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.locationTitle
//        containerView.setViewShadow()
        containerView.roundCorners([.bottomLeft, .bottomRight], radius: 8)
        mapView.isUserInteractionEnabled = false
    }
    
    func addMarkerToMap(lat:Double, lng:Double){
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = ""
        marker.icon = UIImage(named:"location_marker")
        marker.map = mapView
        
        getAddress(lat: lat, lng: lng, completion: { (address) in
            self.titleLbl.text = address
        })
    }
    
    func AddGoogleMapsWithLocation(location:CLLocationCoordinate2D, currentZoom:Float)
    {
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: currentZoom, bearing: 0, viewingAngle: 0)
        
        mapView.isBuildingsEnabled = true
        mapView.isMyLocationEnabled = true
        
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.animate(to: camera)
    }
    
    func getAddress(lat: Double, lng: Double, completion: @escaping (String?) -> ()) {
        var userAddress: String?
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lng
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                var pm: CLPlacemark!
                pm = placemarks?[0]
                //                let pm = placemarks! as [CLPlacemark]
                
                if pm != nil {
                    let pm = placemarks![0]
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
                    completion(userAddress)
                }
        })
    }
}
