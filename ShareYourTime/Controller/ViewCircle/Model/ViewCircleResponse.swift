//
//  ViewCircleResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ViewCircleResponse : BaseResponse {
    
    var data: [CirclesData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
