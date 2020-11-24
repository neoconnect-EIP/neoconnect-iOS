//
//  RegisterTextView.swift
//  NeoConnect
//
//  Created by EIP on 01/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class RegisterTextView: UITextView {
    
    var restriction = RestrictionTextField()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: CGRect.zero, textContainer: nil)
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
        layer.cornerRadius                  = 10
        if self.tag == 1 {
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        } else if self.tag == 2 {
            backgroundColor                 = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
        }
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.10
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    private func setErrorShape(sender: UITextView) {
        let errorColor : UIColor = UIColor.red
        
        sender.layer.borderColor = errorColor.cgColor
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1.0
    }
    
    private func setNormalShape(sender: UITextView) {
        let noColor : UIColor = UIColor.white
        
        sender.layer.borderColor = noColor.cgColor
        sender.layer.cornerRadius = 10
    }
    
    func handleError(sender: UITextView, field: String) {
        if restriction.isMinThreeChar(sender.text!) {
            setNormalShape(sender: sender)
        } else {
            setErrorShape(sender: sender)
        }
    }
}
