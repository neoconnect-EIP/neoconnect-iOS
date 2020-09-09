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

    @IBOutlet weak var userNameTextField: RegisterFields!
    @IBOutlet weak var userZipCodeTextField: RegisterFields!
    @IBOutlet weak var userCityTextField: RegisterFields!
    @IBOutlet weak var userPhoneNumberTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var image = UIImage()
    var pseudo = String()
    var email = String()
    var password = String()
    var sex = String()
        
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
            sex = "Male"
        }
        else if (sender.tag == 2) {
            sex = "Female"
        }
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
    
    @IBAction func nextButton(_ sender: Any) {
        let userName = userNameTextField.text!
        let userCity = userCityTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!
        let userSex = sex
        
        if (userSex.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez choisir votre sexe", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
//        if (userName.isEmpty == false || userCity.isEmpty == false) {
//            if (restriction.isMinSixChar(userName) == false || restriction.isMinThreeChar(userCity) == false ) {
//                DispatchQueue.main.async {
//                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs semblent être inconforme", preferredStyle: .alert)
//                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
//                    self.present(alertView, animated: true, completion: nil)
//                }
//                return
//            }
//        }
//        // Check for zipcode field
//        if (userZipCode.isEmpty == false && restriction.isValidZipCode(userZipCode) == false) {
//            DispatchQueue.main.async {
//                let alertView = UIAlertController(title: "Erreur", message: "Le code postal semble être inconforme", preferredStyle: .alert)
//                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
//                self.present(alertView, animated: true, completion: nil)
//            }
//            return
//        }
//        // Check for phone number field
//        if (userPhoneNumber.isEmpty == false && restriction.isValidPhoneNumber(userPhoneNumber) == false) {
//            DispatchQueue.main.async {
//                let alertView = UIAlertController(title: "Erreur", message: "Le numéro de téléphone semble être inconforme", preferredStyle: .alert)
//                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
//                self.present(alertView, animated: true, completion: nil)
//            }
//            return
//        }
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
            
            Dest.image = image
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
