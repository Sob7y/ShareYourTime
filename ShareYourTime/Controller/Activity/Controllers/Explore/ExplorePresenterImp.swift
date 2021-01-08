//
//  ExplorePresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class ExplorePresenterImp: ExplorePresenter {
    
    var view: ExploreView!
    
    init(view: ExploreView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func getExploreData() {
        GetExploreApi.getInstance().getExplore(apiCallBack: self)
    }
}

extension ExplorePresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        let exploreResponse = response as! ExploreResponse
        if !(exploreResponse.errors.isEmpty) {
            view.showError(message: exploreResponse.errors[0])
            return
        }
        view.didInsertData(exploreResponse)
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
