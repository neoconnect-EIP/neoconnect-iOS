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

class B_DetailedInfViewController: UIViewController {

    @IBOutlet weak var infPseudoLabelField: UILabel!
    @IBOutlet weak var infImageView: PhotoFieldImage!
    @IBOutlet weak var infOffersApplied: UILabel!
    @IBOutlet weak var infSubjectLabelField: UILabel!
    @IBOutlet weak var infRating: CosmosView!
    @IBOutlet weak var infDescriptionField: UILabel!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    @State private var rating = 0
    var inf: Inf!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.noteButton.addTarget(self, action: #selector(B_DetailedInfViewController.noteButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        self.infPseudoLabelField.text = inf.pseudo
        self.infImageView.image = inf.image
        self.infOffersApplied.text = inf.offersApplied
        self.infSubjectLabelField.text = inf.subject
        self.infRating.rating = inf.average
        self.infDescriptionField.text = inf.description
        super.viewDidLoad()
    }
    
    @IBAction func ratingButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "B_StatsView", sender: nil)
    }
    
    
    @IBAction func contactButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "MessageViewShop", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MessageViewShop") {
            let VC = segue.destination as! B_DetailedChatViewController
            
            VC.inf = Conversation(id: UserDefaults.standard.integer(forKey: "id"), user_id: inf.id, pseudo: inf.pseudo, image: inf.image)
        } else if (segue.identifier == "B_StatsView") {
            let VC = segue.destination as! B_ShopStatsViewController

            VC.inf = inf
        }
    }
    
    @objc func noteButtonTapped (sender:UIButton) {
        let rateView = NotationUserView(userId: inf.id, rating: rating)
        
        let host = UIHostingController(rootView: rateView)
        navigationController?.pushViewController(host, animated: true)
    }
}
