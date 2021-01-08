//
//  ChangePasswordApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ChangePasswordApi {
    
    static let instance = ChangePasswordApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> ChangePasswordApi {
        return instance
    }
    
    func changePassword(oldPassword: String, newPassword: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["oldPassword" : oldPassword,
                          "newPassword" : newPassword,
        ]
        
        print("parameters = \(parameters)")
        
        ApiClient.fetchWithJson(url: ApiUrls.changePassword, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension ChangePasswordApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
