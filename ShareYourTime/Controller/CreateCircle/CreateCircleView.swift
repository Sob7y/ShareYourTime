//
//  CreateCircleView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol CreateCircleView: BaseView {
    func didInsertData(_ response: FriendsResponseModel)
    func circleCreated()
}
