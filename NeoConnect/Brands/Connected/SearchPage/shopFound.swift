//
//  shopFound.swift
//  NeoConnect
//
//  Created by EIP on 29/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class shopFound: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopPseudoLabelField: UILabel!
    
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
        let nib = UINib(nibName: "shopFoundView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        shopImageView.layer.borderWidth = 1
        shopImageView.layer.masksToBounds = false
        shopImageView.layer.borderColor = UIColor.white.cgColor
        shopImageView.layer.cornerRadius = shopImageView.frame.height/2
        shopImageView.clipsToBounds = true
        addSubview(contentView)

        // custom initialization logic
    }
}
