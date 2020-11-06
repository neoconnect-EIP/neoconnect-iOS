//
//  PhotoFieldLoginForm.swift
//  NeoConnect
//
//  Created by EIP on 08/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class PhotoFieldButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        
        imageView?.clipsToBounds = true
        if self.tag == 1 {
            layer.cornerRadius                  = frame.height / 2
            imageView?.layer.cornerRadius       = frame.height / 2
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        } else if self.tag == 2 {
            layer.cornerRadius                  = frame.height/2
            backgroundColor                 = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
        } else if self.tag == 3 {
            layer.cornerRadius = 10
            imageView?.layer.cornerRadius   = 10
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        } else {
            layer.cornerRadius = 4
            imageView?.layer.cornerRadius   = 4
        }
    }
    
    private func setShadow() {
        if self.tag == 1 || self.tag == 2 {
            layer.shadowOffset  = CGSize(width: 2, height: 2)
        } else {
            layer.shadowOffset  = CGSize(width: 4, height: 4)
        }
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
    }
}
