//
//  TextFields.swift
//  NeoConnect
//
//  Created by EIP on 18/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class DefaultTextFields: UITextField {
    
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
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, self.frame.size.height - 1, self.frame.size.width, 1.0)
        bottomLine.backgroundColor = UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0).cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
        
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
        
        setLeftPaddingPoints(15)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func setErrorShape(sender: UITextField) {
        let errorColor : UIColor = UIColor.red
        
        sender.layer.borderColor = errorColor.cgColor
        sender.layer.cornerRadius = 10
        sender.layer.borderWidth = 1.0
    }
    
    private func setNormalShape(sender: UITextField) {
        let noColor : UIColor = UIColor.white
        
        sender.layer.borderColor = noColor.cgColor
        sender.layer.cornerRadius = 10
    }
    
    func handleError(sender: UITextField, field: String) {
        switch field {
            case "Code postal":
                if restriction.isValidZipCode(sender.text!) {
                    setNormalShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            case "Téléphone":
                if restriction.isValidPhoneNumber(sender.text!) {
                    setNormalShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
            default:
                if restriction.isMinThreeChar(sender.text!) {
                    setNormalShape(sender: sender)
                    return
                }
                setErrorShape(sender: sender)
                return
        }
    }
}
