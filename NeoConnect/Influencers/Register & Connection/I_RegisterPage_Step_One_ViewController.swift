//
//  I_RegisterPage_Step_One_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/06/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class I_RegisterPage_Step_One_ViewController: UIViewController {

    @IBOutlet weak var userPseudoTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    var restriction = RestrictionTextField()
    
    override func viewDidLoad() {
        if #available(iOS 12.0, *) {
            userPseudoTextField.textContentType = .oneTimeCode
            userEmailTextField.textContentType = .oneTimeCode
            userPasswordTextField.textContentType = .oneTimeCode
            repeatPasswordTextField.textContentType = .oneTimeCode
        }
        userPseudoTextField.setLeftPaddingPoints(7)
        userEmailTextField.setLeftPaddingPoints(7)
        userPasswordTextField.setLeftPaddingPoints(7)
        repeatPasswordTextField.setLeftPaddingPoints(7)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func pseudoTextField(_ sender: UITextField) {
        if restriction.isValidPseudo(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Pseudo")
        }
    }
    
    @IBAction func emailTextField(_ sender: UITextField) {
        if restriction.isValidEmail(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }
    
    @IBAction func passwordTextField(_ sender: UITextField) {
        if restriction.isValidPassword(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Password")
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userPseudo = userPseudoTextField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        // /!\ Check for empty fields
        if (userPseudo.isEmpty || userEmail.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check for email Field
        if (restriction.isValidEmail(userEmail) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Votre adresse email est invalide", preferredStyle: .alert)
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
        // /!\ Check for pseudo Field
        if (restriction.isValidPseudo(userPseudo) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le pseudo doit contenir au minimum 4 caractères dont 1 majuscule", preferredStyle: .alert)
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
        // Change view and send prepared data
        else {
            performSegue(withIdentifier: "I_Step_Two", sender: self)
        }
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "I_Step_Two" {
            let Dest : I_RegisterPage_Step_Two_ViewController = segue.destination as! I_RegisterPage_Step_Two_ViewController

                Dest.pseudo = userPseudoTextField.text!
                Dest.email = userEmailTextField.text!
                Dest.password = userPasswordTextField.text!
        }
    }
}
