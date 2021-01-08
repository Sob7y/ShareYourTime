//
//  CreateEventPresenter.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

protocol CreateEventPresenter: BasePresenter {
    func createEvent(holdDate: String, title: String, address: String, latitude: String, longitude: String)
    func createSPEvent(title: String, days: String, duration: String, latitude: String, longitude: String, description: String, images: [String])
}
