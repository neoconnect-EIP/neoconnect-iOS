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

    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userAdressTextField: UITextField!
    @IBOutlet weak var userZipCodeTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var sex = String()
    
    @IBOutlet var radioSexButton : DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Pseudo : " + pseudo)
        print("Email : " + email)
        print("Password : " + password)
        self.radioSexButton.isMultipleSelectionEnabled = false;
        // set selection states programmatically
        // Do any additional setup after loading the view.
    }

    @IBAction func radioBtnTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            sex = "Male"
        }
        else if (sender.tag == 2) {
            sex = "Female"
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let userLastName = userLastNameTextField.text!
        let userFirstName = userFirstNameTextField.text!
        let userAdress = userAdressTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userCity = userCityTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!
        let userSex = sex
        
        // Check for empty fields
        if (userLastName.isEmpty || userFirstName.isEmpty || userAdress.isEmpty || userZipCode.isEmpty || userCity.isEmpty || userPhoneNumber.isEmpty || userSex.isEmpty) {
            
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
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
            Dest.lastName = userLastNameTextField.text!
            Dest.firstName = userFirstNameTextField.text!
            Dest.sex = sex
            Dest.adress = userAdressTextField.text!
            Dest.zipCode = userZipCodeTextField.text!
            Dest.city = userCityTextField.text!
            Dest.phoneNumber = userPhoneNumberTextField.text!
        }
    }
}
