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

    @IBOutlet weak var BlankForm: UIImageView!
    @IBOutlet weak var tempCodeTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    var restriction = RestrictionTextField()
    var email = String()
    
    override func viewDidLoad() {
        BlankForm.layer.cornerRadius = 15
        if #available(iOS 12.0, *) {
            tempCodeTextField.textContentType = .oneTimeCode
            userPasswordTextField.textContentType = .oneTimeCode
            repeatPasswordTextField.textContentType = .oneTimeCode
        }
        tempCodeTextField.setLeftPaddingPoints(7)
        userPasswordTextField.setLeftPaddingPoints(7)
        repeatPasswordTextField.setLeftPaddingPoints(7)
        super.viewDidLoad()
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
            let URL = "http://168.63.65.106/updatePassword"

            AF.request(URL, method: .put, parameters: new_Pwd, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseString { response in
                switch response.result {
                case .success(_):
                    print("\(String(describing: response.result))")
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Parfait !", message: "Votre mot de passe a été modifié avec succès!", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel) { action in self.dismiss(animated: true, completion: nil)
                            let controller = self.navigationController?.viewControllers[0] // it is at index 1. index start from 0, 1 .. N
                            self.navigationController?.popToViewController(controller!, animated: true)
                        })
                        self.present(alertView, animated: true, completion: nil)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Erreur!", message: "Le code temporaire renseigné semble être invalide. Veuillez réessayer", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                        self.present(alertView, animated: true, completion: nil)
                    }
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
}
