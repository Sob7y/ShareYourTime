//
//  SPCategoryCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/8/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SPCategoryCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    var categoryModel: CategoryModel? {
        didSet {
            bind()
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
    
    private func bind() {
        categoryNameLabel.text = categoryModel?.nameEn ?? ""
    }
}
