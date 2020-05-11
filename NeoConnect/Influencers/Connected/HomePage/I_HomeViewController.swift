//
//  I_HomeViewController.swift
//  NeoConnect
//
//  Created by EIP on 12/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabelField: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabelField.text = "Bienvenue " + UserDefaults.standard.string(forKey: "pseudo")! + " !"
        // Do any additional setup after loading the view.
    }

}
