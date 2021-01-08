//
//  SignupViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var backBtn: UIButton!
    var presenter: SignupPresenter!

    var picker:UIImagePickerController?=UIImagePickerController()
    var imageData: Data?
    var isSwitchBetweenButtons = false
    var originContentOffset:CGPoint!
    
    var name: String?
    var email: String?
    var phone: String?
    var password: String?
    var confirmPassword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        localizeView()
        presenter = SignupPresenterImp(view: self)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originContentOffset = self.tableView.contentOffset
    }
    
    func localizeView() {
        loginBtn.setTitle(Strings.sharedInstance.haveAccountLogin, for: .normal)
        let image = UIImage(named: "ic_arrow_left")?.imageFlippedForRightToLeftLayoutDirection()
        backBtn.setImage(image, for: .normal)
    }
    
    @IBAction func dismissView() {
        self.view.endEditing(true)
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func addPhotoAlertView(_ sender:Any){
        let chooseTitle = Strings.sharedInstance.chooseTitle
        let cameraTitle = Strings.sharedInstance.chooseCameraTitle
        let galleryTitle = Strings.sharedInstance.chooseGalleryTitle
        let cancelTitle = Strings.sharedInstance.cancelTitle
        
        let alert:UIAlertController=UIAlertController(title: chooseTitle, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: cameraTitle, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: galleryTitle, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            let imageCellindex = IndexPath(row: 0, section: 0)
            let userImagecell = self.tableView.cellForRow(at: imageCellindex) as! SignupImageCell
            
            userImagecell.bindImage(pickedImage)
            imageData = pickedImage.jpeg(.low)//.pngData()!            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

}

extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case signupCells.photo.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupImageCell", for: indexPath) as? SignupImageCell else { return UITableViewCell() }
            
            cell.bind()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.name.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupNameField()
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.email.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupEmailField()
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.phone.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupPhoneField()
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.password.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupPasswordField()
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.confirmPassword.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupConfirmPassField()
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case signupCells.register.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterActionCell", for: indexPath) as? RegisterActionCell else { return UITableViewCell() }
            
            cell.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
            cell.bind()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case signupCells.photo.rawValue:
            return 130
        default:
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == signupCells.photo.rawValue{
            DispatchQueue.main.async {
                self.addPhotoAlertView(self)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isSwitchBetweenButtons==true {
            
        } else {
            view.endEditing(true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isSwitchBetweenButtons = false
    }
    
    @IBAction func registerAction() {
        
        if self.password != self.confirmPassword {
            self.showError(message: Strings.sharedInstance.passwordIsNotMatched)
            return
        }
        guard let imageData = self.imageData else { return self.showError(message: Strings.sharedInstance.imageIsMandatory) }
        guard let name = self.name else { return self.showError(message: Strings.sharedInstance.nameIsMandatory) }
        guard let phone = self.phone, phone.isPhoneNumber else { return self.showError(message: Strings.sharedInstance.phoneIsMandatory) }
        guard let password = self.password else { return self.showError(message: Strings.sharedInstance.passwordIsMandatory) }
        guard let email = self.email else { return self.showError(message: Strings.sharedInstance.emailIsMandatory) }
        
        self.view.endEditing(true)
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
        presenter.signup(name: name, email: email, phone: phone, password:password, image: (imageData.base64EncodedString()))
    }
    
    
    func selectCell(textfield:UITextField){
        let pointInTable = textfield.superview?.convert(textfield.frame.origin, to: tableView)
        var contentOffset = originContentOffset
        contentOffset?.y = (pointInTable?.y)! - textfield.frame.size.height - 220
        self.tableView.setContentOffset(contentOffset!, animated: true)
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}

extension SignupViewController: SignupView {
    func didSignupAction(_ loginResponse: LoginResponse) {
        self.performSegue(withIdentifier: Constant.segues.push_main, sender: nil)
    }
}

extension SignupViewController: TextFieldCellDelagete {
    
    func setPasswordTextField(_ textfield: UITextField) {
        self.selectCell(textfield: textfield)
        isSwitchBetweenButtons = true
    }
    
    func setConfirmPasswordTextField(_ textfield: UITextField) {
        self.selectCell(textfield: textfield)
        isSwitchBetweenButtons = true
    }
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func setPassword(_ password: String) {
        self.password = password
    }
    
    func setConfirmPassword(_ confirmPassword: String) {
        self.confirmPassword = confirmPassword
    }
    func setPhone(_ phone: String) {
        self.phone = phone
    }
    
}
