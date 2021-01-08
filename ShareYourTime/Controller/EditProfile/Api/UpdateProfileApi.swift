//
//  UpdateProfileApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/29/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class UpdateProfileApi {
    
    static let instance = UpdateProfileApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> UpdateProfileApi {
        return instance
    }
    
    func updateProfile(name: String, phone: String, image: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["phone" : phone,
                          "name" : name,
                          "image" : ApiUrls.base_image_url + image]
        
        ApiClient.fetchWithJson(url: ApiUrls.editProfile, httpMethod: .post, parameters:
            parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension UpdateProfileApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let response = Mapper<ProfileResponseModel>().map(JSONObject: response)        
        guard let userModel = response!.data else {
            self.apiCallBack.onSuccess(response: response as Any)
            return
        }
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userModel as! UserModel)
        userDefaults.set(encodedData, forKey: "uesrModel")
        userDefaults.synchronize()
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
