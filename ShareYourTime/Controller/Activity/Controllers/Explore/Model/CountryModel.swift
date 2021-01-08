//
//  CountryModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CountryModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var country: String?
    var flag: String?
    
    func mapping(map: Map) {
        country <- map["country"]
        flag <- map["flag"]
    }
}
