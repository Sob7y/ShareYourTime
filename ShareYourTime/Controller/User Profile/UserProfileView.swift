//
//  UserProfileView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol UserProfileView: BaseView {
    func didInsertData(_ respose: ProfileResponseModel)
    func didInsertEvents(_ respose: UserEventsResponseModel)
}
