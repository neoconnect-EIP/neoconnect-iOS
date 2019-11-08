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
    @IBOutlet weak var userAddressTextField: UITextField!
    @IBOutlet weak var userPostcodeTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    @IBOutlet weak var EmailTest: UITextField!
    
    var Pseudo = String()
    var Email = String()
    var Password = String()
    var Sex = String()
    
    @IBOutlet var radioSexButton : DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.radioSexButton.isMultipleSelectionEnabled = false;
        EmailTest.text = Email
        print(Password)
        print(Pseudo)
        // set selection states programmatically
        // Do any additional setup after loading the view.
    }
    
    @IBAction func radioBtnTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            Sex = "Male"
        }
        else if (sender.tag == 2) {
            Sex = "Female"
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let userLastName = userLastNameTextField.text
        let userFirstName = userFirstNameTextField.text
        let userAddress = userAddressTextField.text
        let userPostcode = userPostcodeTextField.text
        let userCity = userCityTextField.text
        let userPhoneNumber = userPhoneNumberTextField.text
        
        if (userLastName!.isEmpty || userFirstName!.isEmpty || userAddress!.isEmpty || userPostcode!.isEmpty || userCity!.isEmpty || userPhoneNumber!.isEmpty) {
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            
            return
        }
        
        // Store Data
        UserDefaults.standard.set(Pseudo, forKey: "userID")
        UserDefaults.standard.set(Email, forKey: "userEmail")
        UserDefaults.standard.set(Password, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        // Display alert message with confirmation
        
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Great !", message: "Registration is successful. Let's log in now !", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Continue", style: .cancel) { action in self.dismiss(animated: true, completion: nil)})
            self.present(alertView, animated: true, completion: nil)
        }
        return
    }
}
