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
        } else if self.tag == 2 {
            layer.cornerRadius = 10
            imageView?.layer.cornerRadius   = 10
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
