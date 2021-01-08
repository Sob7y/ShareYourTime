
//
//  EventDetailsPresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class EventDetailsPresenterImp: EventDetailsPresenter {
    
    var view: EventDetailsView!
    var eventId: String?
    
    init(view: EventDetailsView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getEventDetails(eventId: String) {
        self.eventId = eventId
        EventDetailsApi.getInstance().getEventDetails(eventId: eventId, apiCallBack: self)
    }
    func joinEvent(eventId: String) {
        self.eventId = eventId
        JoinEventApi.getInstance().joinEvent(eventId: eventId, apiCallBack: self)
    }
    func maybeEvent(eventId: String) {
        self.eventId = eventId
        MaybeEventApi.getInstance().maybeEvent(eventId: eventId, apiCallBack: self)
    }
}

extension EventDetailsPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is EventDetailsResponse {
            let eventDetailsResponse = response as! EventDetailsResponse
            if !(eventDetailsResponse.errors.isEmpty) {
                view.showError(message: eventDetailsResponse.errors[0])
                return
            }
            view.didInsertData(response as! EventDetailsResponse)
        } else {
            getEventDetails(eventId: self.eventId ?? "")
        }
        
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        if !error.errors.isEmpty {
            view.showError(message: error.errors[0])
        }
    }
}
