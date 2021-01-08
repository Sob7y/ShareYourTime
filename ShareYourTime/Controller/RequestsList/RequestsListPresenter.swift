//
//  RequestsListPresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol RequestsListPresenter: BasePresenter {
    func getRequests(page: String, limit: String)
    func acceptRequest(_ userId: String)
    func rejectRequest(_ userId: String)
}
