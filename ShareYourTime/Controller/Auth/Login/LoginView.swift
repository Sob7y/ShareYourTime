//
//  LoginView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol LoginView: BaseView {
    func didLoginAction(_ loginResponse: LoginResponse)
}
