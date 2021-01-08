//
//  DeleteCircleApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class DeleteCircleApi {
    
    static let instance = DeleteCircleApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> DeleteCircleApi {
        return instance
    }
    
    func deleteCircle(groupId: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        if let decoded = UserDefaults.standard.object(forKey: "uesrModel")  {
            let user = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! UserModel
            let parameters = ["groupId": String(groupId)]
            
            print("parameters = \(parameters)")
            ApiClient.fetch(url: ApiUrls.removeGroup, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        }
    }
}

extension DeleteCircleApi: ApiCallBack {
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
