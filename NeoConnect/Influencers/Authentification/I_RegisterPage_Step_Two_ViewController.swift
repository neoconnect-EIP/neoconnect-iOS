//
//  I_RegisterPage_Step_Two_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 01/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_RegisterPage_Step_Two_ViewController: UIViewController {
    
    @IBOutlet weak var userPseudoTextField: RegisterFields!
    @IBOutlet weak var userEmailTextField: RegisterFields!
    @IBOutlet weak var userPasswordTextField: RegisterFields!
    @IBOutlet weak var repeatPasswordTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var userDescription = String()
    var userImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func isValidField(_ sender: RegisterFields) {
        switch sender.placeholder {
            case "Pseudo":
                sender.handleError(sender: sender, field: "Pseudo")
            case "Email":
                sender.handleError(sender: sender, field: "Email")
            case "Mot de passe":
                sender.handleError(sender: sender, field: "Mot de passe")
            case "Répétez le mot de passe":
                sender.handleError(sender: sender, field: "Mot de passe")
            default:
                sender.handleError(sender: sender, field: "default")
        }
        sender.handleError(sender: sender, field: "pseudo")
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
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
        else if (restriction.isValidEmail(userEmail) == false) {
            showError("Votre adresse email est invalide")
        }
        // /!\ Check for password Field
        else if (restriction.isValidPassword(userPassword) == false) {
            showError("Le mot de passe nécessite au moins 8 caractères dont : 1 majuscule, 1 minuscule, 1 chiffre et 1 caractère")
        }
        // /!\ Check for pseudo Field
        else if (restriction.isValidPseudo(userPseudo) == false) {
            showError("Le pseudo doit contenir au minimum 3 caractères dont 1 majuscule")
        }
        // /!\ Check if password match together
        else if (userPassword != repeatPassword) {
            showError("Les mots de passe ne correspondent pas")
        } else {
            performSegue(withIdentifier: "I_Step_Three", sender: self)
        }
        return
        // Change view and send prepared data
    }
    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "I_Step_Three" {
            let Dest : I_RegisterPage_Step_Three_ViewController = segue.destination as! I_RegisterPage_Step_Three_ViewController
            
            Dest.userImage = userImage
            Dest.userDescription = userDescription
            Dest.userPseudo = userPseudoTextField.text ?? ""
            Dest.userEmail = userEmailTextField.text ?? ""
            Dest.userPassword = userPasswordTextField.text ?? ""
        }
    }
}
