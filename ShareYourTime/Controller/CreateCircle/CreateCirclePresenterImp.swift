//
//  CreateCirclePresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class CreateCirclePresenterImp: CreateCirclePresenter {
    
    var view: CreateCircleView!
    
    init(view: CreateCircleView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getFriends(page: String, limit: String) {
        FriendsApi.getInstance().getFriends(page: page, limit: limit, apiCallBack: self)
    }
    
    func createCircle(title: String, ids: [Int]) {
        view.showLoading()
        CreateCircleApi.getInstance().createEvent(title: title, ids: ids, apiCallBack: self)
    }
}

extension CreateCirclePresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is FriendsResponseModel {
            view.didInsertData(response as! FriendsResponseModel)
        } else {
            let baseResponse = response as? BaseResponse
            if !(baseResponse?.errors.isEmpty ?? false) {
                view.showError(message: baseResponse?.errors[0] ?? "")
                return
            }
            view.circleCreated()
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
