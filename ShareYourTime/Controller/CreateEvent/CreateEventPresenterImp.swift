//
//  CreateEventPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class CreateEventPresenterImp: CreateEventPresenter {
        
    var view: CreateEventView!
    
    init(view: CreateEventView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func createEvent(holdDate: String, title: String, address: String, latitude: String, longitude: String) {
        view.showLoading()
        CreateEventApi.getInstance().createEvent(title: title, holdDate: holdDate, address: address, longitude: longitude, latitude: latitude, image: "", apiCallBack: self)
    }
    
    func createSPEvent(title: String, days: String, duration: String, latitude: String, longitude: String, description: String, images: [String]) {
        view.showLoading()
        CreateEventApi.getInstance().createSPEvent(title: title, days: days, duration: duration, latitude: latitude, longitude: longitude, description: description, images: images, apiCallBack: self)
    }
}

extension CreateEventPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let createEventResponse = response as! CreateEventResponse
        if !(createEventResponse.errors.isEmpty) {
            view.showError(message: createEventResponse.errors[0])
            return
        }
        view.didInsertData(response as! CreateEventResponse)
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors[0])
    }
}
