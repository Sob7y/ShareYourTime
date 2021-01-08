//
//  ExploreDetailsView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ExploreDetailsView: BaseView {
    func didInsertData(_ respose: ExploreDetailsResponse)
    func eventBooked()
}
