//
//  I_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 11/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_RegisterPage_Step_Three_ViewController: UIViewController {
    
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var youtubeTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var sex = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userFacebook = facebookTextField.text!
        let userTwitter = twitterTextField.text!
        let userInstagram = instagramTextField.text!
        let userSnapchat = snapchatTextField.text!
        let userYoutube = youtubeTextField.text!
        let userSubject = subjectTextField.text!
        
        // Erreur : un champ est vide
        if (userFacebook.isEmpty || userTwitter.isEmpty || userInstagram.isEmpty || userSnapchat.isEmpty || userYoutube.isEmpty || userSubject.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else {
            performSegue(withIdentifier: "I_Step_Four", sender: self)
        }
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "I_Step_Four") {
            let Dest : I_RegisterPage_Step_Four_ViewController = segue.destination as! I_RegisterPage_Step_Four_ViewController
            
            Dest.pseudo = pseudo
            Dest.email = email
            Dest.password = password
            Dest.sex = sex
            Dest.name = name
            Dest.zipCode = zipCode
            Dest.city = city
            Dest.phoneNumber = phoneNumber
            Dest.facebook = facebookTextField.text!
            Dest.twitter = twitterTextField.text!
            Dest.instagram = instagramTextField.text!
            Dest.snapchat = snapchatTextField.text!
            Dest.youtube = youtubeTextField.text!
            Dest.subject = subjectTextField.text!
        }
    }
}
