//
//  B_OfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import StatusAlert

class B_OfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var firstImage: PhotoFieldButton!
    @IBOutlet weak var secondImage: PhotoFieldButton!
    @IBOutlet weak var thirdImage: PhotoFieldButton!
    @IBOutlet weak var forthImage: PhotoFieldButton!
    @IBOutlet weak var fifthImage: PhotoFieldButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var subjectPickerViewButton: UIButton!
    @IBOutlet weak var sexPickerViewButton: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var editNameButton: UIImageView!
    
    var flag = 0
    var imageArrayToSend: Array<UIImage> = []
    var subjectData = ["Mode", "Cosmétique", "Jeux Vidéo", "Nourriture", "High tech", "Sport/Fitness"]
    var sexData = ["Unisexe", "Homme", "Femme"]
    var pickerView = UIPickerView()
    var subjectSelected = "Sujet"
    var sexSelected = "Unisexe"
    var imagePicker:UIImagePickerController!
    var offer: B_Offer!

    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = offer.title
        descTextView.text = offer.description
        subjectSelected = offer.subject
        subjectPickerViewButton.setTitle(offer.subject, for: .normal)
        switch offer.sex {
            case "Homme":
                sexPickerViewButton.setTitle("Homme", for: .normal)
            case "Femme":
                sexPickerViewButton.setTitle("Femme", for: .normal)
            default:
                sexPickerViewButton.setTitle("Unisexe", for: .normal)
        }
        firstImage.setTitle(offer.subject, for: .normal)
        for (index, image) in offer.images.enumerated() {
            switch index {
                case 0:
                    firstImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                case 1:
                    secondImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                case 2:
                    thirdImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                case 3:
                    forthImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                default:
                    fifthImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            imageArrayToSend.append(image)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
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
    
    private func initPickerFrame(tag: Int) -> UIAlertController {
        let alert = UIAlertController(title: "Choisissez votre sexe", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        pickerFrame.tag = tag
        alert.view.tintColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        return alert
    }
    
    @IBAction func sexViewButtonTapped(_ sender: Any) {
        let alert = initPickerFrame(tag: 1)
        
        self.sexSelected = "Unisexe"
        alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            self.sexPickerViewButton.setTitle(self.sexSelected, for: .normal)
            print("You selected " + self.sexSelected)
        }))
        self.present(alert,animated: true, completion: nil )
    }
    
    @IBAction func subjectViewButtonTapped(_ sender: Any) {
        let alert = initPickerFrame(tag: 0)
        
        self.subjectSelected = "Mode"
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { (UIAlertAction) in
            if (self.subjectSelected == "Cosmétique" || self.subjectSelected == "Mode") {
                self.sexPickerViewButton.isUserInteractionEnabled = true
                self.sexPickerViewButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.sexPickerViewButton.setTitle("Sexe", for: .normal)
                self.sexPickerViewButton.isUserInteractionEnabled = false
                self.sexPickerViewButton.setTitleColor(UIColor.lightGray, for: .normal)
            }
            self.subjectPickerViewButton.setTitle(self.subjectSelected, for: .normal)
            print("You selected " + self.subjectSelected)
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
    
    func isModifyingOffer(_ image: UIImage, _ bool: Bool) {
        editItem.image = image
        editNameButton.isHidden = !bool
        firstImage.isUserInteractionEnabled = bool
        secondImage.isUserInteractionEnabled = bool
        thirdImage.isUserInteractionEnabled = bool
        forthImage.isUserInteractionEnabled = bool
        fifthImage.isUserInteractionEnabled = bool
        nameTextField.isUserInteractionEnabled = bool
        descTextView.isUserInteractionEnabled = bool
        subjectPickerViewButton.isUserInteractionEnabled = bool
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! B_CandidacyViewController
        
        VC.offer = offer
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard let desc = descTextView.text else { return }
        let subject = subjectSelected
        let sex = sexSelected
        
        if (editItem.tag == 0) {
            editItem.tag = 1
            isModifyingOffer(UIImage(systemName: "checkmark")!, true)
        }
        else {
            if (1 ... 4 ~= desc.count) {
                showError("La description semble trop courte")
            } else if (name.isEmpty || subject == "Sujet" || imageArrayToSend.count == 0) {
                showError("Tous les champs doivent être complétés")
            } else if (subject == "Mode" || subject == "Cosmétique") {
                if (sex == "Sexe") {
                    showError("Veuillez préciser le sexe de l'annonce")
                }
            } else {
                var imageArray: Array<String> = []
                
                for image in imageArrayToSend {
                    imageArray.append(image.toBase64() ?? "")
                }
                APIBrandManager.sharedInstance.editOffer(id: offer.id, name: name, description: desc, subject: subject, sex: sex, imageArray: imageArray, onSuccess: {
                    let statusAlert = StatusAlert()
                    statusAlert.alertShowingDuration = 1
                    statusAlert.image = UIImage(named: "Success icon.png")
                    statusAlert.title = "Offre ajoutée !"
                    statusAlert.message = "Votre offre à été ajouté avec succès"
                    statusAlert.showInKeyWindow()
                    self.editItem.tag = 0
                    self.isModifyingOffer(UIImage(systemName: "pencil")!, true)
                }, onFailure: { error in
                    self.showError("Une erreur est survenue")
                })
            }
        }
    }
}
