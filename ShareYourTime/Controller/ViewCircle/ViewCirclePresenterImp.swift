//
//  ViewCirclePresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class ViewCirclePresenterImp: ViewCirclePresenter {
    
    var view: ViewCircleView!
    
    init(view: ViewCircleView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getCircleDetails(id: Int, page: Int, limit: Int) {
        ViewCircleApi.getInstance().getDetails(id: id, page: page, limit: limit, apiCallBack: self)
    }
    
    func editCircle(id: Int, title: String, ids: [Int]) {
        view.showLoading()
        CreateCircleApi.getInstance().editEvent(id: id, title: title, ids: ids, apiCallBack: self)
    }
}

extension ViewCirclePresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is ViewCircleResponse {
            view.didInsertData(response as! ViewCircleResponse)
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
