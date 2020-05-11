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
                changeImageButton.setImage(nil, for: .normal)
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
                let alertView = UIAlertController(title: "Error", message: "Please, add a profile picture", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        }
        else {
            let Register: Parameters = [
                "pseudo": pseudo,
                "password": password,
                "full_name": name,
                "email": email,
                "website": website,
                "phone": phoneNumber,
                "postal": zipCode,
                "city": city,
                "userPicture": userPicture!,
                "theme": subject,
                "society": company,
                "function": profession,
                "facebook": facebook,
                "snapchat": snapchat,
                "twitter": twitter,
                "instagram": instagram,
            ]
            let URL = "http://168.63.65.106/shop/register"
            
            // Inscription influenceur vers l'API
            AF.request(URL, method: .post, parameters: Register, encoding: URLEncoding.default, interceptor: nil).responseJSON { response in

                        switch response.result {
                        case .success(_):
                            // Inscription réussie

                            print("Successfull")
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Great !", message: "Registration is successful. You can log in now !", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Continue", style: .cancel) { action in self.dismiss(animated: true, completion: nil)
                                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "B_Register")
                                    
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
