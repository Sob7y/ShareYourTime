//
//  MaybeEventApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/23/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class MaybeEventApi {
    
    static let instance = MaybeEventApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> MaybeEventApi {
        return instance
    }
    
    func maybeEvent(eventId: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["eventId" : eventId]
        
        print("parameters = \(parameters)")
        ApiClient.fetch(url: ApiUrls.maybeEvent, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension MaybeEventApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
//        let eventDetailsResponse = Mapper<EventDetailsResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
