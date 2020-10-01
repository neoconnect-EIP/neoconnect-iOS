//
//  LoginShopFields.swift
//  NeoConnect
//
//  Created by EIP on 06/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class LoginFields: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupField()
    }
    
    func setupField() {
        setShadow()
        
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
        if self.tag == 1 {
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        } else {
            backgroundColor                 = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
        }
        layer.cornerRadius   = 20
        attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}
