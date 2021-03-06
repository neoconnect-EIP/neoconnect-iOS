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
    @IBOutlet weak var userImageView: PhotoFieldImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageFromApi()
    }
    
    @IBAction func contactUS(_ sender: Any) {
        let contactView = ReportUsView()
        let host = UIHostingController(rootView: contactView)
        navigationController?.pushViewController(host, animated: true)
    }
    
    @IBAction func myOffers(_ sender: Any) {
        let myoffersView = MyOffersInfSideView()
        let host = UIHostingController(rootView: myoffersView)
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
