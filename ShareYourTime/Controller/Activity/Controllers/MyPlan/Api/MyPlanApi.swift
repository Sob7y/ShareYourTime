//
//  MyPlanApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class MyPlanApi {
    
    static let instance = MyPlanApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> MyPlanApi {
        return instance
    }
    
    func getMyList(holdDate: String, page: Int, limit: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["holdDate" : holdDate,
                          "page" : String(page),
                          "limit" : String(limit)
        ]
        
        print("parameters = \(parameters)")
        ApiClient.fetch(url: ApiUrls.myList, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension MyPlanApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let myPlanResponse = Mapper<MyPlanResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: myPlanResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
