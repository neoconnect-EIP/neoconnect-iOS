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
    @IBOutlet weak var offerThemeLabel: UILabel!

    func setOffers(offer: Offer) {
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.image
        offerThemeLabel.text = offer.subject
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
    }
}
