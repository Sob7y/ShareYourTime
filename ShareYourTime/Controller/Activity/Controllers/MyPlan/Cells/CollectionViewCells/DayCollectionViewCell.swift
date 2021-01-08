//
//  DayCollectionViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayNameLbl: UILabel!
    @IBOutlet weak var dayDateLbl: UILabel!
    
    
    func bind(_ dayModel: DayModel) {
        dayNameLbl.text = dayModel.name
        dayDateLbl.text = dayModel.date
        
        if dayModel.isSelected {
            containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            containerView.layer.opacity = 1.0
            dayDateLbl.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.dayDateLbl.alpha = 1
            })

        } else {
            containerView.transform = CGAffineTransform.identity
            containerView.layer.opacity = 0.3
            dayDateLbl.alpha = 1
            // fade in
            UIView.animate(withDuration: 0.5, animations: {
                self.dayDateLbl.alpha = 0.0
            })

        }
    }
    
}
