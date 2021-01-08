//
//  SearchView.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol SearchView: BaseView {
    func didInsertData(_ respose: SearchResponse)
}
