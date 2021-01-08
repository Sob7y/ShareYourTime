//
//  GetExploreApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class GetExploreApi {
    
    static let instance = GetExploreApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> GetExploreApi {
        return instance
    }
    
    func getExplore(apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        print(user.token ?? "")
        ApiClient.fetch(url: ApiUrls.getExploreApi, httpMethod: .get, parameters: [:], headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension GetExploreApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let loginResponse = Mapper<ExploreResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: loginResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
