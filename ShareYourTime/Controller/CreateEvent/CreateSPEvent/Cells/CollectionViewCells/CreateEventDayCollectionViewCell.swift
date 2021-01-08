//
//  CreateEventDayCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CreateEventDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var dayNameLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    var dayModel: CreateEventDayModel? {
        didSet {
            bind()
        }
    }
    
    private func bind() {
        dayNameLabel.text = dayModel?.shortName
        if let model = dayModel {
            dayNameLabel.textColor = model.isSelected ? UIColor.white : UIColor.uclaBlue
            containerView.backgroundColor = model.isSelected ? UIColor.uclaBlue : UIColor.clear
        }
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
    }

}
