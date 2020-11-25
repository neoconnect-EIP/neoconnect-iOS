//
//  InfConnectionPageViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import StatusAlert

class I_ConnectionPageViewController: UIViewController {

    @IBOutlet weak var userPseudoTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        self.navigationController?.viewControllers = [self]
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
    
    @IBAction func FAQbuttonTapped(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "FAQ", bundle: nil)
        let infButton = storyBoard.instantiateViewController(withIdentifier: "FAQ")
        self.show(infButton, sender: nil)
    }
    
    @IBAction func switchToBrandButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
        let brandButton = storyBoard.instantiateViewController(withIdentifier: "B_Register")
        brandButton.navigationItem.setHidesBackButton(true, animated: true)
        self.show(brandButton, sender: true)
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userPseudo = userPseudoTextField.text!;
        let userPassword = userPasswordTextField.text!;
        
        APIManager.sharedInstance.login(userPseudo: userPseudo, userPassword: userPassword, onSuccess: { userType in
            if userType == "influencer" {
                let statusAlert = StatusAlert()
                statusAlert.image = UIImage(named: "Success icon.png")
                statusAlert.title = "Connexion réussie !"
                statusAlert.message = "Vous vous êtes connecté avec succès !"
                statusAlert.alertShowingDuration = 1
                statusAlert.showInKeyWindow()
                let storyBoard: UIStoryboard = UIStoryboard(name: "I_TabBarController", bundle: nil)
                let home = storyBoard.instantiateViewController(withIdentifier: "I_CustomTabBarController")
                home.navigationItem.setHidesBackButton(true, animated: true)
                self.show(home, sender: nil)
            } else {
                self.showError("Email/Mot de passe incorrects, veuillez réessayer")
            }
        }, onFailure: {
            self.showError("Email/Mot de passe incorrects, veuillez réessayer")

        })
    }
}
