//
//  RestrictionTextField.swift
//  NeoConnect
//
//  Created by EIP on 24/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation

class RestrictionTextField {
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{4,12}$"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)

        return passwordPred.evaluate(with: password)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPseudo(_ pseudo: String) -> Bool {
        print(pseudo)
        let pseudoRegEx = "[A-Z][a-zA-Z]{3,12}"

        let pseudoPred = NSPredicate(format:"SELF MATCHES %@", pseudoRegEx)
        return pseudoPred.evaluate(with: pseudo)
    }
    
    func isValidZipCode(_ zipcode: String) -> Bool {
        if (zipcode.count != 5) {
            if (zipcode.count == 0) {
                return true
            }
            return false
        }
        return true
    }
    
    func isValidPhoneNumber(_ phonenumber: String) -> Bool {
        let phoneRegEx = "^((\\+)33|0)[1-9](\\d{2}){4}$"

        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phonenumber)
    }
    
    func isProfileCorrect(_ email: String, _ pseudo: String, _ zipcode: String, _ phoneNumber: String) -> Bool {
        if (self.isValidPseudo(email) || self.isValidZipCode(zipcode) || self.isValidPhoneNumber(phoneNumber)) {
            return true
        }
        return false
    }
    
    func isMinThreeChar(_ param: String) -> Bool {
        if 1 ... 2 ~= param.count {
            return false
        }
        return true
    }
    
    func isMinSixChar(_ param: String) -> Bool {
        if (param.count <= 5) {
            return false
        }
        return true
    }
}
