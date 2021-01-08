//
//  AddUserApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class AddUserApi {
    
    static let instance = AddUserApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> AddUserApi {
        return instance
    }
    
    func addUser(email: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["email": email]
        
        ApiClient.fetchWithJson(url: ApiUrls.addUsersUrl, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
    func removeUser(userId: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["friendId": userId]
        
        ApiClient.fetch(url: ApiUrls.removeUserUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension AddUserApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let searchResponse = Mapper<BaseResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: searchResponse)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
