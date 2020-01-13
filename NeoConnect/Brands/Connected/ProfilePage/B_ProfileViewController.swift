//
//  B_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_ProfileViewController: UIViewController {

    struct Info: Encodable {
        let pseudo: String
        let full_name: String
        let email: String
        let phone: String
        let postal: String
        let city: String
        let theme: String
        let society: String
        let function: String
    }
    
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var societyTextField: UITextField!
    @IBOutlet weak var functionTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBAction func editButtonTapped(_ sender: Any) {
        validateButton.isHidden = false
        editButton.isHidden = true
        pseudoTextField.isUserInteractionEnabled = true;
        emailTextField.isUserInteractionEnabled = true;
        fullnameTextField.isUserInteractionEnabled = true;
        zipcodeTextField.isUserInteractionEnabled = true;
        cityTextField.isUserInteractionEnabled = true;
        phonenumberTextField.isUserInteractionEnabled = true;
        societyTextField.isUserInteractionEnabled = true;
        functionTextField.isUserInteractionEnabled = true;
        subjectTextField.isUserInteractionEnabled = true;
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let new_Info: Parameters = [
            "pseudo": pseudoTextField.text!,
            "full_name": fullnameTextField.text!,
            "email": emailTextField.text!,
            "phone": phonenumberTextField.text!,
            "postal": zipcodeTextField.text!,
            "city": cityTextField.text!,
            "theme": subjectTextField.text!,
            "society": societyTextField.text!,
            "function": functionTextField.text!
        ]
        validateButton.isHidden = true
        editButton.isHidden = false
        pseudoTextField.isUserInteractionEnabled = false;
        emailTextField.isUserInteractionEnabled = false;
        fullnameTextField.isUserInteractionEnabled = false;
        zipcodeTextField.isUserInteractionEnabled = false;
        cityTextField.isUserInteractionEnabled = false;
        phonenumberTextField.isUserInteractionEnabled = false;
        societyTextField.isUserInteractionEnabled = false;
        functionTextField.isUserInteractionEnabled = false;
        subjectTextField.isUserInteractionEnabled = false;
        
        AF.request("http://168.63.65.106/shop/me", method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                print("\(String(describing: response.result))")
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        validateButton.isHidden = true
        AF.request("http://168.63.65.106/shop/me",
                   headers: headers).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
                            // SUCCESS

                            let response = JSON as! NSDictionary
                            let info = Info.init(pseudo: response.object(forKey: "pseudo")! as! String, full_name: response.object(forKey: "full_name")! as! String, email: response.object(forKey: "email")! as! String, phone: response.object(forKey: "phone")! as! String, postal: response.object(forKey: "postal")! as! String, city: response.object(forKey: "city")! as! String, theme: response.object(forKey: "theme")! as! String, society: response.object(forKey: "society")! as! String, function: response.object(forKey: "function")! as! String)
                            self.pseudoTextField.text = info.pseudo
                            self.emailTextField.text = info.email
                            self.fullnameTextField.text = info.full_name
                            self.zipcodeTextField.text = info.postal
                            self.cityTextField.text = info.city
                            self.phonenumberTextField.text = info.phone
                            self.societyTextField.text = info.society
                            self.functionTextField.text = info.function
                            self.subjectTextField.text = info.theme
  
                        case .failure(let error):
                                print("Request failed with error: \(error)")
                    }
        }
        super.viewDidLoad()
    }
}
