//
//  I_ProfileViewController.swift
//  NeoConnect
//
//  Created by EIP on 12/05/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_ProfileViewController: UIViewController {

    @IBAction func logoutButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Se deconnecter ?", message: "Confirmer", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Non", style: .cancel) { action in
            })
            alertView.addAction(UIAlertAction(title: "Oui", style: .default) { action in
                let storyBoard: UIStoryboard = UIStoryboard(name: "I_Register_and_Connection", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "I_NavController")
                loginVC.modalPresentationStyle = .fullScreen
                
                self.present(loginVC, animated: true, completion: nil)            })
            
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
