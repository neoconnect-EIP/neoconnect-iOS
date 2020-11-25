//
//  B_RegisterPage_Step_Two_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_One_ViewController: UIViewController {
    
    @IBOutlet weak var userPseudoTextField: RegisterFields!
    @IBOutlet weak var userEmailTextField: RegisterFields!
    @IBOutlet weak var userPasswordTextField: RegisterFields!
    @IBOutlet weak var repeatPasswordTextField: RegisterFields!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    var restriction = RestrictionTextField()
    
    override func viewDidLoad() {
        self.loader.isHidden = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func isValidField(_ sender: RegisterFields) {
        switch sender.placeholder {
            case "Pseudo":
                sender.isValidField(sender: sender, field: "Pseudo")
            case "Email":
                sender.isValidField(sender: sender, field: "Email")
            case "Mot de passe":
                sender.isValidField(sender: sender, field: "Mot de passe")
            case "Répétez le mot de passe":
                sender.isValidField(sender: sender, field: "Mot de passe")
            default:
                sender.isValidField(sender: sender, field: "default")
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func checkFieldsFromAPI(_ userPseudo: String, _ userEmail: String) {
        loader.isHidden = false
        loader.startAnimating()
        APIManager.sharedInstance.checkUserField(fieldToCheck: "pseudo", userField: userPseudo, onSuccess: { response in
            if response {
                self.showError("Le pseudo renseigné a déjà été utilisé")
            } else {
                APIManager.sharedInstance.checkUserField(fieldToCheck: "email", userField: userEmail, onSuccess: { response in
                    if response {
                        self.showError("L'email renseigné a déjà été utilisé")
                    } else {
                        self.performSegue(withIdentifier: "B_Step_Two", sender: self)
                    }
                })
            }
            self.loader.isHidden = true
            self.loader.stopAnimating()
        })
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userPseudo = userPseudoTextField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        // /!\ Check for empty fields
        if (userPseudo.isEmpty || userEmail.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            showError("Veuillez remplir tout les champs")
        }
        // /!\ Check for email Field
        else if (!restriction.isValidEmail(userEmail)) {
            showError("Votre adresse email est invalide")
        }
        // /!\ Check for password Field
        else if (!restriction.isValidPassword(userPassword)) {
            showError("Le mot de passe nécessite au moins 8 caractères dont : 1 majuscule, 1 minuscule et 1 chiffre")
        }
        // /!\ Check for pseudo Field
        else if (!restriction.isValidPseudo(userPseudo)) {
            showError("Le pseudo doit contenir au minimum 3 caractères dont 1 majuscule")
        }
        // /!\ Check if password match together
        else if (userPassword != repeatPassword) {
            showError("Les mots de passe ne correspondent pas")
        } else {
            checkFieldsFromAPI(userPseudo, userEmail)
        }
    }
    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "B_Step_Two" {
            let Dest : B_RegisterPage_Step_Two_ViewController = segue.destination as! B_RegisterPage_Step_Two_ViewController
            
            Dest.userPseudo = userPseudoTextField.text ?? ""
            Dest.userEmail = userEmailTextField.text ?? ""
            Dest.userPassword = userPasswordTextField.text ?? ""
        }
    }
}
