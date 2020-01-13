//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire

class I_ProfileViewController: UIViewController {

    struct Info: Encodable {
        let pseudo: String
        let full_name: String
        let email: String
        let phone: String
        let postal: String
        let city: String
        let theme: String
        let facebook: String
        let snapchat: String
        let twitter: String
        let instagram: String
    }

    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var facebookTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var snapchatTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
        
        @IBAction func editButtonTapped(_ sender: Any) {
            validateButton.isHidden = false
            editButton.isHidden = true
            pseudoTextField.isUserInteractionEnabled = true;
            emailTextField.isUserInteractionEnabled = true;
            fullnameTextField.isUserInteractionEnabled = true;
            zipcodeTextField.isUserInteractionEnabled = true;
            cityTextField.isUserInteractionEnabled = true;
            phoneTextField.isUserInteractionEnabled = true;
            facebookTextField.isUserInteractionEnabled = true;
            twitterTextField.isUserInteractionEnabled = true;
            snapchatTextField.isUserInteractionEnabled = true;
            instagramTextField.isUserInteractionEnabled = true;
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
                "phone": phoneTextField.text!,
                "postal": zipcodeTextField.text!,
                "city": cityTextField.text!,
                "theme": subjectTextField.text!,
                "facebook": facebookTextField.text!,
                "snapchat": snapchatTextField.text!,
                "twitter": twitterTextField.text!,
                "instagram": instagramTextField.text!
            ]
            validateButton.isHidden = true
            editButton.isHidden = false
            pseudoTextField.isUserInteractionEnabled = false;
            emailTextField.isUserInteractionEnabled = false;
            fullnameTextField.isUserInteractionEnabled = false;
            zipcodeTextField.isUserInteractionEnabled = false;
            cityTextField.isUserInteractionEnabled = false;
            phoneTextField.isUserInteractionEnabled = false;
            facebookTextField.isUserInteractionEnabled = false;
            twitterTextField.isUserInteractionEnabled = false;
            snapchatTextField.isUserInteractionEnabled = false;
            instagramTextField.isUserInteractionEnabled = false;
            subjectTextField.isUserInteractionEnabled = false;
            
            AF.request("http://168.63.65.106/inf/me", method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
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
            AF.request("http://168.63.65.106/inf/me",
                       headers: headers).responseJSON { response in
                        switch response.result {
                            case .success(let JSON):
                                // SUCCESS

                                let response = JSON as! NSDictionary
                                let info = Info.init(pseudo: response.object(forKey: "pseudo")! as! String, full_name: response.object(forKey: "full_name")! as! String, email: response.object(forKey: "email")! as! String, phone: response.object(forKey: "phone")! as! String, postal: response.object(forKey: "postal")! as! String, city: response.object(forKey: "city")! as! String, theme: response.object(forKey: "theme")! as! String, facebook: response.object(forKey: "facebook")! as! String, snapchat: response.object(forKey: "snapchat")! as! String, twitter: response.object(forKey: "twitter")! as! String, instagram: response.object(forKey: "instagram")! as! String)
                                self.pseudoTextField.text = info.pseudo
                                self.emailTextField.text = info.email
                                self.fullnameTextField.text = info.full_name
                                self.zipcodeTextField.text = info.postal
                                self.cityTextField.text = info.city
                                self.phoneTextField.text = info.phone
                                self.facebookTextField.text = info.facebook
                                self.twitterTextField.text = info.facebook
                                self.instagramTextField.text = info.facebook
                                self.snapchatTextField.text = info.snapchat
                                self.subjectTextField.text = info.theme
      
                            case .failure(let error):
                                    print("Request failed with error: \(error)")
                        }
            }
            super.viewDidLoad()
        }
    }
