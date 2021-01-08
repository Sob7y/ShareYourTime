//
//  ViewCircleView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ViewCircleView: BaseView {
    func didInsertData(_ response: ViewCircleResponse)
    func circleCreated()
}
