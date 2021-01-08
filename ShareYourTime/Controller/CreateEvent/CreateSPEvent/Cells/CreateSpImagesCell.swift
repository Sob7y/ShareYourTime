//
//  CreateSpImagesCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

protocol CreateSpImagesCellDelegate: class {
    func setImages(_ images: [CreateEventImageModel])
}

class CreateSpImagesCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!

    var picker:UIImagePickerController?=UIImagePickerController()
    var viewController: UIViewController?
    
    private var indexPath: IndexPath?
    weak var delegate: CreateSpImagesCellDelegate?
    
    var images: [CreateEventImageModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var selectedModel: CreateEventImageModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func addPhotoAlertView() {
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
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        viewController?.present(picker!, animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            viewController?.present(picker!, animated: true, completion: nil)
        } else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
}

extension CreateSpImagesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddImageCollectionViewCell.identifier,
            for: indexPath as IndexPath) as? AddImageCollectionViewCell
            else { return UICollectionViewCell() }
        
        if let model = images?[indexPath.row] {
            cell.imageModel = model
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.indexPath = indexPath
         addPhotoAlertView()
    }
}

extension CreateSpImagesCell: UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            guard let imageData = pickedImage.jpeg(.low) else { return }
            
            if let model = images?[indexPath?.row ?? 0] {
                model.imageData = ApiUrls.base_image_url + (imageData.base64EncodedString())
                model.selectedImage = pickedImage
                if let index = images?.index(of: model) {
                    images?[index] = model
                }
            }
            
            delegate?.setImages(images ?? [])
            self.collectionView.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
