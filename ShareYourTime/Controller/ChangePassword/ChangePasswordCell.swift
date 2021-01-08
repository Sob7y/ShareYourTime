//
//  ChangePasswordCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePasswordCell: UITableViewCell {

    @IBOutlet weak var textfield: SkyFloatingLabelTextField!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewPasswordSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup() {
        textfield.selectedLineColor = UIColor.oldLavendor
        textfield.selectedTitleColor = UIColor.oldLavendor
        textfield.lineColor = UIColor.lavenderGray
        textfield.isSecureTextEntry = true
    }
    
    func setupOldPasswordField() {
        textfield.placeholder = "old_password".localized
    }
    
    func setupNewPasswordField() {
        textfield.placeholder = "new_password".localized
    }
    
    func setupRepeatPasword() {
        textfield.placeholder = "repeat_password".localized
    }

}
