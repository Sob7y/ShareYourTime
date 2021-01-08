//
//  ExploreView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ExploreView: BaseView {
    func didInsertData(_ respose: ExploreResponse)
}
