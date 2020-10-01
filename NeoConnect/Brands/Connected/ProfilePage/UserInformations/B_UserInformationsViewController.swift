//
//  B_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_UserInformationsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var userPhotoView: PhotoFieldButton!
    @IBOutlet weak var pseudoTextField: DefaultTextFields!
    @IBOutlet weak var emailTextField: DefaultTextFields!
    @IBOutlet weak var fullnameTextField: DefaultTextFields!
    @IBOutlet weak var postalTextField: DefaultTextFields!
    @IBOutlet weak var cityTextField: DefaultTextFields!
    @IBOutlet weak var phoneTextField: DefaultTextFields!
    @IBOutlet weak var societyTextField: DefaultTextFields!
    @IBOutlet weak var functionTextField: DefaultTextFields!
    @IBOutlet weak var websiteTextField: DefaultTextFields!
    @IBOutlet weak var facebookTextField: DefaultTextFields!
    @IBOutlet weak var instagramTextField: DefaultTextFields!
    @IBOutlet weak var twitterTextField: DefaultTextFields!
    @IBOutlet weak var snapchatTextField: DefaultTextFields!
    @IBOutlet weak var pickerViewButton: UIButton!
    var restriction = RestrictionTextField()
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Food", "High Tech", "Sport/Fitness"]
    var themePickerView = UIPickerView()
    var typeValue = "Mode"
    var imagePicker:UIImagePickerController!
    var imageConverter = ImageConverter()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        APIBrandManager.sharedInstance.getInfo(onSuccess: { response in
            DispatchQueue.main.async {
                let imageArray = response["userPicture"] as? [[String:Any]]
                let imageUrl = URL(string: imageArray![0]["imageData"] as! String)!
                let imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
                self.userPhotoView.setImage(imageData, for: .normal)
                self.pseudoTextField.text = response["pseudo"] as? String
                self.emailTextField.text = response["email"] as? String
                self.fullnameTextField.text = response["full_name"] as? String
                self.postalTextField.text = response["postal"] as? String
                self.cityTextField.text = response["city"] as? String
                self.phoneTextField.text = response["phone"] as? String
                self.societyTextField.text = response["society"] as? String
                self.functionTextField.text = response["function"] as? String
                self.websiteTextField.text = response["website"] as? String
                self.facebookTextField.text = response["facebook"] as? String
                self.twitterTextField.text = response["twitter"] as? String
                self.snapchatTextField.text = response["snapchat"] as? String
                self.instagramTextField.text = response["instagram"] as? String
                self.typeValue = response["theme"] as? String ?? "Mode"
                self.pickerViewButton.setTitle(self.typeValue, for: .normal)
            }
        }, onFailure: { error in
            DispatchQueue.main.async {
                // Message d'alerte
                print("Request failed with error: \(error)")
            }
        })
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        super.viewDidLoad()
    }
    
    @IBAction func userPseudoDidEnd(_ sender: DefaultTextFields) {
        sender.handleError(sender: sender, field: "pseudo")
    }
    
    @IBAction func userEmailDidEnd(_ sender: DefaultTextFields) {
        sender.handleError(sender: sender, field: "email")
    }
    
    @IBAction func userZipCodeDidEnd(_ sender: DefaultTextFields) {
        sender.handleError(sender: sender, field: "zipCode")
    }
    
    @IBAction func userPhoneNumberDidEnd(_ sender: DefaultTextFields) {
        sender.handleError(sender: sender, field: "phoneNumbber")
    }
    
    @IBAction func defaultCompanyDidEnd(_ sender: DefaultTextFields) {
        sender.handleError(sender: sender, field: "default")
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
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if (self.editItem.title == "Modifier") {
            editItem.title = "Enregistrer"
            userPhotoView.isUserInteractionEnabled = true
            pseudoTextField.isUserInteractionEnabled = true
            emailTextField.isUserInteractionEnabled = true
            fullnameTextField.isUserInteractionEnabled = true
            postalTextField.isUserInteractionEnabled = true
            cityTextField.isUserInteractionEnabled = true
            phoneTextField.isUserInteractionEnabled = true
            societyTextField.isUserInteractionEnabled = true
            functionTextField.isUserInteractionEnabled = true
            websiteTextField.isUserInteractionEnabled = true
            facebookTextField.isUserInteractionEnabled = true
            twitterTextField.isUserInteractionEnabled = true
            snapchatTextField.isUserInteractionEnabled = true
            instagramTextField.isUserInteractionEnabled = true
            themePickerView.isUserInteractionEnabled = true
        }
        else {
            if (pseudoTextField.text!.isEmpty || emailTextField.text!.isEmpty) {
                // /!\ One or several fields is/are empty
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Erreur", message: "Veuillez au minium, indiquer votre adresse email ainsi que votre pseudo", preferredStyle: .alert)
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
            if (restriction.isMinThreeChar(facebookTextField.text!) == false || restriction.isMinThreeChar(twitterTextField.text!) == false || restriction.isMinThreeChar(instagramTextField.text!) == false || restriction.isMinThreeChar(snapchatTextField.text!) == false) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Un ou plusieurs de vos champs possède(nt) moins de trois caractères donc semble inconforme", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            }
            else {
                let userPicture = imageConverter.imageToBase64(userPhotoView.image(for: .normal)!)
                
                APIBrandManager.sharedInstance.editInfo(pseudo: pseudoTextField.text!, fullname: fullnameTextField.text!, email: emailTextField.text!, phoneNumber: phoneTextField.text!, zipCode: postalTextField.text!, city: cityTextField.text!, userPicture: userPicture!, subject: typeValue, website: websiteTextField.text!, society: societyTextField.text!, profession: functionTextField.text!, facebook: facebookTextField.text!, snapchat: snapchatTextField.text!, twitter: twitterTextField.text!, instagram: instagramTextField.text!, onSuccess: {
                    DispatchQueue.main.async {
                        self.editItem.title = "Modifier"
                        let alertView = UIAlertController(title: "Parfait !", message: "Vos informations ont été modifié avec succès!", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel))
                        self.present(alertView, animated: true, completion: nil)
                    }
                    
                    self.userPhotoView.isUserInteractionEnabled = false
                    self.pseudoTextField.isUserInteractionEnabled = false
                    self.emailTextField.isUserInteractionEnabled = false
                    self.fullnameTextField.isUserInteractionEnabled = false
                    self.postalTextField.isUserInteractionEnabled = false
                    self.cityTextField.isUserInteractionEnabled = false
                    self.phoneTextField.isUserInteractionEnabled = false
                    self.societyTextField.isUserInteractionEnabled = false
                    self.functionTextField.isUserInteractionEnabled = false
                    self.websiteTextField.isUserInteractionEnabled = false
                    self.facebookTextField.isUserInteractionEnabled = false
                    self.twitterTextField.isUserInteractionEnabled = false
                    self.snapchatTextField.isUserInteractionEnabled = false
                    self.instagramTextField.isUserInteractionEnabled = false
                    self.themePickerView.isUserInteractionEnabled = false
                }, onFailure: { error in
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Erreur", message: "Un problème est survenu, veuillez réessayer", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Continuer", style: .cancel))
                        self.present(alertView, animated: true, completion: nil)
                    }
                    print("Request failed with error: \(error)")

                })

            }
        }
    }
}
