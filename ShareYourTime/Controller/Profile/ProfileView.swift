//
//  ProfileView.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol ProfileView: BaseView {
    func didInsertData(_ respose: ProfileResponseModel)
}
