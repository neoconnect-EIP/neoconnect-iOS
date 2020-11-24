//
//  Friend.swift
//  NeoConnect
//
//  Created by EIP on 03/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Conversation {
    
    var id: Int
    var user_id: Int
    var pseudo: String
    var image: UIImage
    
    init(id: Int, user_id: Int, pseudo: String, image: UIImage) {
        self.id = id
        self.user_id = user_id
        self.pseudo = pseudo
        self.image = image
    }
}
