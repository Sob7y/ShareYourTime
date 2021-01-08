//
//  CircleCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/5/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SDWebImage

class CircleCollectionViewCell: UICollectionViewCell {

    @IBOutlet private  weak var userImage: UIImageView!
    
    var userModel: UserModel? {
        didSet {
            bind()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    private func setup() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
    }
    
    private func bind() {
        if let image = userModel?.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
        }
    }

}
