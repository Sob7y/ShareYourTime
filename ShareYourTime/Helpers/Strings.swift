//
//  Strings.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import UIKit

public enum Langugage: String { 
    case arabic = "ar"
    case english = "en"
    case notSet = "En"
}

protocol StringsProtocol {
    func didLangugageChanged ()
}

class Strings: NSObject {
    static let sharedInstance = Strings()
    private var _currentLangugae:Langugage = .notSet
    private var currentLangugae:Langugage {
        set {
            _currentLangugae = newValue
        }
        get {
            if _currentLangugae == .notSet {
                if let deviceLang = NSLocale.preferredLanguages.first {
                    return deviceLang.contains("ar") ? .arabic  : .english
                } else {
                    return .english
                }
            } else {
                return _currentLangugae
            }
        }
    }
    
    var viewControllers:[String:StringsProtocol] = [:]
    var loginTitle:String  {get {return localizedStringWithKey(key: "login")}}
    var chooseCameraTitle:String  {get {return localizedStringWithKey(key: "camera")}}
    var chooseGalleryTitle:String  {get {return localizedStringWithKey(key: "gallery")}}
    var cancelTitle:String  {get {return localizedStringWithKey(key: "cancel")}}
    var chooseTitle:String  {get {return localizedStringWithKey(key: "choose")}}
    var register_title:String  {get {return localizedStringWithKey(key: "register_title")}}
    var facebook_login:String  {get {return localizedStringWithKey(key: "facebook_login")}}
    var forget_password:String  {get {return localizedStringWithKey(key: "forget_password")}}
    var emailTitle:String  {get {return localizedStringWithKey(key: "email")}}
    var passwordTitle:String  {get {return localizedStringWithKey(key: "password")}}
    var confirmPassTitle:String  {get {return localizedStringWithKey(key: "confirm_password")}}
    var nameTitle:String  {get {return localizedStringWithKey(key: "name")}}
    var phoneTitle:String {get {return localizedStringWithKey(key: "phone")}}
    var phoneIsMandatory:String {get {return localizedStringWithKey(key: "phone_mandatory")}}
    var emailNotRightMessage:String  {get {return localizedStringWithKey(key: "email_not_right")}}
    var passwordDidNotMatch:String  {get {return localizedStringWithKey(key: "password_not_match")}}
    var passwordLengthError:String  {get {return localizedStringWithKey(key: "password_length_error")}}
    var passwordIsMandatory:String  {get {return localizedStringWithKey(key: "password_is_mandatory")}}
    var confirmPasswordIsMandatory:String  {get {return localizedStringWithKey(key: "confirmPassword_is_mandatory")}}
    var nameIsMandatory:String  {get {return localizedStringWithKey(key: "name_is_mandatory")}}
    var emailIsMandatory:String  {get {return localizedStringWithKey(key: "email_is_mandatory")}}
    var imageIsMandatory:String  {get {return localizedStringWithKey(key: "image_is_mandatory")}}
    var passwordIsNotMatched:String  {get {return localizedStringWithKey(key: "password_is_not_matched")}}
    var haveAccountLogin: String {get {return localizedStringWithKey(key: "have_an_account_login")}}
    var doesNothaveAccountSignup: String {get {return localizedStringWithKey(key: "new_user_signup")}}
    var noDataAvaialble: String {get {return localizedStringWithKey(key: "whoIsOut_no_data")}}
    var todayTitle: String {get {return localizedStringWithKey(key: "today_title")}}
    var yesterdayTitle: String {get {return localizedStringWithKey(key: "yesterday_title")}}
    var tomorrowTitle: String {get {return localizedStringWithKey(key: "tomorrow_title")}}

    var title: String {get {return localizedStringWithKey(key: "title_name")}}
    var titlePlaceholder: String {get {return localizedStringWithKey(key: "title_placeholder")}}
    var createTitle: String {get {return localizedStringWithKey(key: "create_title")}}
    var createSubTitle: String {get {return localizedStringWithKey(key: "create_sub_title")}}
    var timeTitle: String {get {return localizedStringWithKey(key: "time_title")}}
    var locationTitle: String {get {return localizedStringWithKey(key: "location_title")}}
    var timePlaceholder: String {get {return localizedStringWithKey(key: "time_placeholder")}}
    var locationPlaceholder: String {get {return localizedStringWithKey(key: "location_placeholder")}}
    var submit: String {get {return localizedStringWithKey(key: "submit")}}
    var confirmLocation: String {get {return localizedStringWithKey(key: "confirm_location")}}
    
    var eventTitleIsRequired: String {get {return localizedStringWithKey(key: "eventTitle_is_required")}}
    var eventLocationIsRequired: String {get {return localizedStringWithKey(key: "eventLocation_is_required")}}
    var eventDateIsRequired: String {get {return localizedStringWithKey(key: "eventDate_is_required")}}
    var join: String {get {return localizedStringWithKey(key: "join")}}
    var mayBe: String {get {return localizedStringWithKey(key: "maybe")}}
    var joinedPeople: String {get {return localizedStringWithKey(key: "joined_people")}}
    var byMe: String {get {return localizedStringWithKey(key: "byMe")}}
    var by: String {get {return localizedStringWithKey(key: "by")}}
    
    func registerLangugaeUpdate(name:String?, viewController:StringsProtocol) {
        if let name = name {
            viewControllers[name] = viewController
        }
    }
    
    func unregisterLangugaeUpdate(name:String?) {
        if let name = name {
            viewControllers.removeValue(forKey: name)
        }
    }
    
    func notifyViewController() {
        for (_, viewController) in viewControllers {
            viewController.didLangugageChanged()
        }
    }
    
    func changeLangugage(lang: Langugage) {
        if lang != currentLangugae {
            currentLangugae = lang
            notifyViewController()
        }
    }
    
    func localizedStringWithKey(key:String) -> String {
        let bundle = bundleWtihLanguage(lang: Strings.sharedInstance.currentLangugae.rawValue)
        guard let localizationBundle = bundle else {
            return ""
        }
        
        return NSLocalizedString(key, tableName: nil, bundle: localizationBundle, value: "", comment: "")
    }
    
    private func bundleWtihLanguage(lang:String) -> Bundle! {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle
    }
    
}
