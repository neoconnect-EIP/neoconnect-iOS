//
//  B_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_RegisterPage_Step_Three_ViewController: UIViewController {
    
    struct Register: Encodable {
        let pseudo: String
        let email: String
        let password: String
        let lastName: String
        let firstName: String
        let adress: String
        let zipCode: String
        let phoneNumber: String
        let city: String
        let company: String
        let profession: String
        let subject: String
    }
    
    @IBOutlet weak var userCompanyTextField: UITextField!
    @IBOutlet weak var userProfessionTextField: UITextField!
    @IBOutlet weak var userSubjectTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var lastName = String()
    var firstName = String()
    var adress = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Pseudo : " + pseudo)
        print("Email : " + email)
        print("Password : " + password)
        print("Lastname : " + lastName)
        print("Firstname : " + firstName)
        print("Adress : " + adress)
        print("Zipcode : " + zipCode)
        print("Phonenumber : " + phoneNumber)
        print("City : " + city)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userCompany = userCompanyTextField.text!
        let userProfession = userProfessionTextField.text!
        let userSubject = userSubjectTextField.text!
        
        if (userCompany.isEmpty || userProfession.isEmpty || userSubject.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else {
                let register = Register(pseudo: pseudo, email: email, password: password, lastName: lastName, firstName: firstName, adress: adress, zipCode: zipCode, phoneNumber: phoneNumber, city: city, company: userCompany, profession: userProfession, subject: userSubject)
            
            AF.request("http://168.63.65.106/shop/register",
                       method: .post,
                       parameters: register,
                       encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).response { response in
                        switch response.result {
                        case .success(_):
                            // Inscription réussie

                            print("Successfull")
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Great !", message: "Registration is successful. You can log in now !", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Continue", style: .cancel) { action in self.dismiss(animated: true, completion: nil)})
                                self.present(alertView, animated: true, completion: nil)
                                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "B_Register") as! B_ConnectionPageViewController
                                self.present(loginVC, animated: true, completion: nil)
                            }

                        case .failure(_):
                            // Inscription ratée

                            print("Error")
                            
                        }
            }
            return
        }
    }
}
