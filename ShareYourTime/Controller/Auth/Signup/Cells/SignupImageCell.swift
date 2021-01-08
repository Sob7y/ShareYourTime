//
//  SignupImageCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SignupImageCell: UITableViewCell {

    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var dimmedView:UIView!
    @IBOutlet weak var userImg:UIImageView!
    @IBOutlet weak var addUserImg:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.setImageCotainerShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind() {
        userImg.layer.cornerRadius = userImg.frame.size.width/2
        userImg.layer.masksToBounds = true
        dimmedView.layer.cornerRadius = dimmedView.frame.size.width/2
        dimmedView.layer.masksToBounds = true
        addUserImg.alpha = 1
        dimmedView.alpha = 0.0
    }
    
    func bindImage(_ pickedImage: UIImage) {
        userImg.contentMode = .scaleAspectFill
        userImg.image = pickedImage
        userImg.layer.cornerRadius = userImg.frame.size.width/2
        userImg.layer.masksToBounds = true
        dimmedView.layer.cornerRadius = dimmedView.frame.size.width/2
        dimmedView.layer.masksToBounds = true
        addUserImg.alpha = 0
        dimmedView.alpha = 0.4
    }
    
    func bindProfile(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImg.sd_setImage(with: imageUrl)
        } else {
            userImg.image = UIImage(named: "")
        }
    }

}
