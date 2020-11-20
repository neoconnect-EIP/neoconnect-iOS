//
//  B_ChatViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class B_ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFriendLabelText: UILabel!
    var infs: [Conversation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        getDataFromAPI()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    
    func getDataFromAPI() {
        APIManager.sharedInstance.getConversations(onSuccess: { JSON in
            DispatchQueue.main.async {
                if JSON.count > 0 {
                    self.noFriendLabelText.isHidden = true
                    self.infs = self.createArray(results: JSON)
                } else {
                    self.tableView.isHidden = true
                    self.noFriendLabelText.isHidden = false
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func createArray(results: Array<NSDictionary>) -> [Conversation] {
        var tempInf: [Conversation] = []
        
        for dictionary in results {
            guard let id = dictionary["id"] as? Int else { return tempInf }
            guard var user_id = dictionary["user_1"] as? String else { return tempInf }
            if Int(user_id) == UserDefaults.standard.integer(forKey: "id") {
                user_id = dictionary["user_2"] as! String
            }
            guard let pseudo = dictionary["pseudo"] as? String else { return tempInf }
            guard let productImg = dictionary["userPicture"] as? NSArray else { return tempInf }
            guard let imageDict = productImg[0] as? NSDictionary else { return tempInf }
            guard let imageData = imageDict["imageData"] as? String else { return  tempInf }
            guard let imageUrl = URL(string: imageData) else { return tempInf }
            guard let image = try! UIImage(data: Data(contentsOf: imageUrl)) else { return tempInf }
            tempInf.append(Conversation(id: id, user_id: Int(user_id)!, pseudo: pseudo, image: image))
        }
        return tempInf
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        let inf = self.infs[row!]
        let VC = segue.destination as! B_DetailedChatViewController
        
        VC.inf = inf
    }
    
    @IBAction func ContactUser(_ sender: Any) {
        let contactUserView = ContactUserView(emailUser: "")
        let host = UIHostingController(rootView: contactUserView)
        navigationController?.pushViewController(host, animated: true)
    }
}

extension B_ChatViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if infs.count == 0 {
            self.noFriendLabelText.isHidden = false
        }
        return infs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inf = infs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "B_ChatTableViewCell") as! B_ChatTableViewCell
        
        cell.setConversations(inf: inf)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
