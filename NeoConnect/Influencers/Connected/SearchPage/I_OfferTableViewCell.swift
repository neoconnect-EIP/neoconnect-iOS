//
//  I_OfferTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol I_OfferTableViewCellDelegate {
    func offerTapped(offer: I_Offer)
}

class I_OfferTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerSubjectLabel: UILabel!

    var delegate: I_OfferTableViewCellDelegate?
    var offer: I_Offer!

    func setOffer(offer: I_Offer) {
        self.offer = offer
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.images[0]
        offerSubjectLabel.text = offer.subject
    }
    
    @IBAction func offerTapped(_ sender: Any) {
        delegate?.offerTapped(offer: offer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
