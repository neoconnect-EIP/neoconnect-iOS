//
//  BrRegisterPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Two_ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: RegisterFields!
    @IBOutlet weak var userCityTextField: RegisterFields!
    @IBOutlet weak var userZipCodeTextField: RegisterFields!
    @IBOutlet weak var userPhoneNumberTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var image = UIImage()
    var pseudo = String()
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func userNameDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "name")
    }
    
    @IBAction func userCityDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "city")
    }
    
    @IBAction func userZipCodeDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "zipCode")
    }
    
    @IBAction func userPhoneNumberDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "phoneNumbber")
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let userCity = userCityTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!

        if (userName.isEmpty == false || userCity.isEmpty == false) {
            if (restriction.isMinSixChar(userName) == false || restriction.isMinThreeChar(userCity) == false ) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs semblent être inconforme", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            }
        }
        // Check for zipcode field
        if (userZipCode.isEmpty == false && restriction.isValidZipCode(userZipCode) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le code postal semble être inconforme", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // Check for phone number field
        if (userPhoneNumber.isEmpty == false && restriction.isValidPhoneNumber(userPhoneNumber) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le numéro de téléphone semble être inconforme", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // Change view and send prepared data
        else {
            performSegue(withIdentifier: "B_Step_Three", sender: self)
        }
        return
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "B_Step_Three") {
            let Dest : B_RegisterPage_Step_Three_ViewController = segue.destination as! B_RegisterPage_Step_Three_ViewController
            
            Dest.image = image
            Dest.pseudo = pseudo
            Dest.email = email
            Dest.password = password
            Dest.name = userNameTextField.text!
            Dest.zipCode = userZipCodeTextField.text!
            Dest.city = userCityTextField.text!
            Dest.phoneNumber = userPhoneNumberTextField.text!
        }
    }
}
