//
//  I_ChatViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class I_ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func ContactUser(_ sender: Any) {
             let contactUserView = ContactUserView(emailUser: "")
                            let host = UIHostingController(rootView: contactUserView)
                          navigationController?.pushViewController(host, animated: true)
      }
    
}
