//
//  SPCategoryResponse.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/8/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class SPCategoryResponse: BaseResponse {
    var data: [CategoryModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
