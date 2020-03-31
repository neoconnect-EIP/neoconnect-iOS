//
//  Offer.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Offer {
    
    var id: Int
    var image: UIImage
    var title: String
    var sex: String
    var description: String
    var subject: String
    
    init(id: Int, image: UIImage, title: String, sex: String, description: String, subject: String) {
        self.id = id
        self.image = image
        self.title = title
        self.sex = sex
        self.description = description
        self.subject = subject
    }
    
}
