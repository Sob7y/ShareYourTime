//
//  ProfileApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileApi {
    
    static let instance = ProfileApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> ProfileApi {
        return instance
    }
    
    func getProfile(apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        print(user.token ?? "")
        ApiClient.fetch(url: ApiUrls.getProfile, httpMethod: .get, parameters: [:], headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension ProfileApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let loginResponse = Mapper<ProfileResponseModel>().map(JSONObject: response)
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
