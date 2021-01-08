//
//  FacebookLoginCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class FacebookLoginCell: UITableViewCell {

    @IBOutlet weak var fbLoginBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind() {
        fbLoginBtn.layer.masksToBounds = true
        fbLoginBtn.layer.cornerRadius = 12
        
        fbLoginBtn.setTitle(Strings.sharedInstance.facebook_login, for: .normal)
    }

}
