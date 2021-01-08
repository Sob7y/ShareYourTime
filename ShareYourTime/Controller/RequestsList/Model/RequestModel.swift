//
//  RequestModel.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/18/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestModel : BaseResponse {
    
    var data: [UserModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
