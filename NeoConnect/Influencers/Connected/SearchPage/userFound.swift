//
//  userFound.swift
//  NeoConnect
//
//  Created by EIP on 27/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class userFound: UIView {

    @IBOutlet weak var userImageView: PhotoFieldImage!
    @IBOutlet weak var userPseudoLabelField: UILabel!
    @IBOutlet weak var subjectLabelField: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var ratingStars: CosmosView!
        
    @IBAction func cancelButtonTapped(_ sender: Any) {
        removeFromSuperview()
    }
}
