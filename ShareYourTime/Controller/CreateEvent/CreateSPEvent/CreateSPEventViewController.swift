//
//  CreateSPEventViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import GoogleMaps
import Presentr

class CreateSPEventViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var presenter: CreateEventPresenter!
    var tap: UITapGestureRecognizer!

    var userAddress: String?
    var latitude: Double?
    var longitude: Double?
    var eventTime: String?
    var eventTitle: String?
    
    var days: [CreateEventDayModel]?
    var images: [CreateEventImageModel]?
    
    let presentr: Presentr = {
        let presenter = Presentr(presentationType: .alert)
        presenter.transitionType = nil
        presenter.dismissTransitionType = nil
        presenter.keyboardTranslationType = .moveUp
        presenter.dismissOnSwipe = true
        presenter.presentationType = .bottomHalf
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = setupImagesModels()
        setupView()
    }
    
    fileprivate func setupView() {
        submitBtn.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = 20
        submitBtn.setTitle(Strings.sharedInstance.submit, for: .normal)
        presenter = CreateEventPresenterImp(view: self)
        
        titleLbl.text = Strings.sharedInstance.createTitle
        descLbl.text = Strings.sharedInstance.createSubTitle
    }

    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addToCardAction() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let pickerView = storyBoard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        pickerView.delegate = self
        let centerPoint = CGPoint(x: self.view.frame.origin.x + (UIScreen.main.bounds.width / 2),
                                  y: UIScreen.main.bounds.height - 130)
        presentr.presentationType = .custom(width: .full,
                                             height: .custom(size: 260),
                                             center: .custom(centerPoint: centerPoint))
        self.customPresentViewController(presentr, viewController: pickerView, animated: true)
    }
    
    private func setupImagesModels() -> [CreateEventImageModel] {
        var images: [CreateEventImageModel] = []
        let imageModel1 = CreateEventImageModel(selectedImage: nil,
                                               isSelected: false,
                                               imageData: nil,
                                               index: 1)
        let imageModel2 = CreateEventImageModel(selectedImage: nil,
                                               isSelected: false,
                                               imageData: nil,
                                               index: 2)
        let imageModel3 = CreateEventImageModel(selectedImage: nil,
                                               isSelected: false,
                                               imageData: nil,
                                               index: 3)
        let imageModel4 = CreateEventImageModel(selectedImage: nil,
                                               isSelected: false,
                                               imageData: nil,
                                               index: 4)
        let imageModel5 = CreateEventImageModel(selectedImage: nil,
                                               isSelected: false,
                                               imageData: nil,
                                               index: 5)
        
        images.append(imageModel1)
        images.append(imageModel2)
        images.append(imageModel3)
        images.append(imageModel4)
        images.append(imageModel5)
        
        return images
    }
    
    private func setupTapRecognizer() {
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        guard let title = eventTitle else {
            return self.showError(message: "eventTitle_is_required".localized)
        }
        guard let time = eventTime else {
            return self.showError(message: "eventTime_is_required".localized)
        }
        guard let latitude = latitude else {
            return self.showError(message: "eventLocation_is_required".localized)
        }
        guard let longitude = longitude else { return }
        guard let images = images else {
            return self.showError(message: "eventImages_is_required".localized)
        }
        guard let days = days else {
            return self.showError(message: "event_days_is_required".localized)
        }
        
        let imagesData = images.compactMap({ $0.imageData ?? "" }).filter({ !$0.isEmpty })
        let selectedDays = days.filter({ $0.isSelected })
        let daysArray = selectedDays.compactMap({ $0.name })
        let dayString = daysArray.joined(separator: ",")
        
        presenter.createSPEvent(title: title, days: dayString, duration: time, latitude: String(latitude), longitude: String(longitude), description: "", images: imagesData)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_location {
            let destination = segue.destination as! SetLocationViewController
                destination.delegate = self
        }
    }
}

extension CreateSPEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case createEventCells.title.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventTitleCell", for: indexPath) as? CreateEventTitleCell else {return UITableViewCell()}
            
            cell.bind()
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case createEventCells.date.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateSPDateCell", for: indexPath) as? CreateSPDateCell else {return UITableViewCell()}
            
            cell.bindTime(eventTime ?? "")
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case createEventCells.location.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventLocationCell", for: indexPath) as? CreateEventLocationCell else {return UITableViewCell()}
            
            cell.isServiceProvider = true
            cell.bind()
            if userAddress != nil {
                cell.textfield.text = userAddress
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateSpImagesCell", for: indexPath) as? CreateSpImagesCell else {return UITableViewCell()}
            
            cell.viewController = self
            cell.images = setupImagesModels()
            cell.delegate =  self
            
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
            break
//            self.view.endEditing(true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case createEventCells.title.rawValue:
            return 90
        case createEventCells.date.rawValue:
            return 170
        case createEventCells.location.rawValue:
            return 120
        case 3:
            return 130
        default:
            return 100
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension CreateSPEventViewController: LocationDelegate {
    func setLocation(lat: Double, lng: Double) {
        getAddress(lat: lat, lng: lng)
//        isLocationSet = true
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

extension CreateSPEventViewController: PickerViewDelegate {
    func didChooseNumber(number: Int) {
        eventTime = String(number)
        self.tableView.reloadData()
    }
}

extension CreateSPEventViewController: CreateSPDateCellDelegate {
    func timeSelected() {
        addToCardAction()
    }
    
    func setDays(_ days: [CreateEventDayModel]) {
        self.days = days
    }
}

extension CreateSPEventViewController: CreateSpImagesCellDelegate {
    func setImages(_ images: [CreateEventImageModel]) {
        self.images = images
    }
}


extension CreateSPEventViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        eventTitle = textField.text
    }
}

extension CreateSPEventViewController: CreateEventView {
    func didInsertData(_ respose: CreateEventResponse) {
        self.hideLoading()
        NotificationCenter.default.post(name: Notification.Name("relodExplore"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
