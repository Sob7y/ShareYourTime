//
//  EventDetailsResponse.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class EventDetailsResponse : BaseResponse {
    
    var data: EventModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
