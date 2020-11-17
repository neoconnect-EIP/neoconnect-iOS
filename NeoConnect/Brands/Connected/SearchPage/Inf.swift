//
//  Inf.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Inf {
    
    var id: Int
    var pseudo: String
    var offersApplied: String
    var subject: String
    var average: Double
    var image: UIImage
    var description: String
    
    init(id: Int, pseudo: String, offersApplied: String, subject: String, average: Double, image: UIImage, description: String) {
        self.id = id
        self.pseudo = pseudo
        self.offersApplied = offersApplied
        self.subject = subject
        self.average = average
        self.image = image
        self.description = description
    }
}
