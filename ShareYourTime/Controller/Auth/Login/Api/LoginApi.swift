//
//  LoginApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginApi {
    
    static let instance = LoginApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> LoginApi {
        return instance
    }
    
    func login(password: String, email: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let parameters = ["password" : password,
                          "email" : email,]
        
        print("parameters = \(parameters)")
        ApiClient.fetchWithJson(url: ApiUrls.login, httpMethod: .post, parameters: parameters, headers: [:], apiCallBack: self)
        
    }
    
    func fbLogin(socialName: String, socialId: String, name: String, email: String, image: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        
        let parameters = ["socialName" : "Facebook",
                          "socialId" : socialId,
                          "name" : name,
                          "email" : email,
                          "image" : image]
        
        print("parameters = \(parameters)")
        
        ApiClient.fetchWithJson(url: ApiUrls.socialLogin, httpMethod: .post, parameters:
            parameters, headers: [:], apiCallBack: self)
    }    
}

extension LoginApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let loginResponse = Mapper<LoginResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: loginResponse as Any)
        guard let userModel = loginResponse!.data else {
            self.apiCallBack.onSuccess(response: loginResponse as Any)
            return
        }
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userModel as! UserModel)
        userDefaults.set(encodedData, forKey: "uesrModel")
        userDefaults.synchronize()
        self.apiCallBack.onSuccess(response: loginResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
