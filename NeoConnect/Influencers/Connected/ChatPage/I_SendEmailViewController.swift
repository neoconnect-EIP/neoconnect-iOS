//
//  I_SendEmailViewController.swift
//  NeoConnect
//
//  Created by EIP on 22/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import MessageUI

class I_SendEmailViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var objectTextField: UITextField!
    @IBOutlet weak var messageBodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectTextField.delegate = self
        messageBodyTextField.delegate = self
    }
    @IBAction func sendTappedButton(_ sender: Any) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
            
        if let subjectText = objectTextField.text {
            picker.setSubject(subjectText)
        }
        picker.setMessageBody(messageBodyTextField.text, isHTML: true)
            
        present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
         dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        messageBodyTextField.text = textView.text
            
        if text == "\n" {
            textView.resignFirstResponder()
                
            return false
        }
            
        return true
    }
}
