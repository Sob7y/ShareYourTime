//
//  LoginPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol LoginPresenter: BasePresenter {
    func login(password: String, email: String)
    func fbLogin(socialName: String, socialId: String, name: String, email: String, image: String)
}
