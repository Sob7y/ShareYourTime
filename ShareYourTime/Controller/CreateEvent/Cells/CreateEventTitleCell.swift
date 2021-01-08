//
//  CreateEventTitleCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CreateEventTitleCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
//        textfield.delegate = self
//        textfield.selectedLineColor = UIColor.lightGray
//        textfield.isSelected = true
//        textfield.placeholder = Strings.sharedInstance.emailTitle
//        textfield.selectedTitleColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
//        textfield.lineColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.title
        textfield.placeholder = Strings.sharedInstance.titlePlaceholder
    }

}

extension CreateEventTitleCell: UITextFieldDelegate {
    
}

