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
        // Do any additional setup after loading the view.
    }
    
    //         Bouton de connexion entrée
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userPseudo = userPseudoTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let login = Login(pseudo: userPseudo, password: userPassword)

            // Login vers l'API
        
        AF.request("http://168.63.65.106/shop/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).response { response in
                    switch response.result {
                    case .success(_):
                        
                        // Connexion réussie
                        
                        print("Validation successfull")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Navigation", bundle: nil)
                        let Home = storyBoard.instantiateViewController(withIdentifier: "B_TabBarController")
                        self.present(Home, animated: true, completion: nil)

                    case .failure(_):
                        
                        // Connexion ratée

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
