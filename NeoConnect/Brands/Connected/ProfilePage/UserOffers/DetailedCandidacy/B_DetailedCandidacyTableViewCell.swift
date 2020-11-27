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

    @IBOutlet weak var infImageView: UIImageView!
    @IBOutlet weak var infPseudoLabel: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var acceptButton: DefaultButton!
    @IBOutlet weak var declineButton: DefaultButton!
    @IBOutlet weak var acceptedButton: DefaultButton!
    
    var idUser: String!
    var idOffer: String!
    
    func setCandidacy(candidacy: Candidacy) {
        infPseudoLabel.text = candidacy.pseudo
        infImageView.image = candidacy.image
        idOffer = String(candidacy.idOffer)
        idUser = String(candidacy.idUser)
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
        guard let idUser = self.idUser else { return }
        guard let idOffer = self.idOffer else { return }

        APIBrandManager.sharedInstance.postOfferChoiceApply(status: sender.tag == 1 ? true : false, idUser: idUser, idOffer: idOffer, onSuccess: {
            self.acceptButton.isHidden = true
            self.declineButton.isHidden = true
            self.acceptedButton.isHidden = false
        })
    }
}
