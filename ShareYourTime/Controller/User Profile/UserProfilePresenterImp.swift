//
//  UserProfilePresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class UserProfilePresenterImp: UserProfilePresenter {
    
    var view: UserProfileView!
    var isViewingProfile = false
    var userId: String?
    
    init(view: UserProfileView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getUserProfile(_ id: String) {
        isViewingProfile = true
        view.showLoading()
        userId = id
        UserProfileApi.getInstance().getProfile(id: id, apiCallBack: self)
    }
    
    func getUserEvents(_ id: String) {
        isViewingProfile = false
        userId = id
        UserEventsApi.getInstance().getUserEvents(id: id, apiCallBack: self)
    }
    
}

extension UserProfilePresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is ProfileResponseModel {
            let profileResponseModel = response as! ProfileResponseModel
            if !(profileResponseModel.errors.isEmpty) {
                view.showError(message: profileResponseModel.errors[0])
                return
            }
            getUserEvents(userId ?? "")
            view.didInsertData(response as! ProfileResponseModel)
        } else if response is UserEventsResponseModel {
            let eventsResponseModel = response as! UserEventsResponseModel
            if !(eventsResponseModel.errors.isEmpty) {
                view.showError(message: eventsResponseModel.errors[0])
                return
            }
            view.didInsertEvents(response as! UserEventsResponseModel)
        }
        
//        if isViewingProfile {
//            let profileResponseModel = response as! ProfileResponseModel
//            if !(profileResponseModel.errors.isEmpty) {
//                view.showError(message: profileResponseModel.errors[0])
//                return
//            }
//            view.didInsertData(response as! ProfileResponseModel)
//            return
//        } else {
//
//        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
