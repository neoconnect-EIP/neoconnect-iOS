//
//  Button.swift
//  NeoConnect
//
//  Created by EIP on 04/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

final class DefaultButton: UIButton {

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
        
        if self.tag == 1 {
            backgroundColor      = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0)
        } else if self.tag == 2 {
            backgroundColor      = UIColor.white
        } else if self.tag == 3 {
            backgroundColor      = UIColor.red
        } else if self.tag == 4 {
            backgroundColor      = UIColor.green
        }
        layer.cornerRadius   = 10
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 2, height: 2)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.30
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}
