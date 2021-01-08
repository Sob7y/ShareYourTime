//
//  SearchPresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class SearchPresenterImp: SearchPresenter {
    
    var view: SearchView!
    
    init(view: SearchView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func search(keyWord: String) {
        SearchApi.getInstance().search(keyWord: keyWord, apiCallBack: self)
    }
    
    func addUser(email: String) {
        AddUserApi.getInstance().addUser(email: email, apiCallBack: self)
    }
    
    func removeUser(userId: String) {
        AddUserApi.getInstance().removeUser(userId: userId, apiCallBack: self)
    }
}

extension SearchPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let searchResponse = response as! BaseResponse
        if !(searchResponse.errors.isEmpty) {
            view.showError(message: searchResponse.errors[0])
            return
        }
        if response is SearchResponse {
            view.didInsertData(searchResponse as! SearchResponse)
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
