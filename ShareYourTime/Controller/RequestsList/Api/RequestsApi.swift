//
//  RequestsApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/18/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class RequestsApi {
    
    static let instance = RequestsApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> RequestsApi {
        return instance
    }
    
    func getRequests(page: String, limit: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["page" : page,
                          "limit" : limit,
        ]
        
        print("parameters = \(parameters)")
        
        ApiClient.fetch(url: ApiUrls.requestsListUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension RequestsApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let response = Mapper<RequestsListResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: response as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
