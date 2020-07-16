//
//  B_ConnectionPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_ConnectionPageViewController: UIViewController {
    
    @IBOutlet weak var userPseudoTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    struct Login: Encodable {
        let pseudo: String
        let password: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func forgetPasswordButtonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let View = storyBoard.instantiateViewController(withIdentifier: "ForgotPassword")
        self.show(View, sender: nil)
    }
    
    @IBAction func switchToInfButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "I_Register_and_Connection", bundle: nil)
        let infButton = storyBoard.instantiateViewController(withIdentifier: "I_Register")
        infButton.navigationItem.setHidesBackButton(true, animated: true)
        self.show(infButton, sender: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userPseudo = userPseudoTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let login = Login(pseudo: userPseudo, password: userPassword)

            // Login vers l'API
        AF.request("http://168.63.65.106:8080/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                        
                        // Connexion réussie

                        let response = JSON as! NSDictionary
                        let token = response.object(forKey: "token")!
                        let id = response.object(forKey: "userId")!
                        print(token)
                        print(id)
                        UserDefaults.standard.set(token, forKey: "Token") //Bool
                        UserDefaults.standard.set(id, forKey: "id") //Bool
                        let storyBoard: UIStoryboard = UIStoryboard(name: "B_TabBarController", bundle: nil)
                        let Home = storyBoard.instantiateViewController(withIdentifier: "B_CustomTabBarController")
                        Home.navigationItem.setHidesBackButton(true, animated: true)

                        self.show(Home, sender: nil)

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
