//
//  InviteUserCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class InviteUserCell: UITableViewCell {

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
    
    func bindInviteUsers(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = 20
        }
        
        let addImg = UIImage(named: "ic_invite_check_off")
        let addedImg = UIImage(named: "ic_invite_check_on")
        addUserButton.setImage(user.isSelected ? addedImg : addImg, for: .normal)

        userNameLabel.text = user.name ?? ""
        userEventsCountLabel.text = String(user.eventCount ?? 0) + " " + "events".localized
    }

}
