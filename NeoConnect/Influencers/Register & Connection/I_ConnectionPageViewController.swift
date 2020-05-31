//
//  InfConnectionPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_ConnectionPageViewController: UIViewController {

    @IBOutlet weak var userPseudoTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    struct Login: Encodable {
        let pseudo: String
        let password: String
    }
    
    override func viewDidLoad() {
        self.navigationController?.viewControllers = [self]
        if #available(iOS 12.0, *) {
            userPasswordTextField.textContentType = .oneTimeCode
        }
        userPseudoTextField.setLeftPaddingPoints(7)
        userPasswordTextField.setLeftPaddingPoints(7)
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
    
    @IBAction func switchToBrandButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
        let brandButton = storyBoard.instantiateViewController(withIdentifier: "B_Register")
        brandButton.navigationItem.setHidesBackButton(true, animated: true)
        self.show(brandButton, sender: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userPseudo = userPseudoTextField.text!;
        let userPassword = userPasswordTextField.text!;
        let login = Login(pseudo: userPseudo, password: userPassword)
        
        //       Conditions de connexion
        
        AF.request("http://168.63.65.106/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                        // Connexion réussie
                        let response = JSON as! NSDictionary
                        let token = response.object(forKey: "token")!
                        let id = response.object(forKey: "userId")!
                        UserDefaults.standard.set(token, forKey: "Token") // Bool
                        UserDefaults.standard.set(id, forKey: "id") // Id
                        UserDefaults.standard.set(userPseudo, forKey: "pseudo")
                        print(token)
                        print(id)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "I_TabBarController", bundle: nil)
                        let Home = storyBoard.instantiateViewController(withIdentifier: "I_CustomTabBarController")
                        Home.navigationItem.setHidesBackButton(true, animated: true)
                        self.show(Home, sender: nil)

                    case .failure(_):
                        
                        // Connexion ratée

                        DispatchQueue.main.async {
                        // Message d'alerte
                            let alertView = UIAlertController(title: "Erreur", message: "Email/Mot de passe incorrects, veuillez réessayer", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
        }
    }
}
