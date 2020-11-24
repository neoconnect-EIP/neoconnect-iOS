//
//  Offer.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class B_Offer {
    
    var id: Int
    var images: [UIImage]
    var title: String
    var sex: String
    var description: String
    var subject: String
    var apply: Array<NSDictionary>
    
    init(id: Int, images: [UIImage], title: String, sex: String, description: String, subject: String, apply: Array<NSDictionary>) {
        self.id = id
        self.images = images
        self.title = title
        self.sex = sex
        self.description = description
        self.subject = subject
        self.apply = apply
    }
}
