//
//  I_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 11/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_RegisterPage_Step_Three_ViewController: UIViewController {

    struct Register: Encodable {
        let pseudo: String
        let email: String
        let password: String
        let name: String
        let zipCode: String
        let phoneNumber: String
        let city: String
        let facebook: String
        let twitter: String
        let instagram: String
        let snapchat: String
        let subject: String
    }
    
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var sex = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Pseudo : " + pseudo)
        print("Email : " + email)
        print("Password : " + password)
        print("Name : " + name)
        print("Sex : " + sex)
        print("Zipcode : " + zipCode)
        print("Phonenumber : " + phoneNumber)
        print("City : " + city)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userFacebook = facebookTextField.text!
        let userTwitter = twitterTextField.text!
        let userInstagram = instagramTextField.text!
        let userSnapchat = snapchatTextField.text!
        let userSubject = subjectTextField.text!
        
        // Erreur : un champ est vide
        if (userFacebook.isEmpty || userTwitter.isEmpty || userInstagram.isEmpty || userSnapchat.isEmpty || userSubject.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else {
            let register = Register(pseudo: pseudo, email: email, password: password, name: name, zipCode: zipCode, phoneNumber: phoneNumber, city: city, facebook: userFacebook, twitter: userTwitter, instagram: userInstagram, snapchat: userSnapchat, subject: userSubject)
            
            print("Successfull")
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Great !", message: "Registration is successful. You can log in now !", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Continue", style: .cancel) { action in self.dismiss(animated: true, completion: nil)})
                self.present(alertView, animated: true, completion: nil)
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "I_Register") as! I_ConnectionPageViewController
                self.present(loginVC, animated: true, completion: nil)
            }
            
            // Inscription influenceur vers l'API
            AF.request("http://168.63.65.106/inf/register",
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
                                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "I_Register") as! I_ConnectionPageViewController
                                self.present(loginVC, animated: true, completion: nil)
                            }

                        case .failure(_):
                            // /!\ Inscription ratée

                            print("Error")

                        }
            }
        }
    }
}
