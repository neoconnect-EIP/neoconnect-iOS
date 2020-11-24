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
    
    func getImageFromApi() {
        DispatchQueue.main.async {
            APIManager.sharedInstance.getUserImage(onSuccess: { image in
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
