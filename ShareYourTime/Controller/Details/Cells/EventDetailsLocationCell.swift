//
//  EventDetailsLocationCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import GoogleMaps

class EventDetailsLocationCell: UITableViewCell {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var eventModel: EventModel? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup() {
        if eventModel?.latitude != nil {
            let lat = eventModel?.latitude
            let lng = eventModel?.longitude
            
            let location = CLLocationCoordinate2DMake(lat!, lng!)
            AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
        }
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.locationTitle
        textfield.placeholder = Strings.sharedInstance.locationPlaceholder
    }
    
    func AddGoogleMapsWithLocation(location:CLLocationCoordinate2D, currentZoom:Float)
    {
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: currentZoom, bearing: 0, viewingAngle: 0)
        
        mapView.isBuildingsEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.animate(to: camera)
        addMarkerToMap()
    }
    
    func addMarkerToMap() {
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: eventModel?.latitude ?? 0, longitude: eventModel?.longitude ?? 0)
        marker.title = ""
        marker.icon = UIImage(named:"location_marker")
        marker.map = mapView
    }
}
