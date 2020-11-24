//
//  I_UserSponsorshipSecondViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 22/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import StatusAlert

class I_UserSponsorshipSecondViewController: UIViewController {

    @IBOutlet weak var sponsorshipTextField: RegisterFields!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
            self.present(alertView, animated: true, completion: nil)
        }
    }

    @IBAction func validateButtonTapped(_ sender: Any) {
        let code = sponsorshipTextField.text ?? ""
        
        if code.count != 5 {
            showError("Le code doit contenir cinq caractères. Veuillez réessayer")
        } else {
            APIInfManager.sharedInstance.postSponsorshipCode(code: code, onSuccess: {
                let statusAlert = StatusAlert()
                statusAlert.image = UIImage(named: "Success icon.png")
                statusAlert.title = "Code validé !"
                statusAlert.message = "Votre parrain a bien été validé"
                statusAlert.showInKeyWindow()
                self.navigationController?.popViewController(animated: true)
            }, onFailure: {
                self.showError("Le code semble être incorrect, veuillez réessayer.")
            })
        }
    }
}
