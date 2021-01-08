//
//  LoginResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse : BaseResponse {
    
    var data: UserModel!
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
