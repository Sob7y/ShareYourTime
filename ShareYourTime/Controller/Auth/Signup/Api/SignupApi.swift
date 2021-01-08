//
//  SignupApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class SignupApi {
    
    static let instance = SignupApi()
    var apiCallBack: ApiCallBack!

    init() {
        
    }
    
    static func getInstance() -> SignupApi {
        return instance
    }
    
    func signup(name: String, email: String, phone: String, password: String, image: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack

        let parameters = ["phone" : phone,
                          "name" : name,
                          "email" : email,
                          "password" : password,
                          "image" : ApiUrls.base_image_url + image]
        
//        print("parameters = \(parameters)")
        
        ApiClient.fetchWithJson(url: ApiUrls.register, httpMethod: .post, parameters:
            parameters, headers: [:], apiCallBack: self)
    }    
}

extension SignupApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let loginResponse = Mapper<LoginResponse>().map(JSONObject: response)
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
