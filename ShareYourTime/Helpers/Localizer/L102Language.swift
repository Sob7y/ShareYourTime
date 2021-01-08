//
//  L102Language.swift
//  Localization102
//
//  Created by Moath_Othman on 2/24/16.
//  Copyright © 2016 Moath_Othman. All rights reserved.
//

import UIKit


private let appleLanguagesKey = "AppleLanguages"

enum L102Language: String {
    
    case `default` = "_"
    case english = "en"
    case arabic = "ar"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .default:
            return .unspecified
        case .arabic:
            return .forceRightToLeft
        default:
            return .forceLeftToRight
        }
    }
    
    var isRTL: Bool {
        switch self {
        case .arabic:
            return true
        default:
            return false
        }
    }
    
    static var language: L102Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = L102Language(rawValue: languageCode) {
                return language
                
            } else {
                
                let preferredLanguage = NSLocale.preferredLanguages[0]
                let index = preferredLanguage.index(preferredLanguage.startIndex, offsetBy: 2)
                
                if let localization = L102Language(rawValue: preferredLanguage) {
                    return localization
                    
                } else if let localization = L102Language(rawValue: String(preferredLanguage[..<index])) {

                    return localization
                    
                } else {
                    return L102Language.english
                    
                }
                    
                /*
                guard let localization = Language(rawValue: String(preferredLanguage[..<index])) else {
                    return Language.english
                }
                
                return localization
                */
            }
        }
        
        set {
            guard language != newValue else {
                /*
                if (Settings.shared.accessToken != nil) || Settings.shared.loginSkipped {
                    WindowManager.shared.show(.main, animated: false, withReset: false)
                } else {
                    WindowManager.shared.show(.account, animated: false, withReset: false)
                }
                */
                return
            }
            
            if newValue == .default {
                UserDefaults.standard.removeObject(forKey: appleLanguagesKey)
                UserDefaults.standard.synchronize()

            } else {
                // change language in the app
                // the language will be changed after restart
                UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
                UserDefaults.standard.synchronize()
                
            }
            
            //Changes semantic to all views
            //this hack needs in case of languages with different semantics: leftToRight(en/uk) & rightToLeft(ar)
            UIView.appearance().semanticContentAttribute = L102Language.language.semantic
            
            //initialize the app from scratch
            //show initial view controller
            //so it seems like the is restarted
            
            /*
            if (Settings.shared.accessToken != nil) || Settings.shared.loginSkipped {
                WindowManager.shared.show(.main, animated: true, withReset: true)
            } else {
                WindowManager.shared.show(.account, animated: true, withReset: true)
            }
            */
        }
    }

}


/*
// constants
/// L102Language
class L102Language {
    static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLanguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLanguageTo(lang: Language2) {
        let userdef = UserDefaults.standard
        let langs = [lang.rawValue, currentAppleLanguage()]
        userdef.set(langs, forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
    
    class var isRTL: Bool {
        return L102Language.currentAppleLanguage()
    }
}
*/
