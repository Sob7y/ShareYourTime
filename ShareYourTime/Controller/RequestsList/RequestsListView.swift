//
//  RequestsListView.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol RequestsListView: BaseView {
    func didInsertData(_ response: RequestsListResponse)
}
