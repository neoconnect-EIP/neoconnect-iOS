//
//  BrRegisterPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Two_ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userZipCodeTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    var restriction = RestrictionTextField()
    
    var pseudo = String()
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        if #available(iOS 12.0, *) {
            userNameTextField.textContentType = .oneTimeCode
            userCityTextField.textContentType = .oneTimeCode
        }
        userNameTextField.setLeftPaddingPoints(7)
        userZipCodeTextField.setLeftPaddingPoints(7)
        userCityTextField.setLeftPaddingPoints(7)
        userPhoneNumberTextField.setLeftPaddingPoints(7)
        super.viewDidLoad()
    }

    @IBAction func phoneNumberTextField(_ sender: UITextField) {
        if restriction.isValidPhoneNumber(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong PhoneNumber")
        }
    }
    
    @IBAction func zipCodeTextField(_ sender: UITextField) {
        if restriction.isValidZipCode(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong ZipCode")
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userCity = userCityTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!

        // Check for empty fields
        if (userName.isEmpty || userZipCode.isEmpty || userCity.isEmpty || userPhoneNumber.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // Check for zipcode field
        if (restriction.isValidZipCode(userZipCode) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le code postal semble être inconforme", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // Check for phone number field
        if (restriction.isValidPhoneNumber(userPhoneNumber) == false) {
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
