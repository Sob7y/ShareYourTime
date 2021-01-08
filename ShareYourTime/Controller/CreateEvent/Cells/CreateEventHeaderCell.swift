//
//  CreateEventHeaderCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CreateEventHeaderCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.createTitle
        descLbl.text = Strings.sharedInstance.createSubTitle
    }
    
    func bindCircle() {
        titleLbl.text = "create_circle".localized
        descLbl.text = "create_your_own_circle".localized
    }

}
