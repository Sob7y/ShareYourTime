//
//  UserProfilePresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol UserProfilePresenter: BasePresenter {
    func getUserProfile(_ id: String)
    func getUserEvents(_ id: String)
}
