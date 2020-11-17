//
//  B_ParametersTableViewController.swift
//  NeoConnect
//
//  Created by EIP on 02/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import SwiftUI
import Alamofire

class B_ParametersTableViewController: UITableViewController {
    @IBOutlet weak var userImageView: PhotoFieldImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        getImageFromApi()
    }
    
    @IBAction func contactUS(_ sender: Any) {
        let contactView = ReportUsShopSideView()
        let host = UIHostingController(rootView: contactView)
        navigationController?.pushViewController(host, animated: true)
    }
    
    @IBAction func deleteAcc(_ sender: Any) {        
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Supprimer mon compte ?", message: "Vous êtes sur le point de supprimer votre compte, êtes vous sûr ?", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Annuler", style: .cancel) { action in
            })
            alertView.addAction(UIAlertAction(title: "Confirmer", style: .default) { action in
                APIManager.sharedInstance.delete()
                let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "B_NavController")
                loginVC.modalPresentationStyle = .fullScreen
                
                self.present(loginVC, animated: true, completion: nil)            })
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func getImageFromApi() {
        DispatchQueue.main.async {
            APIManager.sharedInstance.getUserImage(onSuccess: { image in
                print("SUCCESS")
                self.userImageView.image = image
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
}
