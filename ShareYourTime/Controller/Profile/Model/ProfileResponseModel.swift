//
//  ProfileResponseModel.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileResponseModel : BaseResponse {
    
    var data: UserModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
