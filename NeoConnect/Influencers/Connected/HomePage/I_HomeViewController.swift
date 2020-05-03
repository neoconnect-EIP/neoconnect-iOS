//
//  I_HomeViewController.swift
//  NeoConnect
//
//  Created by EIP on 29/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class I_HomeViewController: UIViewController {
       
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.removeSpinner()
    }
    
    @IBAction func offersButton(_ sender: UIButton) {
           let offersView = OffersView()
                                        let host = UIHostingController(rootView: offersView)
        host.navigationController?.setNavigationBarHidden(true, animated: true)
                                show(host, sender: true)         /*navigationController?.pushViewController(host, animated: true)*/
       }
}
