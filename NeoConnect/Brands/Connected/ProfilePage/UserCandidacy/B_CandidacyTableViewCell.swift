//
//  B_CandidacyTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_CandidacyTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    
    func setOffer(offer: Offer) {
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
