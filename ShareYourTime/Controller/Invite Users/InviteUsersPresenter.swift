//
//  InviteUsersPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol InviteUsersPresenter: BasePresenter {
    func getUsers(page: String, limit: String)
    func getGroups(page: Int, limit: Int)
    func invite(type: InviteTypes, eventId: String, ids: [Int])
}
