//
//  ViewCircleApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ViewCircleApi {
    
    static let instance = ViewCircleApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> ViewCircleApi {
        return instance
    }
    
    func getDetails(id: Int, page: Int, limit: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters: [String : Any] = ["id": id,
                          "page" : String(page),
                          "limit" : String(limit),
        ]
        print("parameters = \(parameters)")
        ApiClient.fetch(url: ApiUrls.viewCircle, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension ViewCircleApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let baseResponse = Mapper<ViewCircleResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: baseResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
