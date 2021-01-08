//
//  NotificationsPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/7/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class NotificationsPresenterImp: NotificationsPresenter {
    
    var view: NotificationsView!
    
    init(view: NotificationsView) {
        self.view = view
    }
    
    func getNotification() {
        
    }
    
    func deAttachView() {
        
    }
    
}

extension NotificationsPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        
    }
    
    func onFailure(error: ApiError) {
        
    }
        
}
