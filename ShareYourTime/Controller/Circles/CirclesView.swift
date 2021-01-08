//
//  CirclesView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol CirclesView: BaseView {
    func didInsertData(_ response: CirclesResponse)
}
