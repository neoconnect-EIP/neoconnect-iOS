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
    
    @IBOutlet weak var userFacebookTextField: UITextField!
    @IBOutlet weak var userTwitterTextField: UITextField!
    @IBOutlet weak var userInstagramTextField: UITextField!
    @IBOutlet weak var userSnapchatTextField: UITextField!
    @IBOutlet weak var userYoutubeTextField: UITextField!
    @IBOutlet weak var userSubjectTextField: UITextField!
    var restriction = RestrictionTextField()
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var sex = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    override func viewDidLoad() {
        if #available(iOS 12.0, *) {
            userFacebookTextField.textContentType = .oneTimeCode
            userTwitterTextField.textContentType = .oneTimeCode
            userInstagramTextField.textContentType = .oneTimeCode
            userSnapchatTextField.textContentType = .oneTimeCode
            userYoutubeTextField.textContentType = .oneTimeCode
            userSubjectTextField.textContentType = .oneTimeCode
        }
        userFacebookTextField.setLeftPaddingPoints(7)
        userTwitterTextField.setLeftPaddingPoints(7)
        userInstagramTextField.setLeftPaddingPoints(7)
        userSnapchatTextField.setLeftPaddingPoints(7)
        userYoutubeTextField.setLeftPaddingPoints(7)
        userSubjectTextField.setLeftPaddingPoints(7)
        super.viewDidLoad()
    }
    
    @IBAction func facebookTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Facebook")
        }
    }
    
    @IBAction func twitterTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Twitter")
        }
    }
    
    @IBAction func instagramTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Instagram")
        }
    }
    
    @IBAction func snapchatTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Snapchat")
        }
    }
    
    @IBAction func youtubeTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Youtube")
        }
    }
    
    @IBAction func subjectTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            sender.layer.borderColor = noColor.cgColor
        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong Subject")
        }
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userFacebook = userFacebookTextField.text!
        let userTwitter = userTwitterTextField.text!
        let userInstagram = userInstagramTextField.text!
        let userSnapchat = userSnapchatTextField.text!
        let userYoutube = userYoutubeTextField.text!
        let userSubject = userSubjectTextField.text!
        
        // Erreur : un champ est vide
        if (userFacebook.isEmpty || userTwitter.isEmpty || userInstagram.isEmpty || userSnapchat.isEmpty || userYoutube.isEmpty || userSubject.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        if (restriction.isMinThreeChar(userFacebook) == false || restriction.isMinThreeChar(userTwitter) == false || restriction.isMinThreeChar(userInstagram) == false || restriction.isMinThreeChar(userSnapchat) == false || restriction.isMinThreeChar(userYoutube) == false || restriction.isMinThreeChar(userSubject) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs possède(nt) moins de trois caractères", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
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
            Dest.facebook = userFacebookTextField.text!
            Dest.twitter = userTwitterTextField.text!
            Dest.instagram = userInstagramTextField.text!
            Dest.snapchat = userSnapchatTextField.text!
            Dest.youtube = userYoutubeTextField.text!
            Dest.subject = userSubjectTextField.text!
        }
    }
}
