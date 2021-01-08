//
//  SignupPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class SignupPresenterImp: SignupPresenter {
    
    var view: SignupView!
    
    init(view: SignupView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func signup(name: String, email: String, phone: String, password: String, image: String) {
        view.showLoading()
        SignupApi.getInstance().signup(name: name, email: email, phone: phone, password: password, image: image, apiCallBack: self)
    }
}

extension SignupPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let loginResponse = response as! LoginResponse
        if !(loginResponse.errors.isEmpty) {
            view.showError(message: loginResponse.errors[0])
            return
        }
        view.didSignupAction(response as! LoginResponse)
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        if !error.errors.isEmpty {
            view.showError(message: error.errors[0])
        }
    }
    
}
