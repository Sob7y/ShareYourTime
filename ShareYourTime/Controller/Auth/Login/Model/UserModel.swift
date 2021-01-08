//
//  UserModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: NSObject, NSCoding, Mappable {
    
    var id: Int?
    var name: String?
    var email: String?
    var image: String?
    var phone: Int?
    var createdAt: String?
    var token: String?
    var language: String?
    var eventCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    var notificationStatus: Int?
    var isSelected = false
    var isFriend: Bool?
    var relation: relation?
    var isMember: Bool?
    var isServiceProvider: Bool?
    
    required init?(map: Map) {
        
    }
    
    override init() {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        token <- map["token"]
        phone <-  map["phone"]
        createdAt <- map["createdAt"]
        name <- map["name"]
        email <- map["email"]
        image <- map["image"]
        language <- map["language"]
        eventCount <- map["eventCount"]
        followingCount <- map["followingCount"]
        followersCount <- map["followersCount"]
        notificationStatus <- map["notificationStatus"]
        isFriend <- map["isFriend"]
        relation <- map["relation"]
        isMember <- map["isMember"]
        isServiceProvider <- map["isServiceProvider"]
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? Int
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        isMember = aDecoder.decodeObject(forKey: "isMember") as? Bool
        isServiceProvider = aDecoder.decodeObject(forKey: "isServiceProvider") as? Bool
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if isMember != nil{
            aCoder.encode(isMember, forKey: "isMember")
        }
        if isServiceProvider != nil{
            aCoder.encode(isServiceProvider, forKey: "isServiceProvider")
        }
    }    
}
