//
//  LoginPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class LoginPresenterImp: LoginPresenter {
    
    var view: LoginView!
    
    init(view: LoginView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func login(password: String, email: String) {
        view.showLoading()
        LoginApi.getInstance().login(password: password, email: email, apiCallBack: self)
    }
    
    func fbLogin(socialName: String, socialId: String, name: String, email: String, image: String) {
        view.showLoading()
        LoginApi.getInstance().fbLogin(socialName: socialName, socialId: socialId, name: name, email: email, image: image, apiCallBack: self)
    }
}

extension LoginPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let loginResponse = response as! LoginResponse
        if !(loginResponse.errors.isEmpty) {
            view.showError(message: loginResponse.errors[0])
            return
        }
        view.didLoginAction(response as! LoginResponse)
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        if !error.errors.isEmpty {
            view.showError(message: error.errors[0])
        }
    }
    
    
}
