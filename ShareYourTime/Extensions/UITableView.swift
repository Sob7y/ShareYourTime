//
//  UITableView.swift
//  Quran
//
//  Created by Mohammed Khaled (Sob7y) on 12/17/18.
//  Copyright © 2018 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(
            frame: CGRect(x: 0,
                          y: 0,
                          width: self.bounds.size.width,
                          height: self.bounds.size.height)
        )
        messageLabel.text = message
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
