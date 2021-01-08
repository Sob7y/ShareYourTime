//
//  CirclesPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class CirclesPresenterImp: CirclesPresenter {
    
    var view: CirclesView!
    
    init(view: CirclesView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getCircles(page: Int, limit: Int) {
        CirclesApi.getInstance().getCircles(page: page, limit: limit, apiCallBack: self)
    }
    
    func deleteCircle(id: Int) {
        DeleteCircleApi.getInstance().deleteCircle(groupId: id, apiCallBack: self)
    }
}

extension CirclesPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is CirclesResponse {
            let circlesResponse = response as! CirclesResponse
            if !(circlesResponse.errors.isEmpty) {
                view.showError(message: circlesResponse.errors[0])
                return
            }
            view.didInsertData(response as! CirclesResponse)
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        if !error.errors.isEmpty {
            view.showError(message: error.errors[0])
        }
    }
}
