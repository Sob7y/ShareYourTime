//
//  CreateEventSubmitCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CreateEventSubmitCell: UITableViewCell {

    @IBOutlet weak var subbmitBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind() {
        subbmitBtn.layer.masksToBounds = true
        subbmitBtn.layer.cornerRadius = 20
        subbmitBtn.setTitle(Strings.sharedInstance.submit, for: .normal)
    }


}
