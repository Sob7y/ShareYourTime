//
//  InviteGroupCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class InviteGroupCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var addCircleButton: UIButton!
    
    var circleData: CirclesData? {
        didSet {
            fillData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func fillData() {
        if let name = circleData?.circle?.name {
            titleLabel.text = name
        }
        
        let addImg = UIImage(named: "ic_invite_check_off")
        let addedImg = UIImage(named: "ic_invite_check_on")
        
        addCircleButton.setImage((circleData?.isMember ?? false) ? addedImg : addImg, for: .normal)
    }

}
