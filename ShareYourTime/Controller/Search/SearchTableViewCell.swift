//
//  SearchTableViewCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEventsCountLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak var addUserButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bind(_ user: UserModel) {
        let friendImg = UIImage(named: "ic_added_user")
        let unFriendImg = UIImage(named: "ic_add_user")
        let pendingImg = UIImage(named: "ic_pending")
        switch user.relation {
        case .friend?:
            addUserButton.setImage(friendImg , for: .normal)
        case .notFriend?:
            addUserButton.setImage(unFriendImg , for: .normal)
        case .pending?:
            addUserButton.setImage(pendingImg , for: .normal)
        case .none:
            break
        }
        
        
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 20
        }
        
        userNameLabel.text = user.name ?? ""
        userEventsCountLabel.text = String(user.eventCount ?? 0) + " " + "events".localized
    }
    
    func bindFriends(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 20
        }
        if let isMember = user.isMember {
            let selectedImage = UIImage(named: "ic_added_user")
            let unselectedImage = UIImage(named: "ic_add_user")
            addUserButton.setImage(isMember ? selectedImage : unselectedImage, for: .normal)
        } else {
            let selectedImage = UIImage(named: "ic_added_user")
            let unselectedImage = UIImage(named: "ic_add_user")
            addUserButton.setImage(user.isSelected ? selectedImage : unselectedImage, for: .normal)
        }
        userNameLabel.text = user.name ?? ""
        userEventsCountLabel.text = String(user.eventCount ?? 0) + " " + "events".localized
    }
    
    func bindUsers(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 20
        }
        if let isMember = user.isMember {
            let selectedImage = UIImage(named: "ic_added_user")
            let unselectedImage = UIImage(named: "ic_add_user")
            addUserButton.setImage(isMember ? selectedImage : unselectedImage, for: .normal)
        } else {
            let selectedImage = UIImage(named: "ic_check_on")
            addUserButton.setImage(selectedImage, for: .normal)
        }
        userNameLabel.text = user.name ?? ""
        userEventsCountLabel.text = String(user.eventCount ?? 0) + " " + "events".localized
    }
    
}
