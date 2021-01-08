//
//  EventDetailsView.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol EventDetailsView: BaseView {
    func didInsertData(_ respose: EventDetailsResponse)
}
