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

    var pseudo = String()
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userCity = userCityTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!

        // Check for empty fields
        if (userName.isEmpty || userZipCode.isEmpty || userCity.isEmpty || userPhoneNumber.isEmpty) {
            
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
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
