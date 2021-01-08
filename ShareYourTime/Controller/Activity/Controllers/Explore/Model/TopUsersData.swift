//
//  TopUsersData.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class TopUsersData: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var users: [UserModel]?
    var total: Int?
    var rest: Int?
    
    
    func mapping(map: Map) {
        users <- map["users"]
        total <- map["total"]
        rest <- map["rest"]
    }
}
