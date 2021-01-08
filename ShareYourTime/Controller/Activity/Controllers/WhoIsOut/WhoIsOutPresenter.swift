//
//  WhoIsOutPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol WhoIsOutPresenter: BasePresenter {
    func getList(holdDate: String, page: Int, limit: Int)
    func joinEvent(eventId: String)
    func maybeEvent(eventId: String)
}
