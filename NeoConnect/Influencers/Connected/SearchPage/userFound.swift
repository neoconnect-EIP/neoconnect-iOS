//
//  userFound.swift
//  NeoConnect
//
//  Created by EIP on 27/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class userFound: UIView {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userPseudoLabelField: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    func setImage() {
        
       
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
    }
}
