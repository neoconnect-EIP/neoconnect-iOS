//
//  B_UpdatePasswordViewController.swift
//  NeoConnect
//
//  Created by EIP on 12/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let new_Pwd: Parameters = [
                "email": email,
                "resetPasswordtoken": tempCode,
                "password": userPassword
            ]
            let URL = "http://168.63.65.106:8080/updatePassword"

}
