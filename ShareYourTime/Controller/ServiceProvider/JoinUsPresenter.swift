//
//  JoinUsPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/4/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol JoinUsPresenter: BasePresenter {
    func joinUs(category: Int, terms: String)
    func getCategories()
}
