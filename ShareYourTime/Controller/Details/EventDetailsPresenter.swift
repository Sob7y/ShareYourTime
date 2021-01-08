//
//  EventDetailsPresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol EventDetailsPresenter: BasePresenter {
    func getEventDetails(eventId: String)
    func joinEvent(eventId: String)
    func maybeEvent(eventId: String)
}
