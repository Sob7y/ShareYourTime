//
//  ChangePasswordPresenterImp.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class ChangePasswordPresenterImp: ChangePasswordPresenter {
    
    var view: ChangePasswordView!
    
    init(view: ChangePasswordView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func changePassword(oldPassword: String, newPassword: String) {
        view.showLoading()
        ChangePasswordApi.getInstance().changePassword(oldPassword: oldPassword, newPassword: newPassword, apiCallBack: self)
    }
}

extension ChangePasswordPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        view.didInsertData()
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
