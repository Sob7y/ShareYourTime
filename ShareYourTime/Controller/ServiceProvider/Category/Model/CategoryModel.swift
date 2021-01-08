//
//  CategoryModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/8/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    var id: Int?
    var nameAr: String?
    var nameEn: String?
    var createdAt: String?
    var updatedAt: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        nameAr <- map["name_ar"]
        nameEn <- map["name_en"]
        updatedAt <-  map["updated_at"]
        createdAt <- map["created_at"]
    }
}
