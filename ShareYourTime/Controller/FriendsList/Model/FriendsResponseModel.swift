//
//  FriendsResponseModel.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class FriendsResponseModel : BaseResponse {
    
    var data: [UserModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
