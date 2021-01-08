//
//  MyPlanResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class MyPlanResponse : BaseResponse {
    
    var data: [EventModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
