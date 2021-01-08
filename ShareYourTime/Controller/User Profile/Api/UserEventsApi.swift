//
//  UserProfileApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class UserEventsApi {
    
    static let instance = UserEventsApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> UserEventsApi {
        return instance
    }
    
    func getUserEvents(id: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["userId" : id]
        
        print(user.token ?? "")
        ApiClient.fetch(url: ApiUrls.getUsertsEventsUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension UserEventsApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let profileResponseModel = Mapper<UserEventsResponseModel>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: profileResponseModel as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
