//
//  SplashViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //unarchive user model
        if UserDefaults.standard.object(forKey: "uesrModel") != nil {
            self.pushMain()
        } else {
            self.pushLogin()
        }
    }
    
    func pushMain() {
        //push_home
        self.performSegue(withIdentifier: Constant.segues.push_main, sender: nil)
    }
    
    func pushLogin() {
        self.performSegue(withIdentifier: Constant.segues.push_login, sender: nil)
    }

}
