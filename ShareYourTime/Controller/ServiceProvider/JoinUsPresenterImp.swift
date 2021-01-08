//
//  JoinUsPresenterImp.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/4/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class JoinUsPresenterImp: JoinUsPresenter{
    
    var view: JoinUsView!
    var isResquestingCategories = false

    init(view: JoinUsView) {
        self.view = view
    }
    
    func deAttachView() {
        
    }
    
    func joinUs(category: Int, terms: String) {
        isResquestingCategories = false
        JoinUsApi.getInstance().joinUsAsServicePrivider(category: String(category), terms: terms, apiCallBack: self)
    }
    
    func getCategories() {
        isResquestingCategories = true
        GetSPCategoriesApi.getInstance().getSPCategories(apiCallBack: self)
    }
}

extension JoinUsPresenterImp: ApiCallBack {
    func onSuccess(response: Any) {
        view.hideLoading()
        if isResquestingCategories {
            if let categoriesResponse = response as? SPCategoryResponse {
                view.didInsertCategories(categoriesResponse)
            }
            return
        }
        view.requestDone()
    }
    
    func onFailure(error: ApiError) {
        view.hideLoading()
        view.showError(message: error.errors.count > 0 ? error.errors[0] : "")
    }
}
