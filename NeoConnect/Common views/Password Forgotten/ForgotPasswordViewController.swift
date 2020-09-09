//
//  ForgotPasswordViewController.swift
//  NeoConnect
//
//  Created by EIP on 01/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    var restriction = RestrictionTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
    @IBAction func userEmailDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "email")
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let userEmail = emailTextField.text!;

         // /!\ Check for empty fields
        if (userEmail.isEmpty) {
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
        else {
            APIManager.sharedInstance.forgotPassword(userEmail: userEmail, onSuccess: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Parfait !", message: "Un mail vous a été envoyé. Veuillez vérifier votre boite mail", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in
                        self.performSegue(withIdentifier: "UpdatePassword", sender: self)
                    })
                    self.present(alertView, animated: true, completion: nil)
                }
            }, onFailure: {
                DispatchQueue.main.async {
                    // Message d'alerte
                    let alertView = UIAlertController(title: "Un problème est survenu", message: "L'email renseigné semble être incorrect", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdatePassword" {
            let Dest : UpdatePasswordViewController = segue.destination as! UpdatePasswordViewController

            Dest.email = emailTextField.text!
        }
    }
}
