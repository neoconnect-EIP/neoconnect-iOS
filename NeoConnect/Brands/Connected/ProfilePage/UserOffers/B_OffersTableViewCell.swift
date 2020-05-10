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
    
    var offerItem : Offer!
    
    func setOffers(offer: Offer) {
        offerItem = offer
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.image
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      // Add action to perform when the button is tapped
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
    }
}
