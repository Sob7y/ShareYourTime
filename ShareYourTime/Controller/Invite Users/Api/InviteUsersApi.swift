//
//  UserProfileApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class InviteUsersApi {
    
    static let instance = InviteUsersApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> InviteUsersApi {
        return instance
    }
    
    func inviteUsers(type: InviteTypes, eventId: String, ids: [Int], apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters: [String : Any] = ["eventId" : eventId, "inviteType": type.rawValue, "ids": ids]
        
        print(user.token ?? "")
        ApiClient.fetchWithJson(url: ApiUrls.inviteUrl, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension InviteUsersApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let inviteResponseModel = Mapper<InviteResponseModel>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: inviteResponseModel as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
