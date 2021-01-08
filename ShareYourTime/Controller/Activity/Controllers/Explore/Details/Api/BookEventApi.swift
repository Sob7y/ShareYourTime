//
//  BookEventApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class BookEventApi {
    
    static let instance = BookEventApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> BookEventApi {
        return instance
    }
    
    func bookEvent(eventId: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["eventId" : String(eventId)]
        
        print("parameters = \(parameters)")
        ApiClient.fetch(url: ApiUrls.bookEventApi, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension BookEventApi: ApiCallBack {
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
