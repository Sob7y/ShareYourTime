//
//  TopCountriesCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class TopCountriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var countryImageView: UIImageView!
    @IBOutlet private weak var countryTitleLabel: UILabel!
    @IBOutlet private weak var countryDescriptionLabel: UILabel!
    
    var country: CountryModel? {
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
        countryImageView.layer.masksToBounds = true
        countryImageView.layer.cornerRadius = 12
    }
    
    private func bind() {
        countryTitleLabel.text = country?.country ?? ""
        
        if let imaegUrl = URL(string: country?.flag ?? "") {
            countryImageView.sd_setImage(with: imaegUrl)
        }
    }
}
