//
//  AddImageCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class AddImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!

    var imageModel: CreateEventImageModel? {
        didSet {
            bind()
        }
    }
    
    private func bind() {
        if let image = imageModel?.selectedImage {
            eventImageView.image = image
            containerView.isHidden = true
        } else {
            containerView.isHidden = false
        }
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 8
    }
}
