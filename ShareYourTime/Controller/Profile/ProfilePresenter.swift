//
//  ProfilePresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ProfilePresenter: BasePresenter {
    func getProfile()
    func updateProfile(name: String, phone: String, image: String)
}
