//
//  NormalLoginCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class NormalLoginCell: UITableViewCell {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetPassBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind() {
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 12
        
        loginBtn.setTitle(Strings.sharedInstance.loginTitle, for: .normal)
        forgetPassBtn.setTitle(Strings.sharedInstance.forget_password, for: .normal)

    }
    
    func bindChangePassword() {
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 12
        
        loginBtn.setTitle("change_password".localized, for: .normal)
        
    }

}
