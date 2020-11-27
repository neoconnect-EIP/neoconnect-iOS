//
//  B_UpdatePasswordViewController.swift
//  NeoConnect
//
//  Created by EIP on 12/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire
import StatusAlert

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var tempCodeTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    var restriction = RestrictionTextField()
    var email = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func userPasswordDidEnd(_ sender: RegisterFields) {
        sender.isValidField(sender: sender, field: "password")
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        let tempCode = tempCodeTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        if (tempCode.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            showError("Veuillez remplir tout les champs")
        } else if (restriction.isValidPassword(userPassword) == false) {
            showError("Le mot de passe nécessite au moins 8 caractères dont : 1 majuscule, 1 minuscule, 1 chiffre et 1 caractère")
        } else if (userPassword != repeatPassword) {
            showError("Les mots de passe ne correspondent pas")
        } else {
            APIManager.sharedInstance.updatePassword(email: email, tempCode: tempCode, userPassword: userPassword, onSuccess: { message in
                print(message)
                if message == "Your password has been updated" {
                    let statusAlert = StatusAlert()
                    statusAlert.image = UIImage(named: "Success icon.png")
                    statusAlert.title = "Connexion réussie!"
                    statusAlert.message = "Vous vous êtes connecté avec succès"
                    statusAlert.alertShowingDuration = 1
                    statusAlert.showInKeyWindow()
                    self.navigationController?.popToRootViewController(animated: true)
                } else if message == "Bad request, your reset token doesn't exist" {
                    self.showError("Une erreur est survenue")
                }
            }, onFailure: {
                self.showError("Le code temporaire renseigné semble être invalide. Veuillez réessayer")
            })
        }
    }
    
}
