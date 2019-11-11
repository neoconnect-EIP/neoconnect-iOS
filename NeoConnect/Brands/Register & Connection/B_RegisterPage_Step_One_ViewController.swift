//
//  B_RegisterPage_Step_One_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_One_ViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userID = userIDTextField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        // Check for empty fields
        if (userID.isEmpty || userEmail.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            
            return
        }
        
        if (userPassword != repeatPassword) {
            // Display alert message
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            //            warningAlert(title: "Error", message: "Passwords do not match")
            return
        }
        else {
            performSegue(withIdentifier: "B_Step_Two", sender: self)
        }
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "B_Step_Two" {
            let Dest : B_RegisterPage_Step_Two_ViewController = segue.destination as! B_RegisterPage_Step_Two_ViewController

                Dest.pseudo = userIDTextField.text!
                Dest.email = userEmailTextField.text!
                Dest.password = userPasswordTextField.text!
        }
    }
}
