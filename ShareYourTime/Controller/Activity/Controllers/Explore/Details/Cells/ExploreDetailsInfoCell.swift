//
//  ExploreDetailsInfoCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ExploreDetailsInfoCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventTimeLabel: UILabel!
    
    var event: ExploreEventModel? {
        didSet {
            bind()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
//        imageContainerView.layer.masksToBounds = true
        imageContainerView.layer.cornerRadius = imageContainerView.frame.size.width / 2
//        containerView.setViewShadow()
        containerView.roundCorners([.topLeft, .topRight], radius: 8)
    }
    
    private func bind() {
        if let event = event {
            if let imageUrl = URL(string: ApiUrls.base_url + (event.createdBy?.image ?? "")) {
                userImage.sd_setImage(with: imageUrl)
                userImage.layer.masksToBounds = true
                userImage.layer.cornerRadius = userImage.frame.size.width / 2
            }
            userNameLabel.text = event.createdBy?.name ?? ""
            eventTitleLabel.text = event.title ?? ""
            eventDateLabel.text = event.days ?? ""
            eventTimeLabel.text = String(event.duration ?? 0)
        }
    }
}
