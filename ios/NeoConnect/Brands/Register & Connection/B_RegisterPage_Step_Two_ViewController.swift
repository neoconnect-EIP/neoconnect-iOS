//
//  BrRegisterPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_RegisterPage_Step_Two_ViewController: UIViewController {
    
    struct Login: Encodable {
        let pseudo: String
        let email: String
        let password: String
        let lastName: String
        let firstName: String
        let adress: String
        let zipCode: String
        let phoneNumber: String
        let city: String
    }
    
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userAddressTextField: UITextField!
    @IBOutlet weak var userZipCodeTextField: UITextField!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    
    var Pseudo = String()
    var Email = String()
    var Password = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerButton(_ sender: Any) {
        let userLastName = userLastNameTextField.text!
        let userFirstName = userFirstNameTextField.text!
        let userAddress = userAddressTextField.text!
        let userZipCode = userZipCodeTextField.text!
        let userCity = userCityTextField.text!
        let userPhoneNumber = userPhoneNumberTextField.text!

        // Check for empty fields
        if (userLastName.isEmpty || userFirstName.isEmpty || userAddress.isEmpty || userZipCode.isEmpty || userCity.isEmpty || userPhoneNumber.isEmpty) {
            
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            
            return
        }
        
        let login = Login(pseudo: Pseudo, email: Email, password: Password, lastName: userLastName, firstName: userFirstName, adress: userAddress, zipCode: userZipCode, phoneNumber: userPhoneNumber, city: userCity)

        // Store Data
        AF.request("http://168.63.65.106/shop/register", method: .post, parameters: login, encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
        UserDefaults.standard.set(Pseudo, forKey: "userID")
        UserDefaults.standard.set(Email, forKey: "userEmail")
        UserDefaults.standard.set(Password, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        // Display alert message with confirmation

            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Great !", message: "Registration is successful. You can log in now !", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Continue", style: .cancel) { action in self.dismiss(animated: true, completion: nil)})
                self.present(alertView, animated: true, completion: nil)
                let RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "B_Register") as! B_ConnectionPageViewController
                self.present(RegisterViewController, animated: true, completion: nil)
            }
        return
        }
}
