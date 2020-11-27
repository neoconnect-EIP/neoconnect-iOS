//
//  B_RegisterPage_Step_Four_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import StatusAlert

class B_RegisterPage_Step_Four_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userWebsiteTextField: RegisterFields!
    @IBOutlet weak var userFacebookTextField: RegisterFields!
    @IBOutlet weak var userTwitterTextField: RegisterFields!
    @IBOutlet weak var userInstagramTextField: RegisterFields!
    @IBOutlet weak var userSnapchatTextField: RegisterFields!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Nourriture", "High tech", "Sport/Fitness"]
    var pickerView = UIPickerView()
    var typeValue = "Choisissez un thème..."
    var restriction = RestrictionTextField()
    
    var userImage = String()
    var userDescription = String()
    var userPseudo = String()
    var userEmail = String()
    var userPassword = String()
    var userName = String()
    var userZipCode = String()
    var userPhoneNumber = String()
    var userCity = String()
    
    override func viewDidLoad() {
        self.loader.isHidden = true
        super.viewDidLoad()
    }

    @IBAction func isValidField(_ sender: RegisterFields) {
        sender.isValidField(sender: sender, field: "default")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.subviews.forEach({
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
        typeValue = "Mode"

        alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            
            self.pickerViewButton.setTitle(self.typeValue, for: .normal)
            print("You selected " + self.typeValue )
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func checkFieldsFromAPI(_ userFacebook: String, _ userTwitter: String, _ userInstagram: String, _ userSnapchat: String, _ userWebsite: String, _ userSubject: String) {
        loader.isHidden = false
        loader.startAnimating()
        APIManager.sharedInstance.checkUserField(fieldToCheck: "facebook", userField: userFacebook, onSuccess: { response in
            if response && !self.restriction.isMinThreeChar(userFacebook) {
                self.showError("Le facebook renseigné a déjà été utilisé")
            } else {
                APIManager.sharedInstance.checkUserField(fieldToCheck: "twitter", userField: userTwitter, onSuccess: { response in
                    if response && !self.restriction.isMinThreeChar(userTwitter) {
                        self.showError("Le twitter renseigné a déjà été utilisé")
                    } else {
                        APIManager.sharedInstance.checkUserField(fieldToCheck: "instagram", userField: userInstagram, onSuccess: { response in
                            if response && !self.restriction.isMinThreeChar(userInstagram) {
                                self.showError("L'instagram renseigné a déjà été utilisé")
                            } else {
                                APIManager.sharedInstance.checkUserField(fieldToCheck: "snapchat", userField: userSnapchat, onSuccess: { response in
                                    if response && !self.restriction.isMinThreeChar(userSnapchat) {
                                        self.showError("Le snapchat renseigné a déjà été utilisé")
                                    } else {
                                        APIBrandManager.sharedInstance.register_Shop(pseudo: self.userPseudo, password: self.userPassword, name: self.userName, email: self.userEmail, website: userWebsite, phoneNumber: self.userPhoneNumber, zipCode: self.userZipCode, city: self.userCity, userPicture: self.userImage, description: self.userDescription, subject: userSubject, facebook: userFacebook, snapchat: userSnapchat, twitter: userTwitter, instagram: userInstagram, onSuccess: {
                                                                                        DispatchQueue.main.async {
                                                                                            let statusAlert = StatusAlert()
                                                                                            statusAlert.image = UIImage(named: "Success icon.png")
                                                                                            statusAlert.title = "Inscription réussie !"
                                                                                            statusAlert.message = "Vous vous êtes inscrit(e) avec succès !"
                                                                                            statusAlert.showInKeyWindow()
                                                                                            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "B_Register")
                                                                                            self.show(loginVC!, sender: nil)
                                                                                        }}, onFailure: {
                                                                                            self.showError("Une erreur est survenue, veuillez réessayer")
                                                                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
            self.loader.isHidden = true
            self.loader.stopAnimating()
        })
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userWebsite = userWebsiteTextField.text!
        let userFacebook = userFacebookTextField.text!
        let userTwitter = userTwitterTextField.text!
        let userInstagram = userInstagramTextField.text!
        let userSnapchat = userSnapchatTextField.text!
        let userSubject = typeValue
        
        // Erreur : un champ fait entre 1 et 3 caractères
        if (!restriction.isMinThreeChar(userWebsite) ||
                !restriction.isMinThreeChar(userFacebook) || !restriction.isMinThreeChar(userTwitter) || !restriction.isMinThreeChar(userInstagram) || !restriction.isMinThreeChar(userSnapchat) || userSubject == "Choisissez un thème...") {
            showError("Un ou plusieurs de vos champs semblent être inconforme")
        } else {
            checkFieldsFromAPI(userFacebook, userTwitter, userInstagram, userSnapchat, userWebsite, userSubject)
        }
    }
}
