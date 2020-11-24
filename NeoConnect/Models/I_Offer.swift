//
//  I_Offer.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class I_Offer {
    
    var id: Int
    var title: String
    var images: [UIImage]
    var sex: String
    var brand: String
    var description: String
    var subject: String
    var status: String
    
    init(id: Int, title: String, images: [UIImage], sex: String, brand: String, description: String, subject: String, status: String) {
        self.id = id
        self.title = title
        self.images = images
        self.sex = sex
        self.brand = brand
        self.description = description
        self.subject = subject
        self.status = status
    }
}
