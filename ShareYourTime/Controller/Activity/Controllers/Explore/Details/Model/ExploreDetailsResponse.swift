//
//  ExploreDetailsResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ExploreDetailsResponse : BaseResponse {
    
    var data: ExploreEventModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
