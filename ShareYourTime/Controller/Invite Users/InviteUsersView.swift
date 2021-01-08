//
//  InviteUsersView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol InviteUsersView: BaseView {
    func didInsertUsers(_ respose: FriendsResponseModel)
    func didInsertGroups(_ response: CirclesResponse)
    func didInsertInviteDone()
}
