//
//  TopCountriesData.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class TopCountriesData: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var countries: [CountryModel]?
    var total: Int?
    var rest: Int?
    
    func mapping(map: Map) {
        countries <- map["countries"]
        total <- map["total"]
        rest <- map["rest"]
    }
}
