//
//  AcceptRequestApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/18/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class AcceptRequestApi {
    
    static let instance = AcceptRequestApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> AcceptRequestApi {
        return instance
    }
    
    func acceptRequest(userId: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["friendId" : userId]
        
        print("parameters = \(parameters)")
        
        ApiClient.fetch(url: ApiUrls.approveRequestUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
    func rejectRequest(userId: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["friendId" : userId]
        print("parameters = \(parameters)")
        
        ApiClient.fetch(url: ApiUrls.rejectRequestUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension AcceptRequestApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
//        let response = Mapper<RequestsListResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
