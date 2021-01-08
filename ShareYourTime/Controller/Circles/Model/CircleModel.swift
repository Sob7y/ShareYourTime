//
//  CircleModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CircleModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var id: Int?
    var name: String?
    var totalFriends: Int?
    var createdAt: String?
    var userId: Int?
    var updatedAt: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        userId <- map["user_id"]
        totalFriends <-  map["total_users"]
        updatedAt <- map["updated_at"]
        createdAt <- map["createdAt"]
    } 
}
