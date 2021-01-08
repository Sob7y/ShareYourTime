//
//  RequestsListPresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class RequestsListPresenterImp: RequestsListPresenter {
    
    var view: RequestsListView!
    
    init(view: RequestsListView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getRequests(page: String, limit: String) {
        RequestsApi.getInstance().getRequests(page: page, limit: limit, apiCallBack: self)
    }
    
    func acceptRequest(_ userId: String) {
        AcceptRequestApi.getInstance().acceptRequest(userId: userId, apiCallBack: self)
    }
    
    func rejectRequest(_ userId: String) {
        AcceptRequestApi.getInstance().rejectRequest(userId: userId, apiCallBack: self)
    }
}

extension RequestsListPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is RequestsListResponse {
            view.didInsertData(response as! RequestsListResponse)
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
