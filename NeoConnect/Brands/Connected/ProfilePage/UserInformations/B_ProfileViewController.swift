//
//  B_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var postalTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var societyTextField: UITextField!
    @IBOutlet weak var functionTextField: UITextField!
    @IBOutlet weak var themeTextField: UITextField!
    
    var imagePicker:UIImagePickerController!
    var imageConverter = ImageConverter()
        
    
    override func viewDidLoad() {
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        changeImageButton.isHidden = true
        
        let decoded = UserDefaults.standard.data(forKey: "Shop")
        let shop = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! Shop
        
        self.image.image = shop.imageData
        self.pseudoTextField.text = shop.pseudo
        self.emailTextField.text = shop.email
        self.fullnameTextField.text = shop.full_name
        self.postalTextField.text = shop.postal
        self.cityTextField.text = shop.city
        self.phoneTextField.text = shop.phone
        self.societyTextField.text = shop.society
        self.functionTextField.text = shop.function
        self.themeTextField.text = shop.theme

        super.viewDidLoad()
    }
        
    @IBAction func changeImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.contentMode = .scaleAspectFit
            image.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if (self.editItem.title == "Modifier") {
            changeImageButton.isHidden = false
            editItem.title = "Enregistrer"
            pseudoTextField.isUserInteractionEnabled = true;
            emailTextField.isUserInteractionEnabled = true;
            fullnameTextField.isUserInteractionEnabled = true;
            postalTextField.isUserInteractionEnabled = true;
            cityTextField.isUserInteractionEnabled = true;
            phoneTextField.isUserInteractionEnabled = true;
            societyTextField.isUserInteractionEnabled = true;
            functionTextField.isUserInteractionEnabled = true;
            themeTextField.isUserInteractionEnabled = true;
        }
        else {
            let imageData = imageConverter.imageToBase64(image.image!)!
            let imageName = pseudoTextField.text! + "_PP"
            
            changeImageButton.isHidden = true
            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let new_Info: Parameters = [
                "pseudo": pseudoTextField.text!,
                "full_name": fullnameTextField.text!,
                "email": emailTextField.text!,
                "phone": phoneTextField.text!,
                "postal": postalTextField.text!,
                "city": cityTextField.text!,
                "userPicture": [
                    [
                        "imageName": imageName,
                        "imageData": imageData
                    ]
                ],                "theme": themeTextField.text!,
                "society": societyTextField.text!,
                "function": functionTextField.text!
            ]
            pseudoTextField.isUserInteractionEnabled = false;
            emailTextField.isUserInteractionEnabled = false;
            fullnameTextField.isUserInteractionEnabled = false;
            postalTextField.isUserInteractionEnabled = false;
            cityTextField.isUserInteractionEnabled = false;
            phoneTextField.isUserInteractionEnabled = false;
            societyTextField.isUserInteractionEnabled = false;
            functionTextField.isUserInteractionEnabled = false;
            themeTextField.isUserInteractionEnabled = false;
            
            AF.request("http://168.63.65.106/shop/me", method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                switch response.result {
                case .success(_):
                    self.editItem.title = "Modifier"
                    print("\(String(describing: response.result))")
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Done!", message: "Your informations have been updated successfully!", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                        self.present(alertView, animated: true, completion: nil)
                    }                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
}
