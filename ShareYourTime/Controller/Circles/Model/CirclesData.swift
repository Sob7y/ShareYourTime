//
//  CirclesData.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/11/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CirclesData : Mappable {
    
    var circle: CircleModel?
    var connections: [UserModel]?
    var isMember = false
    
    func mapping(map: Map) {
        circle <- map["group"]
        connections <- map["connections"]
    }
    
    required init?(map: Map) {
        
    }
}
