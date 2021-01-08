//
//  CreateEventImageModel.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import Foundation
import UIKit

class CreateEventImageModel: NSObject {
    var selectedImage: UIImage?
    var imageData:String?
    var index: Int?
    
    init(selectedImage: UIImage?, isSelected: Bool, imageData: String?, index: Int) {
        self.selectedImage = selectedImage
        self.imageData = imageData
        self.index = index
    }
}
