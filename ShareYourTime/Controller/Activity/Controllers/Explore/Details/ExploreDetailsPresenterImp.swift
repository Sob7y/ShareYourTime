//
//  ExploreDetailsPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class ExploreDetailsPresenterImp: ExploreDetailsPresenter {
    
    var view: ExploreDetailsView!
    
    init(view: ExploreDetailsView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getExploreDetails(_ eventId: Int) {
        ExploreDetailsApi.getInstance().getExploreDetails(eventId: eventId, apiCallBack: self)
    }
    
    func bookEvent(_ eventId: Int) {
        BookEventApi.getInstance().bookEvent(eventId: eventId, apiCallBack: self)
    }
}

extension ExploreDetailsPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if let exploreResponse = response as? ExploreDetailsResponse {
            if !(exploreResponse.errors.isEmpty) {
                view.showError(message: exploreResponse.errors[0])
                return
            }
            view.didInsertData(exploreResponse)
        } else {
            view.eventBooked()
        }
        
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
