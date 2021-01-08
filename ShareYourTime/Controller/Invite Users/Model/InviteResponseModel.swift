//
//  InviteResponseModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class InviteResponseModel: BaseResponse {
    var data: [EventModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
