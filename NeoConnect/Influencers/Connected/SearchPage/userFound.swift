//
//  userFound.swift
//  NeoConnect
//
//  Created by EIP on 27/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class userFound: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userPseudoLabelField: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "userFoundView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        addSubview(contentView)

        // custom initialization logic
    }
}
