//
//  RegisterActionCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/29/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class RegisterActionCell: UITableViewCell {

    @IBOutlet weak var registerBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind() {
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = 12
        
        registerBtn.setTitle(Strings.sharedInstance.register_title, for: .normal)
    }
}
