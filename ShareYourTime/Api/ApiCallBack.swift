//
//  ApiCallBack.swift
//  OleZone
//
//  Created by Mohammed Khaled (Sob7y) on 8/14/17.
//  Copyright © 2017 Ole.Zone. All rights reserved.
//

import Foundation

protocol ApiCallBack {
    func onSuccess(response:Any)
    func onFailure(error:ApiError)
}

