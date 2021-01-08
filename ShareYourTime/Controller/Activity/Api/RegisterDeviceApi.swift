//
//  RegisterDeviceApi.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 11/8/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import Foundation
import ObjectMapper

class RegisterDeviceApi {
    static let instance = RegisterDeviceApi()
    var apiCallBack : ApiCallBack!
    init(){
    }
    static func getInstance()->RegisterDeviceApi{
        return instance
    }
    
    func registerDevice(deviceToken:String, UUID:String, apiCallBack:ApiCallBack){
        self.apiCallBack = apiCallBack        
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = [
            "firebaseToken" : deviceToken,
            "identifier" : UUID
        ]
        
        ApiClient.fetchWithJson(url: ApiUrls.registerDevice, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension RegisterDeviceApi:ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        
    }
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
