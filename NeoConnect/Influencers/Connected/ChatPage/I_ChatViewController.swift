//
//  I_ChatViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class I_ChatViewController: UIViewController {

    @IBOutlet weak var noShopLabelText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var shops: [Shop] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
                    self.noShopLabelText.isHidden = true
                    self.shops = self.createArray(results: JSON)
                } else {
                    self.tableView.isHidden = true
                    self.noShopLabelText.isHidden = false
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func createArray(results: Array<NSDictionary>) -> [Shop] {
        var tempShop: [Shop] = []
        
        for dictionary in results {
            var image: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = dictionary["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let tempImage = try! UIImage(data: Data(contentsOf: imageData)) {
                            image = tempImage
                        }
                    }
                }
            }
            let id = dictionary["id"] as! Int
            var user_id = dictionary["user_1"] as! String
            if Int(user_id) == UserDefaults.standard.integer(forKey: "id") {
                user_id = dictionary["user_2"] as! String
            }
            let pseudo = dictionary["pseudo"] as! String
            tempShop.append(Shop(id: id, user_id: Int(user_id)!, pseudo: pseudo, image: image))
        }
        return tempShop
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        let shop = self.shops[row!]
        let VC = segue.destination as! I_DetailedChatViewController
        
        VC.shop = shop
        VC.shopImage = shop.image
    }
    
    @IBAction func ContactUser(_ sender: Any) {
             let contactUserView = ContactUserView(emailUser: "")
                            let host = UIHostingController(rootView: contactUserView)
                          navigationController?.pushViewController(host, animated: true)
      }
}

extension I_ChatViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shops.count == 0 {
            self.noShopLabelText.isHidden = false
        }
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shop = shops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "I_ChatTableViewCell") as! I_ChatTableViewCell
        
        cell.setConversations(shop: shop)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
