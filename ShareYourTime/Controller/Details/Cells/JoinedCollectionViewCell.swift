//
//  JoinedCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SDWebImage

class JoinedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var joinedUserImage: UIImageView!
    
    func bind(_ user: UserModel) {
        if let image = user.image {
            let url = ApiUrls.base_url + image
            joinedUserImage.sd_setImage(with: URL(string: url))
            joinedUserImage.layer.masksToBounds = true
            joinedUserImage.layer.cornerRadius = joinedUserImage.frame.size.width/2
        }
    }

}
