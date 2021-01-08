//
//  ApiUrls.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 8/14/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import Foundation

struct ApiUrls {
    
    static let base_url = "http://35.193.130.158/"
    
    static let login = "api/user/login"
    static let socialLogin = "api/user/socialLogin"
    static let register = "api/user/register"
    static let outList = "api/auth/event/out-list"
    static let myList = "api/auth/event/my-list"
    static let createEvent = "api/auth/event/create"
    static let eventDetails = "api/auth/event/details"
    static let joinEvent = "api/auth/event/join"
    static let maybeEvent = "api/auth/event/maybe"
    static let getProfile = "api/auth/user/profile"
    static let changePassword = "api/auth/user/changePassword"
    static let editProfile = "api/auth/user/updateProfile"
    static let searchUsersUrl = "api/auth/user/search"
    static let addUsersUrl = "api/auth/friend/add-by-email"
    static let removeUserUrl = "api/auth/friend/remove"
    static let requestsListUrl = "api/auth/friend/requests"
    static let friendsListUrl = "api/auth/friend/list"
    static let approveRequestUrl = "api/auth/friend/approve"
    static let rejectRequestUrl = "api/auth/friend/reject"
    static let gettCirclesUrl = "api/auth/group/list-with-connection"
    static let createCircle = "api/auth/group/create"
    static let updateCircle = "api/auth/group/update"
    static let viewCircle = "api/auth/group/details"
    static let removeGroup = "api/auth/group/remove"
    static let notificationsList = "api/auth/notification/list"
    static let getUsertsEventsUrl = "api/auth/event/my-event"
    static let inviteUrl = "api/auth/event/invite"
    static let becomeServicePrivider = "api/auth/service-provider/register"
    static let joinUsCategoryList = "api/auth/service-provider/category/list"
    static let joinUsApi = "api/auth/service-provider/register"
    static let createSPEventApi = "api/auth/service-provider/event/create"
    static let getExploreApi = "api/auth/service-provider/home"
    static let getExploreDetailsApi = "api/auth/service-provider/event/details"
    static let bookEventApi = "api/auth/service-provider/event/book"

    static let registerDevice = "api/auth/user/registerDeviceToken"
        
    static let TERMS_OF_USE = "https://stage.yamohub.com/term-of-service?locale=en"
    static let ABOUT = "https://stage.yamohub.com/about?locale="
    static let HELP = "https://stage.yamohub.com/help?locale="
    static let ITUNES_LINK = "http://itunes.apple.com/us/app/Yamo/id1390390373"
    
    static let base_image_url = "data:image/jpeg;base64,"
    
}
