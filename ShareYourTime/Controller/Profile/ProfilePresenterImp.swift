//
//  ProfilePresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class ProfilePresenterImp: ProfilePresenter {
    
    var view: ProfileView!
    
    init(view: ProfileView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getProfile() {
        view.showLoading()
        ProfileApi.getInstance().getProfile(apiCallBack: self)
    }
    
    func updateProfile(name: String, phone: String, image: String) {
        view.showLoading()
        UpdateProfileApi.getInstance().updateProfile(name: name, phone: phone, image: image, apiCallBack: self)
    }
}

extension ProfilePresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let profileResponseModel = response as! ProfileResponseModel
        if !(profileResponseModel.errors.isEmpty) {
            view.showError(message: profileResponseModel.errors[0])
            return
        }
        view.didInsertData(response as! ProfileResponseModel)
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
