//
//  ApiError.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 8/14/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import Foundation
class ApiError{

    var errorMessage : String = ""
    var errorCode : Int!
    var errors : [String] = []
    init(errorMessage:String, errorCode:Int, errors: [String]) {
        self.errorMessage = errorMessage
        self.errorCode = errorCode
        self.errors = errors
    }
}
