//
//  CreateEventDayModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class CreateEventDayModel: NSObject {
    var name: String?
    var shortName: String?
    var isSelected = false
    
    init(_ name: String, _ shortName: String, _ isSelected: Bool) {
        self.name = name
        self.shortName = shortName
        self.isSelected = isSelected
    }
}
