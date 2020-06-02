//
//  I_ParametersTableViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import SwiftUI
import Alamofire

class I_ParametersTableViewController: UITableViewController {

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
    @IBAction func contactUS(_ sender: Any) {
            let contactView = ContactView()
                           let host = UIHostingController(rootView: contactView)
                         navigationController?.pushViewController(host, animated: true)
    }
    @IBAction func myOffers(_ sender: Any) {
          let myoffersView = MyOffersView()
                                             let host = UIHostingController(rootView: myoffersView)
                                           navigationController?.pushViewController(host, animated: true)
     }
    
    @IBAction func deleteAcc(_ sender: Any) {
            let token = UserDefaults.standard.string(forKey: "Token")!

            let _headers: HTTPHeaders = [
                   "Authorization": "Bearer " + token            ]

            DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "Supprimer mon compte ?", message: "Vous êtes sur le point de supprimer votre compte, êtes vous sûr ?", preferredStyle: .alert)
                      alertView.addAction(UIAlertAction(title: "Annuler", style: .cancel) { action in
                      })
                      alertView.addAction(UIAlertAction(title: "Confirmer", style: .default) { action in
                        AF.request("http://168.63.65.106/delete",
                                         method: .delete,
                                         encoding: URLEncoding.default,headers:_headers).response { response in
                                  debugPrint(response)
                              }
                          let storyBoard: UIStoryboard = UIStoryboard(name: "B_Register_and_Connection", bundle: nil)
                          let loginVC = storyBoard.instantiateViewController(withIdentifier: "B_NavController")
                          loginVC.modalPresentationStyle = .fullScreen
                          
                          self.present(loginVC, animated: true, completion: nil)            })

                      self.present(alertView, animated: true, completion: nil)
                  }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

}
