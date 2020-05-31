//
//  InfFinalRegisterPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import DLRadioButton

class I_RegisterPage_Step_Two_ViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userZipCodeTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    var restriction = RestrictionTextField()
    
    var pseudo = String()
    var email = String()
    var password = String()
    var sex = String()
        
    override func viewDidLoad() {
        if #available(iOS 12.0, *) {
            userNameTextField.textContentType = .oneTimeCode
            userCityTextField.textContentType = .oneTimeCode
        }
        super.viewDidLoad()
        userNameTextField.setLeftPaddingPoints(7)
        userZipCodeTextField.setLeftPaddingPoints(7)
        userCityTextField.setLeftPaddingPoints(7)
        userPhoneNumberTextField.setLeftPaddingPoints(7)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Fonction bouton sexe influenceur
    @IBAction func radioBtnTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            sex = "Male"
        }
        else if (sender.tag == 2) {
            sex = "Female"
        }
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
    
    @IBAction func nextButton(_ sender: Any) {
        let userName = userNameTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userCity = userCityTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!
        let userSex = sex
        
        // Check for empty fields
        if (userName.isEmpty || userZipCode.isEmpty || userCity.isEmpty || userPhoneNumber.isEmpty || userSex.isEmpty) {
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
            performSegue(withIdentifier: "I_Step_Three", sender: self)
        }
        return
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "I_Step_Three") {
            let Dest : I_RegisterPage_Step_Three_ViewController = segue.destination as! I_RegisterPage_Step_Three_ViewController
            
            Dest.pseudo = pseudo
            Dest.email = email
            Dest.password = password
            Dest.sex = sex
            Dest.name = userNameTextField.text!
            Dest.zipCode = userZipCodeTextField.text!
            Dest.city = userCityTextField.text!
            Dest.phoneNumber = userPhoneNumberTextField.text!
        }
    }
}
