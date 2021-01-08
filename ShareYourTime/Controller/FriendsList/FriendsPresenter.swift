//
//  FriendsPresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol FriendsPresenter: BasePresenter {
    func getFriends(page: String, limit: String)
    func removeUser(userId: String)
}
