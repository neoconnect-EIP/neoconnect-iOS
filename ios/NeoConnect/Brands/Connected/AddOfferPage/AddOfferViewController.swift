//
//  AddOfferViewController.swift
//  NeoConnect
//
//  Created by EIP on 04/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import DLRadioButton

class AddOfferViewController: UIViewController {
    
    @IBOutlet weak var OfferImageImageView: UIImageView!
    @IBOutlet weak var OfferNameTextField: UITextField!
    @IBOutlet weak var DescriptionOfferTextField: UITextView!
    @IBOutlet weak var ThemeTextField: UITextField!
    @IBOutlet weak var radioSexBtn: DLRadioButton!
    
    var Sex = String()

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    @IBAction func radioBtnTapped(_ sender: DLRadioButton) {
        if (sender.tag == 1) {
            Sex = "Male"
            print(Sex)
        }
        else if (sender.tag == 2) {
            Sex = "Female"
            print(Sex)
        }
    }
}
