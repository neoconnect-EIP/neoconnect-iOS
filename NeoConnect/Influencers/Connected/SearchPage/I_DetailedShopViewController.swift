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

class I_DetailedShopViewController: UIViewController {

    @IBOutlet weak var brandPseudo: UILabel!
    @IBOutlet weak var brandImageView: PhotoFieldImage!
    @IBOutlet weak var brandNbOffers: UILabel!
    @IBOutlet weak var brandNbFollowers: UILabel!
    @IBOutlet weak var brandSubject: UILabel!
    @IBOutlet weak var brandRating: CosmosView!
    @IBOutlet weak var brandDescription: UILabel!
    @IBOutlet weak var followButton: DefaultButton!
    @IBOutlet weak var noteButton: UIButton!
    
    @State private var rating = 0
    var brand: I_Brand!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.noteButton.addTarget(self, action: #selector(I_DetailedShopViewController.noteButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        self.brandPseudo.text = brand.pseudo
        self.brandImageView.image = brand.image
        self.brandNbOffers.text = brand.nbOffers
        self.brandNbFollowers.text = brand.nbFollowers
        self.brandSubject.text = brand.subject
        self.brandRating.rating = brand.rate
        self.brandDescription.text = brand.description
        brand.followed == false ? followButton.setTitle("S'abonner", for: .normal) : followButton.setTitle("Abonné", for: .normal)
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MessageViewInf") {
            let VC = segue.destination as! I_DetailedChatViewController
            
            VC.shop = Shop(id: UserDefaults.standard.integer(forKey: "id"), user_id: brand.id, pseudo: brand.pseudo, image: brand.image)
        }
    }
    
    @IBAction func ratingButtonTapped(_ sender: Any) {
        
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
            AF.request("http://168.63.65.106:8080/shop/follow/\(String(brand.id))", method: .put, headers: headers, interceptor: nil).responseJSON { response in
                switch response.result {
                    case .success(_):
                        print(response)
                    case .failure(let error):
                        print("Request failed withs error: \(error)")
                }
            }
            sender.setTitle("Abonné", for: .normal)
        } else {
            AF.request("http://168.63.65.106:8080/shop/unfollow/\(String(brand.id))", method: .put, headers: headers, interceptor: nil).responseJSON { response in
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
    
    @objc func noteButtonTapped(sender:UIButton) {
        let rateView = NotationUserView(userId: brand.id, rating: rating)
        
        let host = UIHostingController(rootView: rateView)
        navigationController?.pushViewController(host, animated: true)
    }
}
