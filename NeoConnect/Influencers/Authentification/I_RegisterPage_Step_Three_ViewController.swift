//
//  I_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 11/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import DLRadioButton

class I_RegisterPage_Step_Three_ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: RegisterFields!
    @IBOutlet weak var userZipCodeTextField: RegisterFields!
    @IBOutlet weak var userCityTextField: RegisterFields!
    @IBOutlet weak var userPhoneNumberTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var userImage = UIImage()
    var userDescription = String()
    var userPseudo = String()
    var userEmail = String()
    var userPassword = String()
    var userSex = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Fonction bouton sexe influenceur
    @IBAction func radioBtnTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            userSex = "Male"
        }
        else if (sender.tag == 2) {
            userSex = "Female"
        }
    }
    
    @IBAction func isValidField(_ sender: RegisterFields) {
        switch sender.placeholder {
            case "Téléphone":
                sender.handleError(sender: sender, field: "Téléphone")
            case "Code postal":
                sender.handleError(sender: sender, field: "Code postal")
            default:
                sender.handleError(sender: sender, field: "default")
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
        
        if (userSex.isEmpty) {
            showError("Veuillez choisir votre sexe")
        }
        else if (restriction.isMinThreeChar(userName) == false || restriction.isMinThreeChar(userCity) == false ) {
            showError("Un ou plusieurs de vos champs semblent être inconforme")
        }
        // Check for zipcode field
        else if (restriction.isValidZipCode(userZipCode) == false) {
            showError("Le code postal semble être inconforme")
        }
        // Check for phone number field
        else if (userPhoneNumber.count != 0 && restriction.isValidPhoneNumber(userPhoneNumber) == false) {
            showError("Le numéro de téléphone semble être inconforme")
        }
        // Change view and send prepared data
        else {
            performSegue(withIdentifier: "I_Step_Four", sender: self)
        }
        return
    }
    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "I_Step_Four") {
            let Dest : I_RegisterPage_Step_Four_ViewController = segue.destination as! I_RegisterPage_Step_Four_ViewController
            
            Dest.userImage = userImage
            Dest.userDescription = userDescription
            Dest.userPseudo = userPseudo
            Dest.userEmail = userEmail
            Dest.userPassword = userPassword
            Dest.userSex = userSex
            Dest.userName = userNameTextField.text ?? ""
            Dest.userZipCode = userZipCodeTextField.text ?? ""
            Dest.userCity = userCityTextField.text ?? ""
            Dest.userPhoneNumber = userPhoneNumberTextField.text ?? ""
        }
    }
}
