//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_UserInformationsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var postalTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var youtubeTextField: UITextField!
    @IBOutlet weak var themeTextField: UITextField!
    var restriction = RestrictionTextField()
    
    var imagePicker:UIImagePickerController!
    var imageConvert = ImageConverter()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        pseudoTextField.setLeftPaddingPoints(7)
        emailTextField.setLeftPaddingPoints(7)
        fullnameTextField.setLeftPaddingPoints(7)
        postalTextField.setLeftPaddingPoints(7)
        cityTextField.setLeftPaddingPoints(7)
        phoneTextField.setLeftPaddingPoints(7)
        facebookTextField.setLeftPaddingPoints(7)
        twitterTextField.setLeftPaddingPoints(7)
        snapchatTextField.setLeftPaddingPoints(7)
        instagramTextField.setLeftPaddingPoints(7)
        youtubeTextField.setLeftPaddingPoints(7)
        themeTextField.setLeftPaddingPoints(7)
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106:8080/inf/me",
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
                            self.cityTextField.text = response.object(forKey: "city")! as? String
                            self.postalTextField.text = response.object(forKey: "postal")! as? String
                            self.sexTextField.text = response.object(forKey: "sexe")! as? String
                            if (self.sexTextField.text == "Male") {
                                self.sexTextField.text = "Homme"
                            } else {
                                self.sexTextField.text = "Femme"
                            }
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
        
    @IBAction func pseudoTextField(_ sender: UITextField) {
        if restriction.isValidPseudo(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }
    
    @IBAction func emailTextField(_ sender: UITextField) {
        if restriction.isValidEmail(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }

    @IBAction func zipCodeTextField(_ sender: UITextField) {
        if restriction.isValidZipCode(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }
    
    @IBAction func phoneNumberTextField(_ sender: UITextField) {
        if restriction.isValidPhoneNumber(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong EMAIL")
        }
    }
    
    @IBAction func facebookTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong facebook account")
        }
    }
    
    @IBAction func twitterTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong twitter account")
        }
    }
    
    @IBAction func instagramTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong instagram account")
        }
    }
    
    @IBAction func snapchatTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong snapchat account")
        }
    }
    
    @IBAction func youtubeTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong youtube accounts")
        }
    }
    
    @IBAction func themeTextField(_ sender: UITextField) {
        if restriction.isMinThreeChar(sender.text!) {
            let noColor : UIColor = UIColor.white
            
            print(sender.text!)
            sender.layer.borderColor = noColor.cgColor

        } else {
            let errorColor : UIColor = UIColor.red

            sender.layer.borderColor = errorColor.cgColor
            sender.layer.cornerRadius = 5
            sender.layer.borderWidth = 1.0

            print("Wrong theme")
        }
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image.contentMode = .scaleAspectFill
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
                cityTextField.isUserInteractionEnabled = true
                postalTextField.isUserInteractionEnabled = true
                phoneTextField.isUserInteractionEnabled = true
                facebookTextField.isUserInteractionEnabled = true
                twitterTextField.isUserInteractionEnabled = true
                instagramTextField.isUserInteractionEnabled = true
                snapchatTextField.isUserInteractionEnabled = true
                youtubeTextField.isUserInteractionEnabled = true
                themeTextField.isUserInteractionEnabled = true
            }
            else {
                if (pseudoTextField.text!.isEmpty || emailTextField.text!.isEmpty || fullnameTextField.text!.isEmpty || cityTextField.text!.isEmpty || postalTextField.text!.isEmpty || phoneTextField.text!.isEmpty || facebookTextField.text!.isEmpty || twitterTextField.text!.isEmpty || snapchatTextField.text!.isEmpty || instagramTextField.text!.isEmpty || youtubeTextField.text!.isEmpty || themeTextField.text!.isEmpty) {
                    // /!\ One or several fields is/are empty
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs est ou sont vide(s)", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                            self.present(alertView, animated: true, completion: nil)
                        }
                    return
                }
                if restriction.isProfileCorrect(emailTextField.text!, pseudoTextField.text!, postalTextField.text!, phoneTextField.text!) == false {
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs est ou sont inconforme(s)", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                            self.present(alertView, animated: true, completion: nil)
                        }
                    return
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
                    cityTextField.isUserInteractionEnabled = false
                    postalTextField.isUserInteractionEnabled = false
                    sexTextField.isUserInteractionEnabled = false
                    phoneTextField.isUserInteractionEnabled = false
                    facebookTextField.isUserInteractionEnabled = false
                    twitterTextField.isUserInteractionEnabled = false
                    snapchatTextField.isUserInteractionEnabled = false
                    instagramTextField.isUserInteractionEnabled = false
                    youtubeTextField.isUserInteractionEnabled = false
                    themeTextField.isUserInteractionEnabled = false
                    
                    let URL = "http://168.63.65.106:8080/inf/me"

                    AF.request(URL, method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                        switch response.result {
                        case .success(_):
                            self.editItem.title = "Modifier"
                            print("\(String(describing: response.result))")
                            DispatchQueue.main.async {
                                let alertView = UIAlertController(title: "Parfait !", message: "Vos informations ont été modifié avec succès!", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel))
                                self.present(alertView, animated: true, completion: nil)
                            }
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                        }
                    }
                }
            }
        }
    }
