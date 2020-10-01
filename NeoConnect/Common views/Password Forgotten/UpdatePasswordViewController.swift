//
//  B_UpdatePasswordViewController.swift
//  NeoConnect
//
//  Created by EIP on 12/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

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
        sender.handleError(sender: sender, field: "password")
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        let tempCode = tempCodeTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        if (tempCode.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check for password Field
        if (restriction.isValidPassword(userPassword) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le mot de passe nécessite au moins 8 caractères dont : 1 majuscule, 1 minuscule, 1 chiffre et 1 caractère", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check if password match together
        if (userPassword != repeatPassword) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Les mots de passe ne correspondent pas", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        else {
            APIManager.sharedInstance.updatePassword(email: email, tempCode: tempCode, userPassword: userPassword, onSuccess: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Parfait !", message: "Votre mot de passe a été modifié avec succès!", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel) { action in self.dismiss(animated: true, completion: nil)
                        let controller = self.navigationController?.viewControllers[0] // it is at index 1. index start from 0, 1 .. N
                        self.navigationController?.popToViewController(controller!, animated: true)
                    })
                    self.present(alertView, animated: true, completion: nil)
                }
            }, onFailure: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur!", message: "Le code temporaire renseigné semble être invalide. Veuillez réessayer", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
    }
    
}
