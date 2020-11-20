//
//  I_Brand.swift
//  NeoConnect
//
//  Created by EIP on 15/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class I_Brand {
    
    var id: Int
    var pseudo: String
    var nbOffers: String
    var nbFollowers: String
    var subject: String
    var rate: Double
    var description: String
    var followed: Bool
    var image: UIImage
    
    init(id: Int, pseudo: String, nbOffers: String, nbFollowers: String, image: UIImage, subject: String, rate: Double, description: String, followed: Bool) {
        self.id = id
        self.pseudo = pseudo
        self.nbOffers = nbOffers
        self.nbFollowers = nbFollowers
        self.subject = subject
        self.rate = rate
        self.description = description
        self.followed = followed
        self.image = image
    }
}
