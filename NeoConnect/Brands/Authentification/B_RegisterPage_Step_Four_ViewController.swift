//
//  B_RegisterPage_Step_Four_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 07/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class B_RegisterPage_Step_Four_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userFacebookTextField: RegisterFields!
    @IBOutlet weak var userTwitterTextField: RegisterFields!
    @IBOutlet weak var userInstagramTextField: RegisterFields!
    @IBOutlet weak var userSnapchatTextField: RegisterFields!
    @IBOutlet weak var pickerViewButton: UIButton!

    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Food", "High Tech", "Sport/Fitness"]
    var pickerView = UIPickerView()
    var typeValue = "Mode"
    var restriction = RestrictionTextField()
    
    var image = UIImage()
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    var company = String()
    var profession = String()
    var website = String()
    var imageConverter = ImageConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func facebookTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func twitterTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func instagramTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func snapchatTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
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
                typeValue = "Food"
            case 4:
                typeValue = "High Tech"
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
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            
            self.pickerViewButton.setTitle(self.typeValue, for: .normal)
            print("You selected " + self.typeValue )
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    @IBAction func register_ButtonTapped(_ sender: Any) {
        let userFacebook = userFacebookTextField.text!
        let userTwitter = userTwitterTextField.text!
        let userInstagram = userInstagramTextField.text!
        let userSnapchat = userSnapchatTextField.text!
        let userSubject = typeValue
        let userPicture = imageConverter.imageToBase64(image)
        
        // Erreur : un champ fait entre 1 et 3 caractères
        if (!restriction.isMinThreeChar(userWebsite) ||
                !restriction.isMinThreeChar(userFacebook) || !restriction.isMinThreeChar(userTwitter) || !restriction.isMinThreeChar(userInstagram) || !restriction.isMinThreeChar(userSnapchat) || userSubject == "Choisissez un thème...") {
            showError("Un ou plusieurs de vos champs semblent être inconforme")
        } else {
            APIBrandManager.sharedInstance.register_Shop(pseudo: userPseudo, password: userPassword, name: userName, email: userEmail, website: userWebsite, phoneNumber: userPhoneNumber, zipCode: userZipCode, city: userCity, userPicture: userImage, description: userDescription, subject: userSubject, facebook: userFacebook, snapchat: userSnapchat, twitter: userTwitter, instagram: userInstagram, onSuccess: {
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
    }
}
