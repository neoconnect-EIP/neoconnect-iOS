//
//  B_RegisterPage_Step_One_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/07/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Two_ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userPhotoView: PhotoFieldButton!
    @IBOutlet weak var userDescriptionTextView: RegisterTextView!
    
    var userPseudo = String()
    var userEmail = String()
    var userPassword = String()

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
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let userDescription = userDescriptionTextView.text else { return }
        
        if 1 ... 4 ~= userDescription.count || userDescription.count > 254 {
            showError("La description semble trop courte/trop longue (min. 3/max 255)")
        } else {
            performSegue(withIdentifier: "B_Step_Three", sender: self)
        }
        return
    }
    // Prepare Data before performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "B_Step_Three" {
            let Dest : B_RegisterPage_Step_Three_ViewController = segue.destination as! B_RegisterPage_Step_Three_ViewController

            Dest.userImage = userPhotoView.image(for: .normal)?.toBase64() ?? ""
            Dest.userDescription = userDescriptionTextView.text ?? ""
            Dest.userPseudo = userPseudo
            Dest.userEmail = userEmail
            Dest.userPassword = userPassword
        }
    }
}
