//
//  Defaults.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation

class Defaults: NSObject {
    
    static let sharedInstance = Defaults()
    
    var applicationLanguage:Langugage? {
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "APPLICATION_LANGUAGE")
            UserDefaults.standard.synchronize()
        }
        
        get {
            let userDefaultValue = UserDefaults.standard.value(forKey: "APPLICATION_LANGUAGE")
            if let langugage = userDefaultValue {
                if let langugage = Langugage(rawValue: langugage as! String) {
                    return langugage
                }
            }
            
            return .notSet
        }
    }
}
