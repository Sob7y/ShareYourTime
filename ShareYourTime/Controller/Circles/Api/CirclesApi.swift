//
//  CirclesApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class CirclesApi {
    
    static let instance = CirclesApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> CirclesApi {
        return instance
    }
    
    func getCircles(page: Int, limit: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        if let decoded = UserDefaults.standard.object(forKey: "uesrModel")  {
            let user = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! UserModel
            let parameters = ["page" : String(page),
                              "limit" : String(limit)
            ]
            
            print("parameters = \(parameters)")
            ApiClient.fetch(url: ApiUrls.gettCirclesUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        }
        
    }
}

extension CirclesApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let circlesResponse = Mapper<CirclesResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: circlesResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
