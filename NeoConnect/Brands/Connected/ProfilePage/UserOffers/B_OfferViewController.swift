//
//  B_OfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire
import DLRadioButton

class B_OfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleField: UITextField!
    @IBOutlet weak var offerFemaleButton: DLRadioButton!
    @IBOutlet weak var offerMaleButton: DLRadioButton!
    @IBOutlet weak var offerDescriptionField: UITextView!
    @IBOutlet weak var offerSubjectField: UITextField!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var changeImageButton: UIButton!
    
    var offerId: Int?
    var offerTitle : String?
    var offerImage : UIImage?
    var offerSex : String?
    var offerDescription : String?
    var offerSubject : String?
    
    var imagePicker:UIImagePickerController!
    var imageConverter = ImageConverter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.title = offerTitle
        offerTitleField.text = offerTitle
        offerDescriptionField.text = offerDescription
        offerSubjectField.text = offerSubject
        offerImageView.image = offerImage
        if (offerSex == "Male") {
            offerMaleButton.isSelected = true
        } else {
            offerFemaleButton.isSelected = true
        }
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
                
            present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                offerImageView.contentMode = .scaleAspectFit
                offerImageView.image = pickedImage
            }
         
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    @IBAction func radioSexButtonTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            offerSex = "Male"
        }
        else if (sender.tag == 2) {
            offerSex = "Female"
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let name = offerTitleField.text!
        let desc = offerDescriptionField.text!
        let subject = offerSubjectField.text!
        let image = offerImageView.image!
        
        if (self.editItem.title == "Modifier") {
            editItem.title = "Enregistrer"
            offerTitleField.isUserInteractionEnabled = true
            offerFemaleButton.isUserInteractionEnabled = true
            offerMaleButton.isUserInteractionEnabled = true
            offerDescriptionField.isUserInteractionEnabled = true
            offerSubjectField.isUserInteractionEnabled = true
            changeImageButton.isUserInteractionEnabled = true
        }
        else {
            if (name.isEmpty || desc.isEmpty || subject.isEmpty || offerSex!.isEmpty) {
                if (image == nil){
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                        self.present(alertView, animated: true, completion: nil)
                    }
                }
            }
            else {
                let imageData = imageConverter.imageToBase64(image)!
                let imageName = name + "_Img"

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
                    "productSex": offerSex,
                    "productDesc": desc,
                    "productSubject": subject,
                ]
                let URL = "http://168.63.65.106/offer/" + String(offerId!)
                
                AF.request(URL, method: .put, parameters: offer, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                    switch response.result {
                            case .success(_):
                                // Offre modifiée

                                self.editItem.title = "Enregistrer"
                                self.offerTitleField.isUserInteractionEnabled = true
                                self.offerFemaleButton.isUserInteractionEnabled = true
                                self.offerMaleButton.isUserInteractionEnabled = true
                                self.offerDescriptionField.isUserInteractionEnabled = true
                                self.offerSubjectField.isUserInteractionEnabled = true
                                self.changeImageButton.isUserInteractionEnabled = true
                                
                                print("\(String(describing: response.result))")
                                DispatchQueue.main.async {
                                    let alertView = UIAlertController(title: "Great !", message: "Your offer has been modified successfully!", preferredStyle: .alert)
                                    alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                                    self.present(alertView, animated: true, completion: nil)
                                }

                            case .failure(let error):
                                // Erreur de la modification de l'offre

                                print("Request failed with error: \(error)")

                            }
                }
            }
        }
    }
}
