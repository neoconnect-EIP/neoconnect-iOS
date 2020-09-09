//
//  Navbar.swift
//  NeoConnect
//
//  Created by EIP on 06/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

final class Navbar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupBackButton() {
        setShadow()
        
        
        backgroundColor      = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0)
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
