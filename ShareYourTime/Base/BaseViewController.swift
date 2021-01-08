//
//  BaseViewController.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 8/14/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import UIKit
import TTGSnackbar
import Firebase
import NVActivityIndicatorView
import SwiftMessages

class BaseViewController: UIViewController, NVActivityIndicatorViewable {

    var dimmingView = UIView()
    var subViewheight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dimmingView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        dimmingView.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let className = String(describing: type(of: self))
        Analytics.logEvent(className, parameters: [:])
    }
    
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController: BaseView {
    func showLoading() {
        startAnimating()
    }
    
    func hideLoading() {
        stopAnimating()
}
    
    func showError(message: String) {
        let error = MessageView.viewFromNib(layout: .tabView)
        error.configureTheme(.error)
        error.configureContent(title: "error".localized, body: message)
        error.button?.isHidden = true
        var errorConfig = SwiftMessages.defaultConfig
        errorConfig.presentationStyle = .top
        errorConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: errorConfig, view: error)
    }
    
    func showSuccessMessage(message: String) {
        let success = MessageView.viewFromNib(layout: .tabView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "success".localized, body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
}
