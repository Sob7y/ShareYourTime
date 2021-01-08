//
//  WhoIsOutPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class WhoIsOutPresenterImp: WhoIsOutPresenter {
    
    var view: WhoIsOutView!
    
    init(view: WhoIsOutView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getList(holdDate: String, page: Int, limit: Int) {
        WhoIsOutApi.getInstance().getOutList(holdDate: holdDate, page: page, limit: limit, apiCallBack: self)
    }
    
    func joinEvent(eventId: String) {
        JoinEventApi.getInstance().joinEvent(eventId: eventId, apiCallBack: self)
    }
    
    func maybeEvent(eventId: String) {
        MaybeEventApi.getInstance().maybeEvent(eventId: eventId, apiCallBack: self)
    }
}

extension WhoIsOutPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is MyPlanResponse {
            let myPlanResponse = response as! MyPlanResponse
            if !(myPlanResponse.errors.isEmpty) {
                view.showError(message: myPlanResponse.errors[0])
                return
            }
            view.didInsertData(response as! MyPlanResponse)
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        if !error.errors.isEmpty {
            view.showError(message: error.errors[0])
        }
    }
}
