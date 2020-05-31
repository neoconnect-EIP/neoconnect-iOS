//
//  B_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Three_ViewController: UIViewController {
    
    @IBOutlet weak var userCompanyTextField: UITextField!
    @IBOutlet weak var userProfessionTextField: UITextField!
    @IBOutlet weak var userWebsiteTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        if #available(iOS 12.0, *) {
            userCompanyTextField.textContentType = .oneTimeCode
            userProfessionTextField.textContentType = .oneTimeCode
            userWebsiteTextField.textContentType = .oneTimeCode
        }
        userCompanyTextField.setLeftPaddingPoints(7)
        userProfessionTextField.setLeftPaddingPoints(7)
        userWebsiteTextField.setLeftPaddingPoints(7)
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userCompany = userCompanyTextField.text!
        let userProfession = userProfessionTextField.text!
        let userWebsite = userWebsiteTextField.text!
        
        if (userCompany.isEmpty || userProfession.isEmpty || userWebsite.isEmpty) {
            // /!\ Display alert message : All Fields aren't fullfilled
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        else {
            performSegue(withIdentifier: "B_Step_Four", sender: self)
        }
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "B_Step_Four") {
            let Dest : B_RegisterPage_Step_Four_ViewController = segue.destination as! B_RegisterPage_Step_Four_ViewController
            
            Dest.pseudo = pseudo
            Dest.email = email
            Dest.password = password
            Dest.name = name
            Dest.zipCode = zipCode
            Dest.city = city
            Dest.phoneNumber = phoneNumber
            Dest.company = userCompanyTextField.text!
            Dest.profession = userProfessionTextField.text!
            Dest.website = userWebsiteTextField.text!

        }
    }
}

