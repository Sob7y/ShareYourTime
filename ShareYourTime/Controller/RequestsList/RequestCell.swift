//
//  RequestCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/18/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {

    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEventsCountLabel: UILabel!
    @IBOutlet weak private var userImage: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ user: UserModel) {
        if let image = user.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            userImage.sd_setImage(with: imageUrl)
            userImage.layer.masksToBounds = true
            userImage.layer.cornerRadius = userImage.frame.size.width/2
        }
        
        userNameLabel.text = user.name ?? ""
        userEventsCountLabel.text = String(user.eventCount ?? 0) + " " + "events".localized
    }
}
