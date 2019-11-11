//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class I_ProfileViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var givenNameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var btnValidate: UIButton!
    
    @IBOutlet weak var idLabelField: UILabel!
    @IBOutlet weak var emailLabelField: UILabel!
    @IBOutlet weak var nameLabelField: UILabel!
    @IBOutlet weak var givenNameLabelField: UILabel!
    @IBOutlet weak var postcodeLabelField: UILabel!
    @IBOutlet weak var phoneNumberLabelField: UILabel!
    @IBOutlet weak var cityLabelField: UILabel!
    @IBOutlet weak var adressLabelField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnModifyAction(_ sender: UIButton) {
        sender.isHidden = true
        btnValidate.isHidden = false
        idTextField.isHidden = false
        emailTextField.isHidden = false
        nameTextField.isHidden = false
        givenNameTextField.isHidden = false
        adressTextField.isHidden = false
        postcodeTextField.isHidden = false
        cityTextField.isHidden = false
        phoneNumberTextField.isHidden = false
        
        idLabelField.isHidden = true
        emailLabelField.isHidden = true
        nameLabelField.isHidden = true
        givenNameLabelField.isHidden = true
        adressLabelField.isHidden = true
        postcodeLabelField.isHidden = true
        cityLabelField.isHidden = true
        phoneNumberLabelField.isHidden = true
    }
    
    @IBAction func btnValidateTapped(_ sender: Any) {
        idLabelField.text = idTextField.text
        emailLabelField.text = emailTextField.text
        nameLabelField.text = nameTextField.text
        givenNameLabelField.text = givenNameTextField.text
        adressLabelField.text = adressTextField.text
        postcodeLabelField.text = postcodeTextField.text
        cityLabelField.text = cityTextField.text
        phoneNumberLabelField.text = phoneNumberTextField.text
        
        btnValidate.isHidden = true
        idTextField.isHidden = true
        emailTextField.isHidden = true
        nameTextField.isHidden = true
        givenNameTextField.isHidden = true
        adressTextField.isHidden = true
        postcodeTextField.isHidden = true
        cityTextField.isHidden = true
        phoneNumberTextField.isHidden = true
        
        idLabelField.isHidden = false
        emailLabelField.isHidden = false
        nameLabelField.isHidden = false
        givenNameLabelField.isHidden = false
        adressLabelField.isHidden = false
        postcodeLabelField.isHidden = false
        cityLabelField.isHidden = false
        phoneNumberLabelField.isHidden = false
    }
    
}
