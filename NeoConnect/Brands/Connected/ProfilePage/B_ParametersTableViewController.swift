//
//  B_ParametersTableViewController.swift
//  NeoConnect
//
//  Created by EIP on 02/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_ParametersTableViewController: UITableViewController {
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: "Are you sure ?", message: "You are going to disconnect, are you sure ?", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "No", style: .cancel) { action in
            })
            alertView.addAction(UIAlertAction(title: "Yes", style: .default) { action in
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

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
}
