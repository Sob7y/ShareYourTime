//
//  ChangePasswordPresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/27/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ChangePasswordPresenter: BasePresenter {
    func changePassword(oldPassword: String, newPassword: String)
}
