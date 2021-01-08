//
//  TopUsersCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class TopUsersCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var userImageView: UIImageView!
    
    var user: UserModel? {
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
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
    }
    
    private func bind() {
        if let imaegUrl = URL(string: ApiUrls.base_url + (user?.image ?? "")) {
            userImageView.sd_setImage(with: imaegUrl)
        }
    }

}
