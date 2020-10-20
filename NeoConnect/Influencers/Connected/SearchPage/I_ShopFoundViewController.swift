//
//  I_shopFoundViewController.swift
//  NeoConnect
//
//  Created by EIP on 02/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import Alamofire
import UIKit
import Cosmos

class I_ShopFoundViewController: UIViewController {

    @IBOutlet weak var infImageView: PhotoFieldImage!
    @IBOutlet weak var infPseudoLabelField: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var subjectLabelField: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var followButton: DefaultButton!
    
    @State private var rating = 0
    var userId: Int!
    var userEmail: String!
    var imageView: UIImage!
    var pseudo: String!
    var subject: String!
    var stars: CosmosView!
    var shop: Shop!
    var followed: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.noteButton.addTarget(self, action: #selector(I_ShopFoundViewController.noteButtonTapped(sender:)), for: .touchUpInside)
//        self.contactButton.addTarget(self, action: #selector(I_ShopFoundViewController.contactButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        self.infImageView.image = imageView
        self.infPseudoLabelField.text = pseudo
        self.subjectLabelField.text = subject
        if self.followed == false {
            followButton.setTitle("S'abonner", for: .normal)
        } else {
            followButton.setTitle("Abonné", for: .normal)
        }
        shop = Shop(id: 0, user_id: userId, pseudo: pseudo, image: imageView)
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MessageViewInf") {
            let VC = segue.destination as! I_DetailedChatViewController
            
            VC.shop = shop
        }
    }
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "MessageViewInf", sender: nil)
    }
    
    @IBAction func followButtonTapped(_ sender: DefaultButton) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        if sender.titleLabel?.text == "S'abonner" {
            AF.request("http://168.63.65.106:8080/shop/follow/\(String(self.userId))", method: .put, headers: headers, interceptor: nil).responseJSON { response in
                switch response.result {
                    case .success(_):
                        print(response)
                    case .failure(let error):
                        print("Request failed withs error: \(error)")
                }
            }
            sender.setTitle("Abonné", for: .normal)
        } else {
            AF.request("http://168.63.65.106:8080/shop/unfollow/\(String(self.userId))", method: .put, headers: headers, interceptor: nil).responseJSON { response in
                switch response.result {
                    case .success(_):
                        print(response)
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                }
            }
            sender.setTitle("S'abonner", for: .normal)
        }
    }
    
    @objc func noteButtonTapped (sender:UIButton) {
        let rateView = NotationUserView(userId: userId, rating: rating)
        
        let host = UIHostingController(rootView: rateView)
        navigationController?.pushViewController(host, animated: true)
    }
    
//    @objc func contactButtonTapped (sender:UIButton) {
//        let contactView = ContactUserView(emailUser: userEmail)
//
//        let host = UIHostingController(rootView: contactView)
//        navigationController?.pushViewController(host, animated: true)
//    }
}
