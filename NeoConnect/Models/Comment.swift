//
//  Comment.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 20/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    var pseudo: String
    var comment: String
    var image: UIImage
    var note: Double

    init(pseudo: String, comment: String, image: UIImage, note: Double) {
        self.pseudo = pseudo
        self.comment = comment
        self.image = image
        self.note = note
    }
}
