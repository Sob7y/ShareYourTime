//
//  FriendsPresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class FriendsPresenterImp: FriendsPresenter {
    
    var view: FriendsView!
    
    init(view: FriendsView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getFriends(page: String, limit: String) {
        FriendsApi.getInstance().getFriends(page: page, limit: limit, apiCallBack: self)
    }
    
    func removeUser(userId: String) {
        AddUserApi.getInstance().removeUser(userId: userId, apiCallBack: self)
    }
}

extension FriendsPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is FriendsResponseModel {
            view.didInsertData(response as! FriendsResponseModel)
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
