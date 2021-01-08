//
//  FriendsView.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol FriendsView: BaseView {
    func didInsertData(_ response: FriendsResponseModel)
}
