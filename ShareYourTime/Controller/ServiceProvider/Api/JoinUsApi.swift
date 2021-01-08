//
//  JoinUsApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/4/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class JoinUsApi {
    
    static let instance = JoinUsApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> JoinUsApi {
        return instance
    }
    
    func joinUsAsServicePrivider(category: String, terms: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["category" : category,
                          "terms": terms]
        
        print(user.token ?? "")
        ApiClient.fetchWithJson(url: ApiUrls.becomeServicePrivider, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension JoinUsApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }    
}
