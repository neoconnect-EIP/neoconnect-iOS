//
//  AddOfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import StatusAlert

class AddOfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstImage: PhotoFieldButton!
    @IBOutlet weak var secondImage: PhotoFieldButton!
    @IBOutlet weak var thirdImage: PhotoFieldButton!
    @IBOutlet weak var forthImage: PhotoFieldButton!
    @IBOutlet weak var fifthImage: PhotoFieldButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var subjectPickerViewButton: UIButton!
    @IBOutlet weak var sexPickerViewButton: UIButton!
    
    var flag = 0
    var imageArrayToSend: Array<UIImage> = []
    var subjectData = ["Mode", "Cosmétique", "Jeux Vidéo", "Nourriture", "High tech", "Sport/Fitness"]
    var sexData = ["Unisexe", "Homme", "Femme"]
    var pickerView = UIPickerView()
    var subjectSelected = "Sujet"
    var sexSelected = "Sexe"
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstImageTapped(_ sender: UIButton) {
        flag = 1
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = .photoLibrary
        
        self.present(image, animated: true)
    }
    
    @IBAction func secondImageTapped(_ sender: UIButton) {
        flag = 2
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = .photoLibrary
        
        self.present(image, animated: true)
    }
    
    @IBAction func thirdImageTapped(_ sender: UIButton) {
        flag = 3
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = .photoLibrary
        
        self.present(image, animated: true)
    }
    
    @IBAction func forthImageTapped(_ sender: UIButton) {
        flag = 4
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = .photoLibrary
        
        self.present(image, animated: true)
    }
    
    @IBAction func fifthImageTapped(_ sender: UIButton) {
        flag = 5
        let image = UIImagePickerController()
        image.delegate = self
        
        image.allowsEditing = false
        image.sourceType = .photoLibrary
        
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            switch flag {
            case 1:
                firstImage.setImage(pickedImage, for: UIControl.State.normal)
            case 2:
                secondImage.setImage(pickedImage, for: UIControl.State.normal)
            case 3:
                thirdImage.setImage(pickedImage, for: UIControl.State.normal)
            case 4:
                forthImage.setImage(pickedImage, for: UIControl.State.normal)
            default:
                fifthImage.setImage(pickedImage, for: UIControl.State.normal)
            }
            self.imageArrayToSend.append(pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.subviews.forEach({
            $0.isHidden = $0.frame.height < 1.0
        })
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return sexData.count
        }
        return subjectData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerView.tag)
        if pickerView.tag == 1 {
            return sexData[row]
        }
        return subjectData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerView.tag)
        if pickerView.tag == 1 {
            switch row {
            case 1:
                sexSelected = "Homme"
            case 2:
                sexSelected = "Femme"
            default:
                sexSelected = "Unisexe"
            }
        } else {
            switch row {
            case 1:
                subjectSelected = "Cosmétique"
            case 2:
                subjectSelected = "Jeux Vidéo"
            case 3:
                subjectSelected = "Nourriture"
            case 4:
                subjectSelected = "High tech"
            case 5:
                subjectSelected = "Sport/Fitness"
            default:
                subjectSelected = "Mode"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var subjectPickerLabel: UILabel? = (view as? UILabel)
        if subjectPickerLabel == nil {
            subjectPickerLabel = UILabel()
            subjectPickerLabel?.font = UIFont(name: "Raleway-Medium", size: 17)
            subjectPickerLabel?.textAlignment = .center
        }
        
        subjectPickerLabel?.text = subjectData[row]
        if pickerView.tag == 1 {
            subjectPickerLabel?.text = sexData[row]
        }
        subjectPickerLabel?.textColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        
        return subjectPickerLabel!

    }
    
    private func initPickerFrame(tag: Int, _ message: String) -> UIAlertController {
        let alert = UIAlertController(title: message, message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerFrame.tag = tag
        alert.view.tintColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        return alert
    }
    
    @IBAction func sexViewButtonTapped(_ sender: Any) {
        let alert = initPickerFrame(tag: 1, "Choisissez votre sexe")
        
        alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            if self.sexSelected == "Sexe" {
                self.sexSelected = "Unisexe"
            }
            self.sexPickerViewButton.setTitle(self.sexSelected, for: .normal)
            print("You selected " + self.sexSelected)
            
        }))
        self.present(alert,animated: true, completion: nil )
    }

    @IBAction func subjectViewButtonTapped(_ sender: Any) {
        let alert = initPickerFrame(tag: 0, "Choisissez une sujet")
        
        alert.addAction(UIAlertAction(title: "Femer", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            if self.subjectSelected == "Sujet" {
                self.subjectSelected = "Mode"
            }
            if (self.subjectSelected == "Cosmétique" || self.subjectSelected == "Mode") {
                self.sexPickerViewButton.isUserInteractionEnabled = true
                self.sexPickerViewButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.sexPickerViewButton.setTitle("Sexe", for: .normal)
                self.sexSelected = "Sexe"
                self.sexPickerViewButton.isUserInteractionEnabled = false
                self.sexPickerViewButton.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.subjectPickerViewButton.setTitle(self.subjectSelected, for: .normal)
            print("You selected " + self.subjectSelected)
            
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    func resetView() {
        self.nameTextField.text?.removeAll()
        self.descTextView.text?.removeAll()
        self.subjectSelected = "Sujet"
        self.sexSelected = "Sexe"
        let image = UIImage(named: "placeholder-image.png")

        self.firstImage.setImage(image, for: .normal)
        self.secondImage.setImage(image, for: .normal)
        self.thirdImage.setImage(image, for: .normal)
        self.forthImage.setImage(image, for: .normal)
        self.fifthImage.setImage(image, for: .normal)
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let desc = descTextView.text else { return }
        let subject = subjectSelected
        let sex = sexSelected
        
        if (1 ... 4 ~= desc.count) {
            showError("La description semble trop courte")
            return
        } else if (name.isEmpty || subject == "Sujet" || imageArrayToSend.count == 0) {
            showError("Tous les champs doivent être complétés")
            return
        } else if (subject == "Mode" || subject == "Cosmétique") {
            if (sex == "Sexe") {
                showError("Veuillez préciser le sexe de l'annonce")
                return
            }
        }
        var imageArray: Array<String> = []
        
        for image in imageArrayToSend {
            imageArray.append(image.toBase64() ?? "")

        }
        APIBrandManager.sharedInstance.addOffer(name: name, description: desc, subject: subject, sex: sex, imageArray: imageArray, onSuccess: {
            let statusAlert = StatusAlert()
            statusAlert.alertShowingDuration = 1
            statusAlert.image = UIImage(named: "Success icon.png")
            statusAlert.title = "Offre ajoutée !"
            statusAlert.message = "Votre offre à été ajouté avec succès"
            statusAlert.showInKeyWindow()
            self.resetView()
        }, onFailure: {
            self.showError("Une erreur est survenue")
        })
    }
}
