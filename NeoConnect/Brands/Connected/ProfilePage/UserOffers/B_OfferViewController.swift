//
//  B_OfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire
import DLRadioButton

class B_OfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var offerImage: PhotoFieldButton!
    @IBOutlet weak var offerTitleField: UITextField!
    @IBOutlet weak var offerFemaleButton: DLRadioButton!
    @IBOutlet weak var offerMaleButton: DLRadioButton!
    @IBOutlet weak var offerDescriptionField: DefaultTextViews!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var offerColor: DefaultTextFields!
    @IBOutlet weak var editItem: UIBarButtonItem!
    
    
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Food", "High Tech", "Sport/Fitness"]
    var pickerView = UIPickerView()
    var typeValue = "Mode"
    var imagePicker:UIImagePickerController!
    var offer: Offer!
    var offerSex: String!
    var imageConverter = ImageConverter()

    override func viewWillAppear(_ animated: Bool) {
        offerTitleField.text = offer.title
        offerDescriptionField.text = offer.description
        pickerViewButton.setTitle(offer.subject, for: .normal)
        offerImage.setImage(offer.image.withRenderingMode(.alwaysOriginal), for: .normal)

        if (offer.sex == "Male") {
            offerMaleButton.isSelected = true
            offerSex = "Male"
        } else {
            offerFemaleButton.isSelected = true
            offerSex = "Female"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            offerImage.setImage(pickedImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func radioSexButtonTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            offerSex = "Male"
        }
        else if (sender.tag == 2) {
            offerSex = "Female"
        }
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
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let name = offerTitleField.text!
        let desc = offerDescriptionField.text!
        let subject = typeValue
        let image = offerImage.image(for: .normal)
        
        if (self.editItem.title == "Modifier") {
            editItem.title = "Enregistrer"
            offerTitleField.isUserInteractionEnabled = true
            offerFemaleButton.isUserInteractionEnabled = true
            offerMaleButton.isUserInteractionEnabled = true
            offerDescriptionField.isUserInteractionEnabled = true
            pickerViewButton.isUserInteractionEnabled = true
            offerImage.isUserInteractionEnabled = true
        }
        else {
            if (name.isEmpty || desc.isEmpty || subject.isEmpty) {
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                        self.present(alertView, animated: true, completion: nil)
                }
            }
            else {
                let imageData = imageConverter.imageToBase64(image!)!
                
                APIBrandManager.sharedInstance.editOffer(id: offer.id, name: name, imageData: imageData, sex: offerSex!, description: desc, subject: subject, onSuccess: {
                    
                    self.editItem.title = "Enregistrer"
                    self.offerTitleField.isUserInteractionEnabled = false
                    self.offerFemaleButton.isUserInteractionEnabled = false
                    self.offerMaleButton.isUserInteractionEnabled = false
                    self.offerDescriptionField.isUserInteractionEnabled = false
                    self.pickerViewButton.isUserInteractionEnabled = false
                    self.offerImage.isUserInteractionEnabled = false
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Parfait !", message: "Votre offre a été modifié avec succès!", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                        self.present(alertView, animated: true, completion: nil)
                    }
                }, onFailure: { error in
                    
                    print("Request failed with error: \(error)")
                })
            }
        }
    }
}
