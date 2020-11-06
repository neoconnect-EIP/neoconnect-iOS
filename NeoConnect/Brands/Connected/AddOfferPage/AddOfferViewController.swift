//
//  AddOfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import DLRadioButton

class AddOfferViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstImage: PhotoFieldButton!
    @IBOutlet weak var secondImage: PhotoFieldButton!
    @IBOutlet weak var thirdImage: PhotoFieldButton!
    @IBOutlet weak var forthImage: PhotoFieldButton!
    @IBOutlet weak var fifthImage: PhotoFieldButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var pickerViewButton: UIButton!
    @IBOutlet weak var colorTextField: UITextField!
    
    var flag = 0
    var pickerData = ["Mode", "Cosmétique", "Jeux Vidéo", "Food", "High Tech", "Sport/Fitness"]
    var pickerView = UIPickerView()
    var typeValue = "Mode"
    var imagePicker:UIImagePickerController!
    var imageConverter = ImageConverter()
    
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
            if flag == 1 {
                firstImage.setImage(pickedImage, for: UIControl.State.normal)
            } else if flag == 2 {
                secondImage.setImage(pickedImage, for: UIControl.State.normal)
            } else if flag == 3 {
                thirdImage.setImage(pickedImage, for: UIControl.State.normal)
            } else if flag == 4 {
                forthImage.setImage(pickedImage, for: UIControl.State.normal)
            } else {
                fifthImage.setImage(pickedImage, for: UIControl.State.normal)
            }
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
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let name = nameTextField.text!
        let desc = descTextView.text!
        let theme = typeValue
        let image = firstImage.image(for: .normal)
        let color = colorTextField.text!
        
        if (name.isEmpty || desc.isEmpty || theme.isEmpty || image == nil) {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Error", message: "Tous les champs doivent être complétés", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
        }
        else {
            let imageData = imageConverter.imageToBase64(image!)!
            let brand = UserDefaults.standard.string(forKey: "pseudo")!
            
            APIBrandManager.sharedInstance.addOffer(name: name, description: desc, theme: theme, imageName: "Image", imageData: imageData, color: color, brand: brand, onSuccess: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Ajouté !", message: "Votre offre à été ajouté avec succès.", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                    self.nameTextField.text?.removeAll()
                    self.descTextView.text?.removeAll()
                    self.typeValue = "Mode"
                    let image = UIImage(named: "Photo_Icon.png")
                    self.firstImage.setImage(image, for: .normal)
                }
            }, onFailure: {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Une erreur est survenue.", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
            })
        }
    }
}
