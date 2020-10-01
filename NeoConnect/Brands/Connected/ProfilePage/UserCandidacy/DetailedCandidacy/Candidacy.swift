//
//  Candidacy.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Candidacy {
    
    var id: Int
    var idUser: Int
    var idOffer: Int
    var pseudo: String
    var image: UIImage
    var average: Double
    var status: String
    
    init(id: Int, pseudo: String, image: UIImage, idUser: Int, idOffer: Int, average: Double, status: String) {
        self.id = id
        self.pseudo = pseudo
        self.image = image
        self.idUser = idUser
        self.idOffer = idOffer
        self.average = average
        self.status = status
    }
}
