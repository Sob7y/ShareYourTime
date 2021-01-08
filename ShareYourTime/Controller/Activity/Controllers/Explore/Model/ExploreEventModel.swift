//
//  ExploreEventModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ExploreEventModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var id: Int?
    var title: String?
    var description: String?
    var days: String?
    var duration: Int?
    var latitude: Double?
    var longitude: Double?
    var totalJoined: Int?
    var createdBy: UserModel?
    var url: String?
    var createdAt: String?
    var joinedUsers: [UserModel]?
    var images: [String]?
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        days <-  map["days"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        
        totalJoined <- map["totalJoined"]
        createdBy <- map["createdBy"]
        url <- map["url"]
        createdAt <-  map["createdAt"]
        joinedUsers <- map["joinedUsers"]
        images <- map["images"]
        duration <- map["duration"]
    }
}
