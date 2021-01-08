//
//  BaseResponse.swift
//  Watheq
//
//  Created by Mohammed Khaled (Sob7y) on 1/24/18.
//  Copyright © 2018 Watheq. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    
    var code: Int?
    var message: String?
    var status = false
    var errors: [String] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        status <- map["status"]
        errors <- map["errors"]
    }
}
