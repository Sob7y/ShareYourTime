//
//  SignupPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol SignupPresenter: BasePresenter {
    func signup(name: String, email: String, phone: String, password: String, image: String)
}
