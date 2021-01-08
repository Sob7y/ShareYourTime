//
//  InviteUsersPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class InviteUsersPresenterImp: InviteUsersPresenter {
    
    var view: InviteUsersView!
    var isViewingProfile = false

    init(view: InviteUsersView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    
    func getGroups(page: Int, limit: Int) {
        isViewingProfile = false
        CirclesApi.getInstance().getCircles(page: page, limit: limit, apiCallBack: self)
    }
    
    func getUsers(page: String, limit: String) {
        isViewingProfile = true
        view.showLoading()
        FriendsApi.getInstance().getFriends(page: page, limit: limit, apiCallBack: self)
    }
    
    func invite(type: InviteTypes, eventId: String, ids: [Int]) {
        InviteUsersApi.getInstance().inviteUsers(type: type, eventId: eventId, ids: ids, apiCallBack: self)
    }
    
}

extension InviteUsersPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if response is CirclesResponse {
            let circlesResponse = response as! CirclesResponse
            if !(circlesResponse.errors.isEmpty) {
                view.showError(message: circlesResponse.errors[0])
                return
            }
            view.didInsertGroups(response as! CirclesResponse)
        } else if response is FriendsResponseModel {
            view.didInsertUsers(response as! FriendsResponseModel)
        } else {
            view.didInsertInviteDone()
        }
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
