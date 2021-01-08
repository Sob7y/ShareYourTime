//
//  WhoIsOutCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class WhoIsOutCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var joinedUser1Img: UIImageView!
    @IBOutlet weak var joinedUser2Img: UIImageView!
    @IBOutlet weak var joinedUser3Img: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var byWhomeLbl: UILabel!
    @IBOutlet weak var plusUsersNumberBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func bind(_ eventModel: EventModel) {
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.gainsboro.cgColor
        
        userImg.layer.masksToBounds = true
        userImg.layer.cornerRadius = 30
                
        userNameLbl.text = eventModel.title
        if let user = eventModel.createdBy {
            userImg.sd_setImage(with: URL(string: ApiUrls.base_url + (user.image ?? "")))
        }
        
        let eventDate = Date(timeIntervalSince1970: eventModel.holdDate ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: eventDate)
        dateLbl.text = strDate
        
        switch eventModel.joinType {
        case .owner?:
            byWhomeLbl.text = Strings.sharedInstance.byMe
        default:
            byWhomeLbl.text = Strings.sharedInstance.by + " " + (eventModel.createdBy?.name ?? "")
        }
        
        if joinedUser1Img == nil {
            return
        }
        
        if (eventModel.joinedUsers?.count ?? 0) == 1 {
            joinedUser1Img.alpha = 1
            if let user = eventModel.joinedUsers?[0] {
                joinedUser1Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user.image ?? "")))
                joinedUser1Img.layer.masksToBounds = true
                joinedUser1Img.layer.cornerRadius = 12
            }
        } else if (eventModel.joinedUsers?.count ?? 0) == 2 {
            joinedUser1Img.alpha = 1
            joinedUser2Img.alpha = 1
            if let user1 = eventModel.joinedUsers?[0], let user2 = eventModel.joinedUsers?[1] {
                joinedUser1Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user1.image ?? "")))
                joinedUser2Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user2.image ?? "")))
                
                joinedUser1Img.layer.masksToBounds = true
                joinedUser1Img.layer.cornerRadius = 12
                joinedUser2Img.layer.masksToBounds = true
                joinedUser2Img.layer.cornerRadius = 12
            }
        } else if (eventModel.joinedUsers?.count ?? 0) == 3 {
            joinedUser1Img.alpha = 1
            joinedUser2Img.alpha = 1
            joinedUser3Img.alpha = 1
            if let user1 = eventModel.joinedUsers?[0], let user2 = eventModel.joinedUsers?[1], let user3 = eventModel.joinedUsers?[2] {
                joinedUser1Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user1.image ?? "")))
                joinedUser2Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user2.image ?? "")))
                joinedUser3Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user3.image ?? "")))
                
                joinedUser1Img.layer.masksToBounds = true
                joinedUser1Img.layer.cornerRadius = 12
                joinedUser2Img.layer.masksToBounds = true
                joinedUser2Img.layer.cornerRadius = 12
                joinedUser3Img.layer.masksToBounds = true
                joinedUser3Img.layer.cornerRadius = 12
            }
        } else if (eventModel.joinedUsers?.count ?? 0) > 3{
            if let user1 = eventModel.joinedUsers?[0], let user2 = eventModel.joinedUsers?[1], let user3 = eventModel.joinedUsers?[2] {
                joinedUser1Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user1.image ?? "")))
                joinedUser2Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user2.image ?? "")))
                joinedUser3Img.sd_setImage(with: URL(string: ApiUrls.base_url + (user3.image ?? "")))
                plusUsersNumberBtn.alpha = 1
                let plusNum = (eventModel.joinedUsers?.count ?? 0) - 3
                plusUsersNumberBtn.setTitle(String(plusNum), for: .normal)
                
                joinedUser1Img.layer.masksToBounds = true
                joinedUser1Img.layer.cornerRadius = 12
                joinedUser2Img.layer.masksToBounds = true
                joinedUser2Img.layer.cornerRadius = 12
                joinedUser3Img.layer.masksToBounds = true
                joinedUser3Img.layer.cornerRadius = 12
            }
        } else {
            joinedUser1Img.alpha = 0
            joinedUser2Img.alpha = 0
            joinedUser3Img.alpha = 0
            plusUsersNumberBtn.alpha = 0
        }
    }

}
