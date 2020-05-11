//
//  B_RegisterPage_Step_Four_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Four_ViewController: UIViewController {

    @IBOutlet weak var userFacebookTextField: UITextField!
    @IBOutlet weak var userTwitterTextField: UITextField!
    @IBOutlet weak var userInstagramTextField: UITextField!
    @IBOutlet weak var userSnapchatTextField: UITextField!
    @IBOutlet weak var userSubjectTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    var company = String()
    var profession = String()
    var website = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userFacebook = userFacebookTextField.text!
        let userTwitter = userTwitterTextField.text!
        let userInstagram = userInstagramTextField.text!
        let userSnapchat = userSnapchatTextField.text!
        let userSubject = userSubjectTextField.text!
        
        if (userFacebook.isEmpty || userTwitter.isEmpty || userInstagram.isEmpty || userSnapchat.isEmpty || userSubject.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else {
            performSegue(withIdentifier: "B_Step_Five", sender: self)
        }
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "B_Step_Five") {
            let Dest : B_RegisterPage_Step_Five_ViewController = segue.destination as! B_RegisterPage_Step_Five_ViewController
            
            Dest.pseudo = pseudo
            Dest.email = email
            Dest.password = password
            Dest.name = name
            Dest.zipCode = zipCode
            Dest.city = city
            Dest.phoneNumber = phoneNumber
            Dest.company = company
            Dest.profession = profession
            Dest.website = website
            Dest.facebook = userFacebookTextField.text!
            Dest.twitter = userTwitterTextField.text!
            Dest.instagram = userInstagramTextField.text!
            Dest.snapchat = userSnapchatTextField.text!
            Dest.subject = userSubjectTextField.text!
        }
    }
}
