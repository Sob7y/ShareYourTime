//
//  CreateCircleApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateCircleApi {
    
    static let instance = CreateCircleApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> CreateCircleApi {
        return instance
    }
    
    func createEvent(title: String, ids: [Int], apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters: [String : Any] = ["name" : title,
                          "connections" : ids
            ]
        
        print("parameters = \(parameters)")
        ApiClient.fetchWithJson(url: ApiUrls.createCircle, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
    
    func editEvent(id: Int, title: String, ids: [Int], apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters: [String : Any] = ["id" : String(id),
                                          "name" : title,
                                          "connections" : ids
        ]
        
        print("parameters = \(parameters)")
        ApiClient.fetchWithJson(url: ApiUrls.updateCircle, httpMethod: .post, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension CreateCircleApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let baseResponse = Mapper<BaseResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: baseResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
