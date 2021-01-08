//
//  ExploreData.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ExploreData: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var latest: [ExploreEventModel]?
    var mostBooked: [ExploreEventModel]?
    var topUsers: TopUsersData?
    var topCountries: TopCountriesData?
    
    func mapping(map: Map) {
        latest <- map["latest"]
        mostBooked <- map["mostBooked"]
        topUsers <- map["topUsers"]
        topCountries <-  map["topCountries"]
    }
}
