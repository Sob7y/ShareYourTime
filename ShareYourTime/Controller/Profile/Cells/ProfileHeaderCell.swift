//
//  ProfileHeaderCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userQuoteLabel: UILabel!
    @IBOutlet weak var eventsTitleLabel: UILabel!
    @IBOutlet weak var eventsCountLabel: UILabel!
    @IBOutlet weak var followersTitleLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingsTitleLabel: UILabel!
    @IBOutlet weak var followingsCountLabel: UILabel!
    
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
        containerView.setViewShadow()
        containerView.layer.cornerRadius = 5
        
        imageContainerView.layer.cornerRadius = imageContainerView.frame.size.width/2
        imageContainerView.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.layer.masksToBounds = true
        
    }
    
    func bind(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
        } else {
            userImage.image = UIImage(named: "")
        }
        userImage.contentMode = .scaleAspectFill
        
        userNameLabel.text = user.name
        if let eventsCount = user.eventCount {
            eventsCountLabel.text = String(eventsCount)
        } else {
            eventsCountLabel.text = "0"
        }
        if let followersCount = user.followersCount {
            followersCountLabel.text = String(followersCount)
        } else {
            followersCountLabel.text = "0"
        }
        if let followingsCount = user.followingCount {
            followingsCountLabel.text = String(followingsCount)
        } else {
            followingsCountLabel.text = "0"
        }
        
        
        eventsTitleLabel.text = "events".localized
        followersTitleLabel.text = "friends".localized
        followingsTitleLabel.text = "circles".localized
    }

}
