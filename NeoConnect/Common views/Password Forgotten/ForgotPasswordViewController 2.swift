//
//  ForgotPasswordViewController.swift
//  NeoConnect
//
//  Created by EIP on 01/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    struct ForgotPassword: Encodable {
        let email: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let userEmail = emailTextField.text!;

        let forgotPassword = ForgotPassword(email: userEmail)

        if (userEmail.isEmpty) {
            
            // /!\ Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            
            return
        }
        AF.request("http://168.63.65.106/forgotPassword",
                   method: .post,
                   parameters: forgotPassword,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                    case .success(_):
                        
                        // Connexion réussie
                        
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Great!", message: "A mail has been sent to your email", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePassword") as! UpdatePasswordViewController
                                self.show(nextVC, sender: nil)
                            })
                            self.present(alertView, animated: true, completion: nil)
                        }

 
                    case .failure(_):
                        
                        // /!\ Connexion ratée

                        DispatchQueue.main.async {
                        // Message d'alerte
                            let alertView = UIAlertController(title: "Error", message: "Email/Password is/are incorrect, please retry.", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
        }
    }
}
