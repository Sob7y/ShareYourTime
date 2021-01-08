//
//  SearchPresenter.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol SearchPresenter: BasePresenter {
    func search(keyWord: String)
    func addUser(email: String)
    func removeUser(userId: String)
}
