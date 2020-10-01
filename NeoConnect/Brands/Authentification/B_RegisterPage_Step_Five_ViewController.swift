//
//  B_RegisterPage_Step_Five_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_RegisterPage_Step_Five_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    
    var image = UIImage()
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
    var facebook = String()
    var twitter = String()
    var instagram = String()
    var snapchat = String()
    var subject = String()
    var imagePicker: UIImagePickerController!
    var imageConverter = ImageConverter()
   
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userPicture = imageConverter.imageToBase64(imageView.image!)
        
        // Erreur : un champ est vide
        if (userPicture == nil) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Error", message: "Veuillez ajouter une image de profil", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        else {
            APIBrandManager.sharedInstance.register_Shop(pseudo: pseudo, password: password, name: name, email: email, website: website, phoneNumber: phoneNumber, zipCode: zipCode, city: city, userPicture: userPicture!, subject: subject, company: company, profession: profession, facebook: facebook, snapchat: snapchat, twitter: twitter, instagram: instagram, onSuccess: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Parfait !", message: "Inscription réussie. Vous pouvez maintenant vous connecter", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel) { action in self.dismiss(animated: true, completion: nil)
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "I_Register")
                        self.show(loginVC!, sender: nil)
                    })
                    self.present(alertView, animated: true, completion: nil)
                }}, onFailure: {
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Erreur", message: "Une erreur est survenue, veuillez réessayer", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                        self.present(alertView, animated: true, completion: nil)
                    }}
            )
        }
    }
}
