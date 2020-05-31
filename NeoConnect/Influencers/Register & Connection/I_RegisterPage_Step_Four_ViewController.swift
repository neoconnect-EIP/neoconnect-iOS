//
//  I_RegisterPage_Step_Four_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 05/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire


class I_RegisterPage_Step_Four_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var sex = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    var facebook = String()
    var twitter = String()
    var instagram = String()
    var snapchat = String()
    var youtube = String()
    var subject = String()
    var imagePicker: UIImagePickerController!
    var imageConverter = ImageConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "noImage")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
                
            present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = pickedImage
            }
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userPicture = imageConverter.imageToBase64(imageView.image!)
        
        // Erreur : un champ est vide
        if (userPicture == nil) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez ajouter une image de profil", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        else {
            let Register: Parameters = [
                "pseudo": pseudo,
                "password": password,
                "sexe": sex,
                "full_name": name,
                "email": email,
                "phone": phoneNumber,
                "postal": zipCode,
                "city": city,
                "userPicture": userPicture!,
                "theme": subject,
                "facebook": facebook,
                "snapchat": snapchat,
                "twitter": twitter,
                "instagram": instagram,
                "youtube": youtube
            ]
            let URL = "http://168.63.65.106/inf/register"
            
            // Inscription influenceur vers l'API
            AF.request(URL, method: .post, parameters: Register, encoding: URLEncoding.default, interceptor: nil).responseJSON { response in

                        switch response.result {
                        case .success(_):
                            // Inscription réussie

                            print("Successfull")
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Parfait !", message: "Inscription réussie. Vous pouvez maintenant vous connecter", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel) { action in self.dismiss(animated: true, completion: nil)
                                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "I_Register")
                                    
                                    self.show(loginVC!, sender: nil)
                                })
                                self.present(alertView, animated: true, completion: nil)
                            }

                        case .failure(_):
                            // /!\ Inscription ratée
                            print("Error")
                        }
            }
        }
    }
}
