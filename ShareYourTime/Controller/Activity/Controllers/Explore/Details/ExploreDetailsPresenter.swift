//
//  ExploreDetailsPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ExploreDetailsPresenter: BasePresenter {
    func getExploreDetails(_ eventId: Int)
    func bookEvent(_ eventId: Int)
}
