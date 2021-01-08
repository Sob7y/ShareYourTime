//
//  WhoIsOutRequestCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class WhoIsOutRequestCell: WhoIsOutCell {
    
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var joinLbl: UILabel!
    @IBOutlet weak var mayBeLbl: UILabel!
    @IBOutlet weak var joinImage: UIImageView!
    @IBOutlet weak var mayBeImage: UIImageView!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var mayBeBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func bind(_ eventModel: EventModel) {
        super.bind(eventModel)
        let path = UIBezierPath(roundedRect:requestView.bounds,
                                byRoundingCorners:[.bottomRight, .bottomLeft],
                                cornerRadii: CGSize(width: 12, height:  12))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        requestView.layer.mask = maskLayer
        
        
    }

}
