//
//  shopFound.swift
//  NeoConnect
//
//  Created by EIP on 29/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class shopFound: UIView {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopPseudoLabelField: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    func setImage() {
        shopImageView.layer.borderWidth = 1
        shopImageView.layer.masksToBounds = false
        shopImageView.layer.borderColor = UIColor.white.cgColor
        shopImageView.layer.cornerRadius = shopImageView.frame.height/2
        shopImageView.clipsToBounds = true
    }
}
