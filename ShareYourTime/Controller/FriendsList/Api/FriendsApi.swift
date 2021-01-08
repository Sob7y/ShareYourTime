//
//  FriendsApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/18/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class FriendsApi {
    
    static let instance = FriendsApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> FriendsApi {
        return instance
    }
    
    func getFriends(page: String, limit: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["page" : page,
                          "limit" : limit,
        ]
        
        print("parameters = \(parameters)")
        
        ApiClient.fetch(url: ApiUrls.friendsListUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension FriendsApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let response = Mapper<FriendsResponseModel>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
