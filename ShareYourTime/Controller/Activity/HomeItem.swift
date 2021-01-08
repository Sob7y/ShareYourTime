//
//  HomeItem.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import UIKit
import Parchment

struct HomeItem: PagingItem, Hashable, Comparable {
  let index: Int
  let title: String
  let headerImage: UIImage
  let images: [UIImage]
  
  var hashValue: Int {
    return index.hashValue &+ title.hashValue
  }
  
  static func ==(lhs: HomeItem, rhs: HomeItem) -> Bool {
    return lhs.index == rhs.index && lhs.title == rhs.title
  }
  
  static func <(lhs: HomeItem, rhs: HomeItem) -> Bool {
    return lhs.index < rhs.index
  }
}
