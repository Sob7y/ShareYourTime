//
//  CreateEventApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateEventApi {
    
    static let instance = CreateEventApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> CreateEventApi {
        return instance
    }
    
    func createEvent(title: String, holdDate: String, address: String, longitude: String, latitude: String, image: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["title" : title,
                          "hold_date" : holdDate,
                          "address" : address,
                          "longitude" : longitude,
                          "latitude" : latitude,
                          "image" : "data:image/jpeg;base64,/9j/4AA"
        ]
        
        print("parameters = \(parameters)")
        ApiClient.fetchWithJson(url: ApiUrls.createEvent, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
    
    func createSPEvent(title: String, days: String, duration: String, latitude: String, longitude: String, description: String, images: [String], apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters: [String: Any] = ["title" : title,
                                         "days" : days,
                                         "duration" : duration,
                                         "description" : description,
                                         "longitude" : longitude,
                                         "latitude" : latitude,
                                         "images" : images
        ]
        
        print("parameters = \(parameters)")
        ApiClient.fetchWithJson(url: ApiUrls.createSPEventApi, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension CreateEventApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let createEventResponse = Mapper<CreateEventResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: createEventResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
