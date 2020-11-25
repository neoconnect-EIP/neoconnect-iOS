//
//  File.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class RegisterFields: UITextField {
    
    var restriction = RestrictionTextField()
    
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
        layer.cornerRadius                  = 10
        if self.tag == 1 {
            backgroundColor                 = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        } else if self.tag == 2 {
            backgroundColor                 = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
        } else {
            backgroundColor                 = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0)
        }
        attributedPlaceholder               = NSAttributedString(string: self.placeholder!,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        setLeftPaddingPoints(15)
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 4, height: 4)
        layer.shadowOpacity = 0.10
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    private func setErrorShape(sender: UITextField) {
        let errorColor : CGColor = UIColor.red.cgColor
        
        sender.layer.borderColor = errorColor
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1.0
    }
    
    private func setNormalShape(sender: UITextField) {
        let noColor : CGColor = UIColor.white.cgColor
        
        sender.layer.borderColor = noColor
        sender.layer.cornerRadius = 10
    }
    
    private func setValidShape(sender: UITextField) {
        let validColor : CGColor = UIColor.green.cgColor

        sender.layer.borderColor = validColor
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1.0
    }
    
    func isValidField(sender: UITextField, field: String) {
        if sender.text?.count == 0 {
            setNormalShape(sender: sender)
            return
        }
        
        switch field {
            case "Pseudo":
                if restriction.isValidPseudo(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            case "Email":
                if restriction.isValidEmail(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            case "Mot de passe":
                if restriction.isValidPassword(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            case "Code postal":
                if restriction.isValidZipCode(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            case "Téléphone":
                if restriction.isValidPhoneNumber(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            default:
                if restriction.isMinThreeChar(sender.text!) {
                    setValidShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
        }
    }
}
