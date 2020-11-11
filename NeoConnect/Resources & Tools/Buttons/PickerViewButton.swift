//
//  PickerViewButton.swift
//  NeoConnect
//
//  Created by EIP on 17/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class PickerViewButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupField()
    }
    
    func setupField() {
        
        if self.tag == 1 {
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
            setShadow()
        } else if self.tag == 3 {
            let bottomLine = CALayer()
            bottomLine.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width - 1, 1.0)
            bottomLine.backgroundColor = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0).cgColor
            layer.addSublayer(bottomLine)
        } else {
            backgroundColor                 = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
            setShadow()

        }
        layer.cornerRadius   = 10
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
