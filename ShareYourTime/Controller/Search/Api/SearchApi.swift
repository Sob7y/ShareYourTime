//
//  SearchApi.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchApi {
    
    static let instance = SearchApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> SearchApi {
        return instance
    }
    
    func search(keyWord: String, apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        let parameters = ["keyword": keyWord]
        
        ApiClient.fetch(url: ApiUrls.searchUsersUrl, httpMethod: .get, parameters: parameters, headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
        
    }
}

extension SearchApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let searchResponse = Mapper<SearchResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: searchResponse as? SearchResponse)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
    
    
}
