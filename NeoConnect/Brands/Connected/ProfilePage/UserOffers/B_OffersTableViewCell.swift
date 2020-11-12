//
//  B_OffersTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerApplyLabel: UILabel!
    
    func setOffers(offer: Offer) {
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.images[0]
        offer.apply.count > 0 ?
            (offerApplyLabel.text = "\(offer.apply.count) candidature(s)") :
            (offerApplyLabel.text = "Aucune candidature")
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
    }
}
