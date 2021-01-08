//
//  TimePickerViewController.swift
//  Yamo
//
//  Created by Mohammed Khaled (Sob7y) on 2/1/19.
//  Copyright © 2019 Yamo. All rights reserved.
//

import UIKit

protocol TimePickerDelegate: class {
    func didChooseTime(_ time: String)
    func didCancel()
}

class TimePickerViewController: UIViewController {

    weak var delegate: TimePickerDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var chooseBtn: UIButton!
    
    var selectedTime: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            self.timePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func setTime(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let strDate = dateFormatter.string(from: timePicker.date)
        delegate?.didChooseTime(strDate)
    }
    @IBAction func cancel(_ sender: UIButton) {
        delegate?.didCancel()
    }

}

