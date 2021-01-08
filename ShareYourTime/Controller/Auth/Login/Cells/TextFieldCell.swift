//
//  TextFieldCell.swift
//  Zady
//
//  Created by Mohammed Khaled (Sob7y) on 12/23/18.
//  Copyright © 2018 Zadi. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol TextFieldCellDelagete: class {
    func setName(_ name: String)
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func setPhone(_ phone: String)
    func setConfirmPassword(_ confirmPassword: String)
    
    func setPasswordTextField(_ textfield: UITextField)
    func setConfirmPasswordTextField(_ textfield: UITextField)
}

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var textfield: SkyFloatingLabelTextField!
    
    weak var delegate:TextFieldCellDelagete?
    var hideError = false
    var password: String?
    
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
        textfield.delegate = self
        textfield.selectedLineColor = UIColor.oldLavendor
        textfield.selectedTitleColor = UIColor.oldLavendor
        textfield.lineColor = UIColor.lavenderGray
    }
    
    func bindProfileName(_ user: UserModel) {
        textfield.placeholder = Strings.sharedInstance.nameTitle
        textfield.keyboardType = .default
        textfield.text = user.name
    }
    
    func bindProfilePhone(_ user: UserModel) {
        textfield.placeholder = Strings.sharedInstance.phoneTitle
        textfield.keyboardType = .phonePad
        textfield.text = String(user.phone ?? 0)
    }
    
    func setupEmailField() {
        textfield.placeholder = Strings.sharedInstance.emailTitle
        textfield.keyboardType = .emailAddress
    }
    
    func setupPasswordField() {
        textfield.placeholder = Strings.sharedInstance.passwordTitle
        textfield.keyboardType = .default
        textfield.isSecureTextEntry = true
    }
    
    func setupPhoneField() {
        textfield.placeholder = Strings.sharedInstance.phoneTitle
        textfield.keyboardType = .phonePad
    }
    
    func setupNameField() {
        textfield.placeholder = Strings.sharedInstance.nameTitle
        textfield.keyboardType = .default
    }
    
    func setupConfirmPassField() {
        textfield.placeholder = Strings.sharedInstance.confirmPassTitle
        textfield.keyboardType = .default
        textfield.isSecureTextEntry = true
    }
    
    
    @IBAction func validateEmailField() {
        validateEmailTextFieldWithText(email: textfield.text)
    }
    
    func validateEmailTextFieldWithText(email: String?) {
        guard let email = email else {
            textfield.errorMessage = nil
            return
        }
        
        if email.isEmpty {
            textfield.errorMessage = nil
        } else if !validateEmail(email) {
            textfield.errorMessage = Strings.sharedInstance.emailNotRightMessage
        } else {
            textfield.errorMessage = nil
        }
    }
    func validatePasswordLength(password: String?) {
        if hideError {
            textfield.errorMessage = nil
            return
        }
        guard let password = password else {
            textfield.errorMessage = nil
            return
        }
        
        if password.count < 8 {
            textfield.errorMessage = Strings.sharedInstance.passwordLengthError
        } else {
            textfield.errorMessage = nil
        }
    }
    
    func validatePasswordTextFieldWithText(passsword: String?) {
        guard let passsword = password else {
            textfield.errorMessage = nil
            return
        }
        
        if passsword != self.password {
            textfield.errorMessage = Strings.sharedInstance.passwordDidNotMatch
        } else {
            textfield.errorMessage = nil
        }
    }
    
    // MARK: - validation
    
    func validateEmail(_ candidate: String) -> Bool {
        // Regex source and more information here: http://emailregex.com
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }

}

extension TextFieldCell: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if textField.placeholder == Strings.sharedInstance.emailTitle {
            validateEmailField()
            delegate?.setEmail(textField.text ?? "")
        }
        if textField.placeholder == Strings.sharedInstance.phoneTitle {
            delegate?.setPhone(textField.text ?? "")
        }
        if textField.placeholder == Strings.sharedInstance.nameTitle {
            delegate?.setName(textField.text ?? "")
        }
        if textField.placeholder == Strings.sharedInstance.passwordTitle {
            delegate?.setPassword(textField.text ?? "")
            validatePasswordLength(password: textField.text)
            self.password = textField.text
        }
        if textField.placeholder == Strings.sharedInstance.confirmPassTitle {
            delegate?.setConfirmPassword(textField.text ?? "")
            validatePasswordTextFieldWithText(passsword: textField.text)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder == Strings.sharedInstance.nameTitle {
            delegate?.setName(textField.text ?? "")
        }
        if textField.placeholder == Strings.sharedInstance.passwordTitle {
            delegate?.setPasswordTextField(textField)
        }
        if textField.placeholder == Strings.sharedInstance.confirmPassTitle {
            delegate?.setConfirmPasswordTextField(textField)
        }
    }
}
