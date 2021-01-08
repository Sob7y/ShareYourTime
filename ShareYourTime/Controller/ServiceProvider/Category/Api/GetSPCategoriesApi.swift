//
//  GetSPCategoriesApi.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/8/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import ObjectMapper

class GetSPCategoriesApi {
    
    static let instance = GetSPCategoriesApi()
    var apiCallBack: ApiCallBack!
    
    init() {
        
    }
    
    static func getInstance() -> GetSPCategoriesApi {
        return instance
    }
    
    func getSPCategories(apiCallBack: ApiCallBack) {
        self.apiCallBack = apiCallBack
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        
        
        print(user.token ?? "")
        ApiClient.fetch(url: ApiUrls.joinUsCategoryList, httpMethod: .get, parameters: [:], headers: ["Authorization" : user.token ?? ""], apiCallBack: self)
    }
}

extension GetSPCategoriesApi: ApiCallBack {
    func onSuccess(response: Any) {
        print("\(response)")
        let responseModel = Mapper<SPCategoryResponse>().map(JSONObject: response)
        self.apiCallBack.onSuccess(response: responseModel as Any)
    }
    
    func onFailure(error: ApiError) {
        print("error = \(error)")
        self.apiCallBack.onFailure(error: error)
    }
}
