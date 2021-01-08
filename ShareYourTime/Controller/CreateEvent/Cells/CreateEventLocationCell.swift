//
//  CreateEventLocationCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import GoogleMaps

class CreateEventLocationCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var latitude: Double?
    var longitude: Double?
    var isServiceProvider = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if mapView != nil {
            setup()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        if UserDefaults.standard.value(forKey: Constant.keys.key_latitude) != nil {
            let lat = UserDefaults.standard.value(forKey: Constant.keys.key_latitude) as! Double
            let lng = UserDefaults.standard.value(forKey: Constant.keys.key_longitude) as! Double
            
            let location = CLLocationCoordinate2DMake(lat, lng)
            AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
        }
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.locationTitle
        textfield.placeholder = Strings.sharedInstance.locationPlaceholder
        
        if !isServiceProvider {
            mapView.isUserInteractionEnabled = false
        }
    }
    
    func addMarkerToMap(lat:Double, lng:Double){
        mapView.clear()
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = ""
        marker.icon = UIImage(named:"location_marker")
        marker.map = mapView
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
}

extension CreateEventLocationCell: UITextFieldDelegate {
    
}
