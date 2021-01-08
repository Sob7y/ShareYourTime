//
//  ExploreDetailsApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class ExploreDetailsApi {
    
    static let instance = ExploreDetailsApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> ExploreDetailsApi {
        return instance
    }
    
    func getExploreDetails(eventId: Int, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["eventId" : String(eventId)]
        
        print("parameters = \(parameters)")
        ApiClient.fetch(url: ApiUrls.getExploreDetailsApi, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension ExploreDetailsApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let detailsResponse = Mapper<ExploreDetailsResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: detailsResponse as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
