//
//  BlankForm.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class BlankForm: UIImageView {
    
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
        
        layer.borderWidth   = 3
        layer.borderColor   = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0).cgColor
        backgroundColor     = UIColor.white
        layer.cornerRadius  = 10
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}
