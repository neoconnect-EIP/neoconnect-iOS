//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import StatusAlert

class I_UserInformationsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var userPhotoView: PhotoFieldButton!
    @IBOutlet weak var userDescriptionTextView: DefaultTextViews!
    @IBOutlet weak var pseudoTextField: DefaultTextFields!
    @IBOutlet weak var emailTextField: DefaultTextFields!
    @IBOutlet weak var fullnameTextField: DefaultTextFields!
    @IBOutlet weak var postalTextField: DefaultTextFields!
    @IBOutlet weak var cityTextField: DefaultTextFields!
    @IBOutlet weak var phoneTextField: DefaultTextFields!
    @IBOutlet weak var facebookTextField: DefaultTextFields!
    @IBOutlet weak var twitterTextField: DefaultTextFields!
    @IBOutlet weak var snapchatTextField: DefaultTextFields!
    @IBOutlet weak var instagramTextField: DefaultTextFields!
    @IBOutlet weak var youtubeTextField: DefaultTextFields!
    @IBOutlet weak var twitchTextField: DefaultTextFields!
    @IBOutlet weak var pinterestTextField: DefaultTextFields!
    @IBOutlet weak var tiktokTextField: DefaultTextFields!
    @IBOutlet weak var pickerViewButton: UIButton!
    var restriction = RestrictionTextField()
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Nourriture", "High tech", "Sport/Fitness"]
    var themePickerView = UIPickerView()
    var typeValue = "Mode"
    var imagePicker:UIImagePickerController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        APIManager.sharedInstance.getUserImage(onSuccess: { image in
            self.userPhotoView.setImage(image, for: .normal)
        })
        APIInfManager.sharedInstance.getInfo(onSuccess: { response in
            self.pseudoTextField.text = response["pseudo"] as? String
            self.emailTextField.text = response["email"] as? String
            self.fullnameTextField.text = response["full_name"] as? String
            self.cityTextField.text = response["city"] as? String
            self.postalTextField.text = response["postal"] as? String
            self.phoneTextField.text = response["phone"] as? String
            self.facebookTextField.text = response["facebook"] as? String
            self.twitterTextField.text = response["twitter"] as? String
            self.instagramTextField.text = response["instagram"] as? String
            self.snapchatTextField.text = response["snapchat"] as? String
            self.youtubeTextField.text = response["youtube"] as? String
            self.twitchTextField.text = response["twitch"] as? String
            self.pinterestTextField.text = response["pinterest"] as? String
            self.tiktokTextField.text = response["tiktok"] as? String
            self.typeValue = response["theme"] as? String ?? "Mode"
            self.pickerViewButton.setTitle(self.typeValue, for: .normal)
        })
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        super.viewDidLoad()
    }
    
    @IBAction func isValidField(_ sender: DefaultTextFields) {
        switch sender.placeholder {
            case "Pseudo":
                sender.handleError(sender: sender, field: "Pseudo")
            case "Email":
                sender.handleError(sender: sender, field: "Email")
            case "Téléphone":
                sender.handleError(sender: sender, field: "Téléphone")
            case "Code postal":
                sender.handleError(sender: sender, field: "Code postal")
            default:
                sender.handleError(sender: sender, field: "default")
        }
    }
    
    @IBAction func changeImageButtonTapped(_ sender: Any) {
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        themePickerView.subviews.forEach({
            $0.isHidden = $0.frame.height < 1.0
        })
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
            case 1:
                typeValue = "Cosmétique"
            case 2:
                typeValue = "Jeux Vidéo"
            case 3:
                typeValue = "Nourriture"
            case 4:
                typeValue = "High tech"
            case 5:
                typeValue = "Sport/Fitness"
            default:
                typeValue = "Mode"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Raleway-Medium", size: 17)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = pickerData[row]
        pickerLabel?.textColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        
        return pickerLabel!
    }
    
    @IBAction func pickerViewButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choisissez votre thème", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.tintColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            
            self.pickerViewButton.setTitle(self.typeValue, for: .normal)
            print("You selected " + self.typeValue )
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let userImage = userPhotoView.currentImage else { return }
        guard let userPseudo = pseudoTextField.text else { return }
        guard let userDescription = userDescriptionTextView.text else { return }
        guard let userEmail = emailTextField.text else { return }
        guard let userFullname = fullnameTextField.text else { return }
        guard let userPostal = postalTextField.text else { return }
        guard let userCity = cityTextField.text else { return }
        guard let userPhone = phoneTextField.text else { return }
        guard let userFacebook = facebookTextField.text else { return }
        guard let userTwitter = twitterTextField.text else { return }
        guard let userSnapchat = snapchatTextField.text else { return }
        guard let userInstagram = instagramTextField.text else { return }
        guard let userYoutube = youtubeTextField.text else { return }
        guard let userTwitch = twitchTextField.text else { return }
        guard let userPinterest = pinterestTextField.text else { return }
        guard let userTiktok = tiktokTextField.text else { return }
        
        if (self.editItem.title == "Modifier") {
            editItem.title = "Enregistrer"
            userPhotoView.isUserInteractionEnabled = true
            userDescriptionTextView.isUserInteractionEnabled = true
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
            twitchTextField.isUserInteractionEnabled = true
            pinterestTextField.isUserInteractionEnabled = true
            tiktokTextField.isUserInteractionEnabled = true
            themePickerView.isUserInteractionEnabled = true
        }
        else {
            if (pseudoTextField.text!.isEmpty || emailTextField.text!.isEmpty) {
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
            if (restriction.isMinThreeChar(facebookTextField.text!) == false || restriction.isMinThreeChar(twitterTextField.text!) == false || restriction.isMinThreeChar(instagramTextField.text!) == false || restriction.isMinThreeChar(snapchatTextField.text!) == false || restriction.isMinThreeChar(youtubeTextField.text!) == false || restriction.isMinThreeChar(twitchTextField.text!) == false || restriction.isMinThreeChar(pinterestTextField.text!) == false || restriction.isMinThreeChar(tiktokTextField.text!) == false) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs possède(nt) moins de trois caractères donc semble inconforme", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            }
            else {
                let userPicture = userImage.toBase64() ?? ""
                
                APIInfManager.sharedInstance.editInfo(pseudo: userPseudo, fullname: userFullname, email: userEmail, phoneNumber: userPhone, zipCode: userPostal, city: userCity, userPicture: userPicture, userDescription: userDescription, subject: typeValue, facebook: userFacebook, snapchat: userSnapchat, twitter: userTwitter, instagram: userInstagram, youtube: userYoutube, twitch: userTwitch, pinterest: userPinterest, tiktok: userTiktok, onSuccess: {
                    let statusAlert = StatusAlert()
                    statusAlert.alertShowingDuration = 1
                    statusAlert.image = UIImage(named: "Success icon.png")
                    statusAlert.title = "Modification réussie !"
                    statusAlert.message = "Vous avez modifié votre profil avec succès !"
                    statusAlert.showInKeyWindow()
                    self.editItem.title = "Modifier"
                    self.userPhotoView.isUserInteractionEnabled = false
                    self.userDescriptionTextView.isUserInteractionEnabled = false
                    self.pseudoTextField.isUserInteractionEnabled = false
                    self.emailTextField.isUserInteractionEnabled = false
                    self.fullnameTextField.isUserInteractionEnabled = false
                    self.cityTextField.isUserInteractionEnabled = false
                    self.postalTextField.isUserInteractionEnabled = false
                    self.phoneTextField.isUserInteractionEnabled = false
                    self.facebookTextField.isUserInteractionEnabled = false
                    self.twitterTextField.isUserInteractionEnabled = false
                    self.snapchatTextField.isUserInteractionEnabled = false
                    self.instagramTextField.isUserInteractionEnabled = false
                    self.youtubeTextField.isUserInteractionEnabled = false
                    self.twitchTextField.isUserInteractionEnabled = false
                    self.pinterestTextField.isUserInteractionEnabled = false
                    self.tiktokTextField.isUserInteractionEnabled = false
                    self.themePickerView.isUserInteractionEnabled = false
                }, onFailure: {
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Erreur", message: "Un problème est survenu, veuillez réessayer", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
                        self.present(alertView, animated: true, completion: nil)
                    }
                })
            }
        }
    }
}
