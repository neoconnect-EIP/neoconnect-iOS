//
//  B_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Three_ViewController: UIViewController {
    
    @IBOutlet weak var userCompanyTextField: RegisterFields!
    @IBOutlet weak var userProfessionTextField: RegisterFields!
    @IBOutlet weak var userWebsiteTextField: RegisterFields!
    var restriction = RestrictionTextField()
    
    var image = UIImage()
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func userCompanyDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "company")
    }
    
    @IBAction func userFunctionDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "function")
    }
    
    @IBAction func userWebsiteDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "website")
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userCompany = userCompanyTextField.text!
        let userProfession = userProfessionTextField.text!
        let userWebsite = userWebsiteTextField.text!
        
        if (!userCompany.isEmpty || !userProfession.isEmpty || !userWebsite.isEmpty) {
            if (!restriction.isMinThreeChar(userCompany) || !restriction.isMinThreeChar(userProfession) || !restriction.isMinThreeChar(userWebsite)) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs semblent être inconforme", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            } else {
                performSegue(withIdentifier: "B_Step_Four", sender: self)
            }
        }
        else {
            performSegue(withIdentifier: "B_Step_Four", sender: self)
        }
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "B_Step_Four") {
            let Dest : B_RegisterPage_Step_Four_ViewController = segue.destination as! B_RegisterPage_Step_Four_ViewController
            
            Dest.image = image
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

