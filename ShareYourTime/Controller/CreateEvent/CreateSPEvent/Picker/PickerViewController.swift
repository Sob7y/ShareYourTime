//
//  PickerViewController.swift
//  Zady
//
//  Created by Maha Khaled on 3/30/19.
//  Copyright © 2019 Zadi. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    func didChooseNumber(number: Int)
}

class PickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var isFromRecent = false
    
    weak var delegate: PickerViewDelegate?
    var index: Int?
    
    var items = [1, 2, 3, 4, 5]
    var choosedNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        doneButton.layer.masksToBounds = true
        doneButton.layer.cornerRadius = 30
        cancelButton.layer.masksToBounds = true
        cancelButton.layer.cornerRadius = 30
        
        doneButton.setTitle("set".localized, for: .normal)
        cancelButton.setTitle("cancel".localized, for: .normal)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        delegate?.didChooseNumber(number: choosedNumber)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(items[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choosedNumber = items[row]
        delegate?.didChooseNumber(number: choosedNumber)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
