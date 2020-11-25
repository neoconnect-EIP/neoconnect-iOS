//
//  BrRegisterPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Three_ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: RegisterFields!
    @IBOutlet weak var userCityTextField: RegisterFields!
    @IBOutlet weak var userZipCodeTextField: RegisterFields!
    @IBOutlet weak var userPhoneNumberTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var userImage = String()
    var userDescription = String()
    var userPseudo = String()
    var userEmail = String()
    var userPassword = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func isValidField(_ sender: RegisterFields) {
        switch sender.placeholder {
            case "Téléphone":
                sender.isValidField(sender: sender, field: "Téléphone")
            case "Code postal":
                sender.isValidField(sender: sender, field: "Code postal")
            default:
                sender.isValidField(sender: sender, field: "default")
        }
    }

    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let userCity = userCityTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!
        
        if (!restriction.isMinThreeChar(userName) || !restriction.isMinThreeChar(userCity)) {
            showError("Un ou plusieurs de vos champs semblent être inconforme")
        }
        // Check for zipcode field
        else if (!restriction.isValidZipCode(userZipCode)) {
            showError("Le code postal semble être inconforme")
        }
        // Check for phone number field
        else if (!restriction.isValidPhoneNumber(userPhoneNumber)) {
            showError("Le numéro de téléphone semble être inconforme")
        }
        // Change view and send prepared data
        else {
            performSegue(withIdentifier: "B_Step_Four", sender: self)
        }
        return
    }
    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "B_Step_Four") {
            let Dest : B_RegisterPage_Step_Four_ViewController = segue.destination as! B_RegisterPage_Step_Four_ViewController
            
            Dest.userImage = userImage
            Dest.userDescription = userDescription
            Dest.userPseudo = userPseudo
            Dest.userEmail = userEmail
            Dest.userPassword = userPassword
            Dest.userName = userNameTextField.text ?? ""
            Dest.userZipCode = userZipCodeTextField.text ?? ""
            Dest.userCity = userCityTextField.text ?? ""
            Dest.userPhoneNumber = userPhoneNumberTextField.text ?? ""
        }
    }
}
