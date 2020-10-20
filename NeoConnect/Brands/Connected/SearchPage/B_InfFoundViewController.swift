//
//  B_InfFoundViewController.swift
//  NeoConnect
//
//  Created by EIP on 02/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import SwiftUI
import UIKit
import Cosmos

class B_InfFoundViewController: UIViewController {

    @IBOutlet weak var infImageView: PhotoFieldImage!
    @IBOutlet weak var infPseudoLabelField: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var subjectLabelField: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    
    @State private var rating = 0
    var userId: Int!
    var userEmail: String!
    var imageView: UIImage!
    var pseudo: String!
    var subject: String!
    var inf: Inf!
    var stars: CosmosView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.noteButton.addTarget(self, action: #selector(B_InfFoundViewController.noteButtonTapped(sender:)), for: .touchUpInside)
//        self.contactButton.addTarget(self, action: #selector(B_InfFoundViewController.contactButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        self.infImageView.image = imageView
        self.infPseudoLabelField.text = pseudo
        self.subjectLabelField.text = subject
        inf = Inf(id: 0, user_id: userId, pseudo: pseudo, image: imageView)
//        self.ratingStars = stars
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MessageViewShop") {
            let VC = segue.destination as! B_DetailedChatViewController
            
            VC.inf = inf
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
