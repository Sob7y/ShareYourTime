//
//  Constant.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/24/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct REGEXS {
        static let PHONE_NUMBER_REGEX = "^(?:(?:\\(?(?:00|\\+)([1-4]\\d\\d|[1-9]\\d?)\\)?)?[\\-\\.\\ \\\\\\/]?)?((?:\\(?\\d{1,}\\)?[\\-\\.\\ \\\\\\/]?){0,})(?:[\\-\\.\\ \\\\\\/]?(?:#|ext\\.?|extension|x)[\\-\\.\\ \\\\\\/]?(\\d+))?$"
        static let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        static let OLE_MENTION_REGEX = "(@\\[).*?(\\d+).*?((?:\\w+)).(\\])"
    }
    
    struct Colors {
        static let ERROR_RED_COLOR = UIColor(red:240/255, green:79/255, blue:35/255, alpha:1)
        static let SUCCESS_GREEN_COLOR = UIColor(red:80/255, green: 227/255, blue: 194/255, alpha: 1)

    }
    
    struct segues {
        static let push_main = "push_main"
        static let push_login = "push_login"
        static let push_signup = "push_sigup"
        static let push_create_event = "push_create_event"
        static let push_location = "push_location"
        static let push_details = "push_details"
        static let push_change_password = "push_change_password"
        static let push_requests_list = "push_requests_list"
        static let push_friends_list = "push_friends_list"
        static let push_update_profile = "push_update_profile"
        static let push_search = "push_search"
        static let push_circles = "push_circles"
        static let push_create_circle = "push_create_circle"
        static let push_view_circle = "push_view_circle"
        static let push_user_profile = "push_user_profile"
        static let push_invite = "push_invite"
        static let push_joinUs = "push_joinUs"
        static let push_create_sp_event = "push_create_sp_event"
        static let push_explore_details = "push_explore_details"

    }
    
    struct keys {
        static let market_id = "marketId"
        static let market_name = "marketName"
        
        static let IS_FOLLOWED_TEAMS = "isFollowedTeams"
        static let USER_DATA = "userData"
        static let USER_TOKEN = "userToken"
        static let DEVICE_TOKEN = "deviceToken"
        static let key_latitude = "key_latitude"
        static let key_longitude = "key_longitude"
        
        static let API_KEY = "yr9WSFYSEmfWXGP69ru39r9guKh3Ncm3"
        static let LANGUAGE = "language"
        static let GOOGLE_MAPS_API_KEY = "AIzaSyA1bvzB8d_uH6TbiStTNt9Cfa1c8Xu_QNo"
        static let LANGUAGE_CHANGED = "langaugeChanged"
        
        static let social_image_url = "userImageUrl"
        static let user_email = "email"
    }
}
