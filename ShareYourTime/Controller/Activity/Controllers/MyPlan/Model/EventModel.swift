//
//  EventModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class EventModel: Mappable {
    required init?(map: Map) {
        
    }
    
    init(id: Int) {
        self.id = id
    }
    
    var id: Int?
    var title: String?
    var address: String?
    var holdDate: Double?
    var latitude: Double?
    var longitude: Double?
    var token: String?
    var image: String?
    var totalJoined: Int?
    var totalMaybe: Int?
    var createdBy: UserModel?
    var joinedUsers: [UserModel]?
    var maybeUsers: [UserModel]?
    var createdAt: Double?
    var joinType: JoinType?
    
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        address <-  map["address"]
        holdDate <- map["hold_date"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        image <- map["image"]
        
        totalJoined <- map["totalJoined"]
        totalMaybe <- map["totalMaybe"]
        createdBy <- map["createdBy"]
        createdAt <- map["createdAt"]
        joinType <- map["joinType"]
        joinedUsers <- map["joinedUsers"]
        maybeUsers <- map["maybeUsers"]
    }
}

public enum JoinType : String {
    case empty = ""
    case owner = "Owner"
    case join = "Join"
    case maybe = "Maybe"
    
    static func getStatusPeriod(value: String) -> JoinType? {
        return JoinType(rawValue: value.lowercased())
    }
}
