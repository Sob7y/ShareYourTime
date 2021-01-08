//
//  NotificationsResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class NotificationsResponse: BaseResponse {
    var data: [CirclesData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
