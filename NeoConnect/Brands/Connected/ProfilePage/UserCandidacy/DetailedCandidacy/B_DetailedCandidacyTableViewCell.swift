//
//  B_DetailedCandidacyTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire

class B_DetailedCandidacyTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var acceptButton: DefaultButton!
    @IBOutlet weak var declineButton: DefaultButton!
    @IBOutlet weak var acceptedButton: DefaultButton!
    
    var idUser: String!
    var idOffer: String!
    
    func setCandidacy(candidacy: Candidacy) {
        offerTitleLabel.text = candidacy.pseudo
        offerImageView.image = candidacy.image
        self.idOffer = String(candidacy.idOffer)
        self.idUser = String(candidacy.idUser)
        ratingStars.rating = candidacy.average
        if candidacy.status != "pending" {
            acceptButton.isHidden = true
            declineButton.isHidden = true
            if candidacy.status == "accepted" {
                acceptedButton.setTitle("Accepté", for: .normal)
                acceptedButton.backgroundColor = UIColor(red: 135/255, green: 185/255, blue: 124/255, alpha: 1.0)
            } else {
                acceptedButton.setTitle("Refusé", for: .normal)
                acceptedButton.backgroundColor = UIColor(red: 0.45, green: 0.27, blue: 0.27, alpha: 1.00)
            }
            acceptedButton.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonTapped(_ sender: DefaultButton) {
        let idUser = self.idUser!
        let idOffer = self.idOffer!

        print("idUser : \(idUser)")
        print("idOffer : \(idOffer)")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/json"
        ]
        let param: [String: Any] = [
            "idUser": idUser,
            "idOffer": idOffer,
            "status": sender.tag == 1 ? true : false
        ]
        
        AF.request("http://168.63.65.106:8080/offer/choiceApply", method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
            
            switch response.result {
                case .success(_):
                    self.acceptButton.isHidden = true
                    self.declineButton.isHidden = true
                    self.acceptedButton.isHidden = false
                    print(response)
                    // Inscription réussie
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    // /!\ Inscription ratée
            }
        }
    }
}
