//
//  MostBokkedCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class MostBokkedCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var eventImageView: UIImageView!
    @IBOutlet private weak var eventTitleLabel: UILabel!
    
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
    
    private func setupCell() {
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 8
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
    }
    
    private func bind() {
        eventTitleLabel.text = event?.title
        if !(event?.images?.isEmpty ?? false) {
            if let imaegUrl = URL(string: ApiUrls.base_url + (event?.images?.first ?? "")) {
                eventImageView.sd_setImage(with: imaegUrl)
            }
        }
    }
}
