//
//  NotificationsView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol NotificationsView: BaseView {
    func insertData(_ response: NotificationsResponse)
}
