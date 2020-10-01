//
//  I_RegisterPage_Step_Three_ViewController.swift
//  NeoConnect
//
//  Created by EIP on 11/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_RegisterPage_Step_Three_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userFacebookTextField: RegisterFields!
    @IBOutlet weak var userTwitterTextField: RegisterFields!
    @IBOutlet weak var userInstagramTextField: RegisterFields!
    @IBOutlet weak var userSnapchatTextField: RegisterFields!
    @IBOutlet weak var userYoutubeTextField: RegisterFields!
    @IBOutlet weak var userTwitchTextField: RegisterFields!
    @IBOutlet weak var userPinterestTextField: RegisterFields!
    @IBOutlet weak var userTiktokTextField: RegisterFields!
    @IBOutlet weak var pickerViewButton: UIButton!
    
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Food", "High Tech", "Sport/Fitness"]
    var pickerView = UIPickerView()
    var typeValue = "Mode"
    var restriction = RestrictionTextField()
    var imageConverter = ImageConverter()
    
    var image = UIImage()
    var pseudo = String()
    var email = String()
    var password = String()
    var name = String()
    var sex = String()
    var zipCode = String()
    var phoneNumber = String()
    var city = String()
    
    
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
    
    @IBAction func youtubeTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func twitchTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func pinterestTextField(_ sender: RegisterFields) {
        sender.handleError(sender: sender, field: "default")
    }
    
    @IBAction func tiktokTextField(_ sender: RegisterFields) {
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
        pickerLabel?.textColor = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
        
        return pickerLabel!
    }
    
    @IBAction func pickerViewButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Choisissez votre thème", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        alert.view.tintColor = UIColor(red: 60/255, green: 157/255, blue: 192/255, alpha: 1.0)
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
        let userYoutube = userYoutubeTextField.text!
        let userTwitch = userTwitchTextField.text!
        let userPinterest = userPinterestTextField.text!
        let userTiktok = userTiktokTextField.text!
        let userSubject = typeValue
        let userPicture = imageConverter.imageToBase64(image)
        
        // Erreur : un champ est vide
        if (!userFacebook.isEmpty || !userTwitter.isEmpty || !userInstagram.isEmpty || !userSnapchat.isEmpty || userSubject == "Choisissez un thème") {
            if (!restriction.isMinThreeChar(userFacebook) || !restriction.isMinThreeChar(userTwitter) || !restriction.isMinThreeChar(userInstagram) || !restriction.isMinThreeChar(userSnapchat) ||
                !restriction.isMinThreeChar(userYoutube) || !restriction.isMinThreeChar(userTwitch) ||
                !restriction.isMinThreeChar(userPinterest) || !restriction.isMinThreeChar(userTiktok)) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs semblent être inconforme", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            }
        }
        else {
            APIInfManager.sharedInstance.register_Inf(pseudo: pseudo, password: password, sex: sex, name: name, email: email, phoneNumber: phoneNumber, zipCode: zipCode, city: city, userPicture: userPicture!, subject: userSubject, facebook: userFacebook, twitter: userTwitter, instagram: userInstagram, snapchat: userSnapchat, youtube: userYoutube, twitch: userTwitch,  pinterest: userPinterest, tiktok: userTiktok, onSuccess: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Parfait !", message: "Inscription réussie.", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel) { action in
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "I_Register")
                        self.show(loginVC!, sender: nil)
                    })
                    self.present(alertView, animated: true, completion: nil)
                }
            }, onFailure: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Une erreur est survenue, veuillez réessayer", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
        return
    }
}
