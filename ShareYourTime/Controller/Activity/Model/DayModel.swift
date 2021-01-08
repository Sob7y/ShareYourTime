//
//  DayModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class DayModel: NSObject {
    var name: String?
    var date: String?
    var timeStamp: String?
    var isSelected = false
    
    init(_ name: String, _ date: String, _ isSelected: Bool, _ timeStamp: String) {
        self.name = name
        self.date = date
        self.isSelected = isSelected
        self.timeStamp = timeStamp
    }
}
