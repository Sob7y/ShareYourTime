//
//  CreateCirclePresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol CreateCirclePresenter: BasePresenter {
    func getFriends(page: String, limit: String)
    func createCircle(title: String, ids: [Int])
}
