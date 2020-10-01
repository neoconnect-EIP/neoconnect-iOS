//
//  B_RegisterPage_Step_One_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_One_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var userPhotoView: PhotoFieldButton!
    @IBOutlet weak var userPseudoTextField: RegisterFields!
    @IBOutlet weak var userEmailTextField: RegisterFields!
    @IBOutlet weak var userPasswordTextField: RegisterFields!
    @IBOutlet weak var repeatPasswordTextField: RegisterFields!
    var restriction = RestrictionTextField()
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func userPseudoDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "pseudo")
    }
    
    @IBAction func userEmailDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "email")
    }
    
    @IBAction func userPasswordDidEnd(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "password")
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhotoView.setImage(pickedImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let userPseudo = userPseudoTextField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
//        let userImage = userPhotoView.image(for: .normal)
        
        // /!\ Check for empty fields
        if (userPseudo.isEmpty || userEmail.isEmpty || userPassword.isEmpty || repeatPassword.isEmpty) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Veuillez remplir tout les champs", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check for photo view
//        if (userImage == nil) {
//            print("NO IMAGE")
//            DispatchQueue.main.async {
//                self.userPhotoView.setImage(#imageLiteral(resourceName: "Photo Icon"), for: .normal)
//            }
//            return
//        }
        // /!\ Check for email Field
        if (restriction.isValidEmail(userEmail) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Votre adresse email est invalide", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check for password Field
        if (restriction.isValidPassword(userPassword) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le mot de passe nécessite au moins 8 caractères dont : 1 majuscule, 1 minuscule, 1 chiffre et 1 caractère", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check for pseudo Field
        if (restriction.isValidPseudo(userPseudo) == false) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Le pseudo doit contenir au minimum 3 caractères dont 1 majuscule", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // /!\ Check if password match together
        if (userPassword != repeatPassword) {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Les mots de passe ne correspondent pas", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
            return
        }
        // Change view and send prepared data
        else {
            performSegue(withIdentifier: "B_Step_Two", sender: self)
        }
    }

    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "B_Step_Two" {
            let Dest : B_RegisterPage_Step_Two_ViewController = segue.destination as! B_RegisterPage_Step_Two_ViewController

            Dest.pseudo = userPseudoTextField.text!
            Dest.email = userEmailTextField.text!
            Dest.password = userPasswordTextField.text!
            Dest.image = userPhotoView.image(for: .normal)!
        }
    }
}
