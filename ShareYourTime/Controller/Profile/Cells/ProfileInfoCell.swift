//
//  ProfileInfoCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ProfileInfoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        arrowImage.image = UIImage(named: "ic_more")?.imageFlippedForRightToLeftLayoutDirection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ row: Int) {
        switch row {
        case 1:
            titleLabel.text = "change_language".localized
        case 2:
            titleLabel.text = "change_password".localized
        case 3:
            titleLabel.text = "friends_list".localized
        case 4:
            titleLabel.text = "requests_list".localized
        case 5:
            titleLabel.text = "manage_circles".localized
        case 6:
            titleLabel.text = "edit_profile".localized
        case 7:
            titleLabel.text = "logout".localized
        //titleLabel.text = "notifications".localized
        case 8:
            titleLabel.text = "contact_us".localized
        case 9:
            titleLabel.text = "logout".localized
        default:
            break
        }
    }

}
