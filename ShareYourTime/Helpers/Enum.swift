//
//  Enum.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit


public enum loginCells: Int {
    case empty = 0
    case email = 1
    case password = 2
    case login = 3
    case fbLogin = 4
}

public enum signupCells: Int {
    case photo = 0
    case name = 1
    case email = 2
    case phone = 3
    case password = 4
    case confirmPassword = 5
    case register = 6
}

public enum createEventCells: Int {
    case title = 0
    case date
    case location
    case submit
}

public enum createSPEventCells: Int {
    case title = 0
    case date
    case location
    case submit
}

public enum relation: Int {
    case notFriend = 1
    case pending = 2
    case friend = 3
}


