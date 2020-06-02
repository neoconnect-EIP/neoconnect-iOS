//
//  AddOfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import DLRadioButton

class AddOfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var themeTextField: UITextField!
    
    var imagePicker:UIImagePickerController!
    var imageConverter = ImageConverter()
    var sex = String()
    
    override func viewDidLoad() {
        imageView.image = nil
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        super.viewDidLoad()
    }
    
    @IBAction func radioSexButtonTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            sex = "Male"
        }
        else if (sender.tag == 2) {
            sex = "Female"
        }
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
                
            present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFill
                imageView.image = pickedImage
                changeImageButton.setImage(nil, for: .normal)
            }
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let name = nameTextField.text!
        let desc = descTextView.text!
        let theme = themeTextField.text!
        let image = imageView.image
        
        if (name.isEmpty || desc.isEmpty || theme.isEmpty || sex.isEmpty || image == nil) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
        }
        else {
            let imageData = imageConverter.imageToBase64(image!)!
            let imageName = "Image"

            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let offer: [String: Any] = [
                "productImg": [
                    [
                        "imageName": imageName,
                        "imageData": imageData
                    ]
                ],
                "productName": name,
                "productSex": sex,
                "productDesc": desc,
                "productSubject": theme,

            ]
            let URL = "http://168.63.65.106/offer/insert"
    
            AF.request(URL, method: .post, parameters: offer, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                switch response.result {
                        case .success(_):
                            // Offre ajoutée

                            print("\(String(describing: response.result))")
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Ajouté !", message: "Votre offre à été ajouté avec succès.", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                                self.present(alertView, animated: true, completion: nil)
                                self.imageView.image = nil
                                self.nameTextField.text?.removeAll()
                                self.descTextView.text?.removeAll()
                                self.themeTextField.text?.removeAll()
                                let image = UIImage(named: "noImage.png")
                                self.changeImageButton.setImage(image, for: .normal)
                            }

                        case .failure(let error):
                            // Inscription ratée

                            print("Request failed with error: \(error)")

                        }
            }
        }
    }
}
