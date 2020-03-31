//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var postalTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var themeTextField: UITextField!
    
    var imagePicker:UIImagePickerController!
    var imageConvert = ImageConverter()
        
    override func viewDidLoad() {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        changeImageButton.isHidden = true
        
        let decoded = UserDefaults.standard.data(forKey: "User")
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! User
        
        self.image.image = user.imageData
        self.pseudoTextField.text = user.pseudo
        self.emailTextField.text = user.email
        self.fullnameTextField.text = user.full_name
        self.postalTextField.text = user.postal
        self.cityTextField.text = user.city
        self.phoneTextField.text = user.phone
        self.facebookTextField.text = user.facebook
        self.twitterTextField.text = user.twitter
        self.instagramTextField.text = user.instagram
        self.snapchatTextField.text = user.snapchat
        self.themeTextField.text = user.theme

        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
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
                facebookTextField.isUserInteractionEnabled = true;
                twitterTextField.isUserInteractionEnabled = true;
                snapchatTextField.isUserInteractionEnabled = true;
                instagramTextField.isUserInteractionEnabled = true;
                themeTextField.isUserInteractionEnabled = true;
            }
            else {
                let imageData = imageConvert.imageToBase64(image.image!)!
                let imageName = pseudoTextField.text! + "_PP"
                let userPicture = [
                    [
                        "imageData" : imageData,
                        "imageName" : imageName
                    ]
                ]
                                
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
                    "userPicture": userPicture,
                    "theme": themeTextField.text!,
                    "facebook": facebookTextField.text!,
                    "snapchat": snapchatTextField.text!,
                    "twitter": twitterTextField.text!,
                    "instagram": instagramTextField.text!
                ]
                pseudoTextField.isUserInteractionEnabled = false;
                emailTextField.isUserInteractionEnabled = false;
                fullnameTextField.isUserInteractionEnabled = false;
                postalTextField.isUserInteractionEnabled = false;
                cityTextField.isUserInteractionEnabled = false;
                phoneTextField.isUserInteractionEnabled = false;
                facebookTextField.isUserInteractionEnabled = false;
                twitterTextField.isUserInteractionEnabled = false;
                snapchatTextField.isUserInteractionEnabled = false;
                instagramTextField.isUserInteractionEnabled = false;
                themeTextField.isUserInteractionEnabled = false;
                
                AF.request("http://168.63.65.106/inf/me", method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                    switch response.result {
                    case .success(_):
                        self.editItem.title = "Modifier"
                        print("\(String(describing: response.result))")
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Done!", message: "Your informations have been updated successfully!", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                            self.present(alertView, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
            }
        }
    }
