//
//  MyPlanView.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/3/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol MyPlanView: BaseView {
    func didInsertData(_ respose: MyPlanResponse)
}
