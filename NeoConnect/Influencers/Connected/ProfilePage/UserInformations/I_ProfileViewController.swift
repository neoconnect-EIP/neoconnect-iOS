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
    @IBOutlet weak var youtubeTextField: UITextField!
    @IBOutlet weak var themeTextField: UITextField!
    
    var imagePicker:UIImagePickerController!
    var imageConvert = ImageConverter()

    override func viewDidLoad() {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106/inf/me",
                   headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                                                    
                            let response = JSON as! NSDictionary
                            print(response)
                            let imageArray = response.object(forKey: "userPicture")! as! [[String:Any]]
                            var imageData = #imageLiteral(resourceName: "noImage")
                            if imageArray.count > 0 {
                                let imageUrl = URL(string: imageArray[0]["imageData"] as! String)!
                                imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
                            }
                            self.image.image = imageData
                            self.pseudoTextField.text = response.object(forKey: "pseudo")! as? String
                            self.emailTextField.text = response.object(forKey: "email")! as? String
                            self.fullnameTextField.text = response.object(forKey: "full_name")! as? String
                            self.postalTextField.text = response.object(forKey: "postal")! as? String
                            self.cityTextField.text = response.object(forKey: "city")! as? String
                            self.phoneTextField.text = response.object(forKey: "phone")! as? String
                            self.facebookTextField.text = response.object(forKey: "facebook")! as? String
                            self.twitterTextField.text = response.object(forKey: "twitter")! as? String
                            self.instagramTextField.text = response.object(forKey: "instagram")! as? String
                            self.snapchatTextField.text = response.object(forKey: "snapchat")! as? String
                            self.youtubeTextField.text = response.object(forKey: "youtube")! as? String
                            self.themeTextField.text = response.object(forKey: "theme")! as? String

                        case .failure(let error):
                                print("Request failed with error: \(error)")
                    }
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self

        super.viewDidLoad()
    }
    
    @IBAction func emailTextField(_ sender: UITextField) {
        if isValidEmail(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
                editItem.title = "Enregistrer"
                changeImageButton.isUserInteractionEnabled = true
                pseudoTextField.isUserInteractionEnabled = true
                emailTextField.isUserInteractionEnabled = true
                fullnameTextField.isUserInteractionEnabled = true
                postalTextField.isUserInteractionEnabled = true
                cityTextField.isUserInteractionEnabled = true
                phoneTextField.isUserInteractionEnabled = true
                facebookTextField.isUserInteractionEnabled = true
                twitterTextField.isUserInteractionEnabled = true
                snapchatTextField.isUserInteractionEnabled = true
                instagramTextField.isUserInteractionEnabled = true
                youtubeTextField.isUserInteractionEnabled = true
                themeTextField.isUserInteractionEnabled = true
            }
            else {
                let imageData = imageConvert.imageToBase64(image.image!)!
                                
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
                    "userPicture": imageData,
                    "theme": themeTextField.text!,
                    "facebook": facebookTextField.text!,
                    "snapchat": snapchatTextField.text!,
                    "twitter": twitterTextField.text!,
                    "instagram": instagramTextField.text!,
                    "youtube": youtubeTextField.text!
                ]
                changeImageButton.isUserInteractionEnabled = false
                pseudoTextField.isUserInteractionEnabled = false
                emailTextField.isUserInteractionEnabled = false
                fullnameTextField.isUserInteractionEnabled = false
                postalTextField.isUserInteractionEnabled = false
                cityTextField.isUserInteractionEnabled = false
                phoneTextField.isUserInteractionEnabled = false
                facebookTextField.isUserInteractionEnabled = false
                twitterTextField.isUserInteractionEnabled = false
                snapchatTextField.isUserInteractionEnabled = false
                instagramTextField.isUserInteractionEnabled = false
                youtubeTextField.isUserInteractionEnabled = false
                themeTextField.isUserInteractionEnabled = false
                
                AF.request("http://168.63.65.106/inf/me", method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                    switch response.result {
                    case .success(_):
                        self.editItem.title = "Modifier"
                        print("\(String(describing: response.result))")
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Parfait!", message: "Vos informations ont été modifié avec succès!", preferredStyle: .alert)
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
