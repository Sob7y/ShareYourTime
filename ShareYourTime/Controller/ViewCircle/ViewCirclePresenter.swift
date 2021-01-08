//
//  ViewCirclePresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ViewCirclePresenter: BasePresenter {
    func getCircleDetails(id: Int, page: Int, limit: Int)
    func editCircle(id: Int, title: String, ids: [Int])
}
