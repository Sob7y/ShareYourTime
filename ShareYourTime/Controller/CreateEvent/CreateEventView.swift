//
//  CreateEventView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol CreateEventView: BaseView {
    func didInsertData(_ respose: CreateEventResponse)
}
