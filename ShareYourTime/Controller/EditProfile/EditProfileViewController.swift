//
//  EditProfileViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var updateProfileButton: UIButton!
    @IBOutlet private weak var backBtn: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!

    var presenter: ProfilePresenter!
    var userModel: UserModel!
    
    var picker:UIImagePickerController?=UIImagePickerController()
    var imageData: Data?
    var isSwitchBetweenButtons = false
    var originContentOffset:CGPoint!
    
    var name: String?
    var phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenterImp(view: self)
        fillData()
    }
    
    func fillData() {
        self.titleLabel.text = "update_profile".localized
        if let image = userModel.image {
            if let imageUrl = URL(string: ApiUrls.base_url + image) {
                downloadImage(from: imageUrl)
            }
        }
        
        self.name = userModel.name
        self.phone = String(userModel.phone ?? 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originContentOffset = self.tableView.contentOffset
    }
    
    func localizeView() {
        updateProfileButton.setTitle(Strings.sharedInstance.haveAccountLogin, for: .normal)
        let image = UIImage(named: "ic_arrow_left")?.imageFlippedForRightToLeftLayoutDirection()
        backBtn.setImage(image, for: .normal)
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

    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SignupImageCell", for: indexPath) as? SignupImageCell else { return UITableViewCell() }
            
            cell.bindProfile(userModel)
            cell.bind()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.bindProfileName(userModel)
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.bindProfilePhone(userModel)
            cell.delegate = self
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterActionCell", for: indexPath) as? RegisterActionCell else { return UITableViewCell() }
            
            cell.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
            cell.bind()
            cell.registerBtn.setTitle("submit".localized, for: .normal)

            
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
        guard let imageData = self.imageData else { return self.showError(message: Strings.sharedInstance.imageIsMandatory) }
        guard let name = self.name else { return self.showError(message: Strings.sharedInstance.nameIsMandatory) }
        guard let phone = self.phone else { return self.showError(message: Strings.sharedInstance.phoneIsMandatory) }
        
        self.view.endEditing(true)
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
        presenter.updateProfile(name: name, phone: phone, image: imageData.base64EncodedString())
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        DispatchQueue.global(qos: .default).async{
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.imageData = image?.jpeg(.low)
                }
            }
        }
        
    }
    
    func selectCell(textfield:UITextField){
        let pointInTable = textfield.superview?.convert(textfield.frame.origin, to: tableView)
        var contentOffset = originContentOffset
        contentOffset?.y = (pointInTable?.y)! - textfield.frame.size.height - 220
        self.tableView.setContentOffset(contentOffset!, animated: true)
    }
}


extension EditProfileViewController: TextFieldCellDelagete {
    
    func setPasswordTextField(_ textfield: UITextField) {
    }
    
    func setConfirmPasswordTextField(_ textfield: UITextField) {
//        self.selectCell(textfield: textfield)
//        isSwitchBetweenButtons = true
    }
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func setEmail(_ email: String) {
    }
    
    func setPassword(_ password: String) {
    }
    
    func setConfirmPassword(_ confirmPassword: String) {
    }
    func setPhone(_ phone: String) {
        self.phone = phone
    }
    
}

extension EditProfileViewController: ProfileView {
    func didInsertData(_ respose: ProfileResponseModel) {
        self.navigationController?.popViewController(animated: true)
    }
}
