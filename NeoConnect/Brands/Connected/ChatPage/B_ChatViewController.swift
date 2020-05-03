//
//  B_ChatViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class B_ChatViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func ContactUser(_ sender: Any) {
           let contactUserView = ContactUserView()
                          let host = UIHostingController(rootView: contactUserView)
                        navigationController?.pushViewController(host, animated: true)
    }
}
