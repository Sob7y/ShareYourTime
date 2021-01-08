//
//  UserProfileApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class UserProfileApi {
    
    static let instance = UserProfileApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> UserProfileApi {
        return instance
    }
    
    func getProfile(id: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["id" : id]
        
        print(user.token ?? "")
        ApiClient.fetch(url: ApiUrls.getProfile, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension UserProfileApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let profileResponseModel = Mapper<ProfileResponseModel>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: profileResponseModel as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
