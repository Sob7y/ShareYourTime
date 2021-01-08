//
//  CreateEventViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateEventViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var timePickerView = TimePickerViewController()
    var containerheight: CGFloat!
    var dimView = UIView()
    var tapDismissGesture = UITapGestureRecognizer()

    var userAddress: String?
    var latitude: Double?
    var longitude: Double?
    var eventTime: String?
    var eventTitle: String?
    var holdDate: String?
    var eventDay: DayModel?
    var presenter: CreateEventPresenter!
    var isLocationSet = false
    
    fileprivate func setupView() {
        submitBtn.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = 20
        submitBtn.setTitle(Strings.sharedInstance.submit, for: .normal)
        presenter = CreateEventPresenterImp(view: self)
        
        titleLbl.text = Strings.sharedInstance.createTitle
        descLbl.text = Strings.sharedInstance.createSubTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodayModel()
        dimView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        dimView.alpha = 0.0
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func getTodayModel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDate = Date()
        eventDay = DayModel(Strings.sharedInstance.todayTitle, dateFormatter.string(from: todayDate), true, getDateTimestamp(todayDate))
    }
    
    @IBAction func createEvent() {
        
        guard let eventTitle = self.eventTitle else { return self.showError(message: Strings.sharedInstance.eventTitleIsRequired) }
        guard let holdDate = self.holdDate else { return self.showError(message: Strings.sharedInstance.eventDateIsRequired) }
        guard let userAddress = self.userAddress else { return self.showError(message: Strings.sharedInstance.eventLocationIsRequired) }
        guard let latitude = self.latitude else { return self.showError(message: Strings.sharedInstance.eventLocationIsRequired) }
        guard let longitude = self.longitude else { return self.showError(message: Strings.sharedInstance.eventLocationIsRequired) }
        
        self.showLoading()
        presenter.createEvent(holdDate: holdDate, title: eventTitle, address: userAddress, latitude: String(latitude), longitude: String(longitude))
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTimePickerView() {
        view.endEditing(true)
        
        dimView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        dimView.alpha = 0.0
        tapDismissGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurTimeButton(_:)))
        self.dimView.addGestureRecognizer(tapDismissGesture)
        UIApplication.shared.keyWindow?.addSubview(dimView)
        
        containerheight = self.view.frame.size.height
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        timePickerView = storyboard.instantiateViewController(withIdentifier: "TimePickerViewController") as! TimePickerViewController
        
        timePickerView.delegate = self
        timePickerView.view.frame = CGRect(x: 0, y: containerheight, width: self.view.frame.size.width, height: 270)
        timePickerView.view.alpha=0.0
        UIApplication.shared.keyWindow?.addSubview(timePickerView.view)
        
        let yPosition = containerheight - 270
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.timePickerView.view.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.size.width, height: 270)
            self.timePickerView.view.alpha=1.0
            self.dimView.alpha = 1.0
            
        }, completion: nil)
    }
    
    func removeTimePickerView() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.timePickerView.view.frame = CGRect(x: 0, y: self.timePickerView.view.frame.size.height+self.timePickerView.view.frame.origin.y, width: self.view.frame.size.width, height: self.timePickerView.view.frame.height)
            
        }, completion: { (finished: Bool) in
            self.timePickerView.view.removeFromSuperview()
        })
    }
    
    @objc func tapBlurTimeButton(_ sender: UITapGestureRecognizer) {
        dimView.removeGestureRecognizer(sender)
        dimView.removeFromSuperview()
        self.removeTimePickerView()
    }
    
    func getDateTimestamp(_ date: Date)->String {
        let myTimeStamp = Int(date.timeIntervalSince1970)
        return String(myTimeStamp)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_location {
            let destination = segue.destination as! SetLocationViewController
                destination.delegate = self
        }
    }
}

extension CreateEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case createEventCells.title.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventTitleCell", for: indexPath) as? CreateEventTitleCell else {return UITableViewCell()}
            
            cell.bind()
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = indexPath.row
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case createEventCells.date.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventDateCell", for: indexPath) as? CreateEventDateCell else {return UITableViewCell()}
            
            cell.bind()
            cell.delegate = self
            
            if eventTime != nil {
                cell.textfield.text = eventTime
            }
            
            cell.setTimeBtn.addTarget(self, action: #selector(addTimePickerView), for: .touchUpInside)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case createEventCells.location.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventLocationCell", for: indexPath) as? CreateEventLocationCell else {return UITableViewCell()}
            
            cell.bind()
            if userAddress != nil {
                cell.textfield.text = userAddress
                let location = CLLocationCoordinate2DMake(latitude ?? 0, longitude ?? 0)
                cell.AddGoogleMapsWithLocation(location: location, currentZoom: 16.0)
                cell.addMarkerToMap(lat: latitude ?? 0, lng: longitude ?? 0)
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case createEventCells.submit.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventSubmitCell", for: indexPath) as? CreateEventSubmitCell else { return UITableViewCell()}
            
            cell.bind()
            cell.subbmitBtn.addTarget(self, action: #selector(createEvent), for: .touchUpInside)

            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case createEventCells.location.rawValue:
            performSegue(withIdentifier: Constant.segues.push_location, sender: self)
        case createEventCells.date.rawValue:
            self.view.endEditing(true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case createEventCells.title.rawValue:
            return 90
        case createEventCells.date.rawValue:
            return 160
        case createEventCells.location.rawValue:
            return 320
        case createEventCells.submit.rawValue:
            return 76
        default:
            return 100
        }
    }
}

extension CreateEventViewController: LocationDelegate {
    func setLocation(lat: Double, lng: Double) {
        getAddress(lat: lat, lng: lng)
        isLocationSet = true
//        tableView.reloadData()
    }
    
    func getAddress(lat: Double, lng: Double) {
        latitude = lat
        longitude = lng
        
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
                        self.userAddress = (self.userAddress ?? "") + pm.subThoroughfare! + ", "
                    }
                    if pm.thoroughfare != nil {
                        self.userAddress = (self.userAddress ?? "") + pm.thoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        self.userAddress = (self.userAddress ?? "") + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        self.userAddress = (self.userAddress ?? "") + pm.locality! + ", "
                    }
                    if pm.administrativeArea != nil {
                        self.userAddress = (self.userAddress ?? "") + pm.administrativeArea! + ", "
                    }
                    if pm.country != nil {
                        self.userAddress = (self.userAddress ?? "") + pm.country! + ", "
                    }
                    self.tableView.reloadData()
                }
        })
        
    }
}

extension CreateEventViewController: TimePickerDelegate {
    func didChooseTime(_ time: String) {
        eventTime = time
        if let eventDay = self.eventDay {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a" //"MMMM dd, yyyy 'at' h:mm a"
            self.holdDate = (eventDay.date ?? "") + " " + (eventTime ?? "")                       // "March 24, 2017 at 7:00 AM"
            let finalDate = dateFormatter.date(from: self.holdDate ?? "")
            self.holdDate = getDateTimestamp(finalDate ?? Date())
            
            print(finalDate?.description(with: .current) ?? "")
        }
        dimView.removeGestureRecognizer(self.tapDismissGesture)
        dimView.removeFromSuperview()
        self.removeTimePickerView()
        self.tableView.reloadData()
    }
    
    func didCancel() {
        dimView.removeGestureRecognizer(self.tapDismissGesture)
        dimView.removeFromSuperview()
        self.removeTimePickerView()
    }
}

extension CreateEventViewController: CreateEventDateDelegate {
    func setDate(day: DayModel) {
        self.view.endEditing(true)
        if eventTime != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a" //"MMMM dd, yyyy 'at' h:mm a"
            self.holdDate = (day.date ?? "") + " " + (eventTime ?? "")                       // "March 24, 2017 at 7:00 AM"
            let finalDate = dateFormatter.date(from: self.holdDate ?? "")
            self.holdDate = getDateTimestamp(finalDate ?? Date())
            
            print(finalDate?.description(with: .current) ?? "")
        } else {
            self.eventDay = day
        }
        
    }
}

extension CreateEventViewController: CreateEventView {
    func didInsertData(_ respose: CreateEventResponse) {
        self.hideLoading()
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case createEventCells.title.rawValue:
            eventTitle = textField.text
        default:
            break
        }
    }
}
