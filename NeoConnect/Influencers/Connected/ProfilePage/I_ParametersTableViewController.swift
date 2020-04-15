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
            let alertView = UIAlertController(title: "Are you sure ?", message: "You are going to disconnect, are you sure ?", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "No", style: .cancel) { action in
            })
            alertView.addAction(UIAlertAction(title: "Yes", style: .default) { action in
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
    @IBAction func deleteAcc(_ sender: Any) {
            let token = UserDefaults.standard.string(forKey: "Token")!

            let _headers: HTTPHeaders = [
                   "Authorization": "Bearer " + token            ]

            DispatchQueue.main.async {
                      let alertView = UIAlertController(title: "Etes vous sur ?", message: "Vous êtes sur le point de supprimer votre compte, êtes vous sur ?", preferredStyle: .alert)
                      alertView.addAction(UIAlertAction(title: "Annuler", style: .cancel) { action in
                      })
                      alertView.addAction(UIAlertAction(title: "Confirmer", style: .default) { action in
                        AF.request("http://localhost:8080/delete",
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
