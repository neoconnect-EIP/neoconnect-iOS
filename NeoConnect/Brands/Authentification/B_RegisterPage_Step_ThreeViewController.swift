//
//  B_RegisterPage_Step_ThreeViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/11/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_RegisterPage_Step_Three_ViewController: UIViewController {

    struct Login: Encodable {
        let pseudo: String
        let email: String
        let password: String
        let lastName: String
        let firstName: String
        let adress: String
        let zipCode: String
        let phoneNumber: String
        let city: String
        let company: String
        let profession: String
        let subject: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
