//
//  I_OfferTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_OfferTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerSubjectLabel: UILabel!

    func setOffers(offer: I_Offer) {
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.images[0]
        offerSubjectLabel.text = offer.subject
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
