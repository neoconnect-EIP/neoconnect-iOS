//
//  I_OfferSuggestionCollectionViewCell.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 22/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol I_OfferSuggestionCollectionViewCellDelegate {
    func offerSuggestionTapped(offer: I_Offer)
}

class I_OfferSuggestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerSuggestionImage: PhotoFieldImage!
    @IBOutlet weak var offerSuggestionName: UILabel!

    var delegate: I_OfferSuggestionCollectionViewCellDelegate?
    var offer: I_Offer!
    
    @IBAction func offerSuggestionTapped(_ sender: Any) {
        let offer = self.offer!
        delegate?.offerSuggestionTapped(offer: offer)
    }
    
    func setOfferSuggestion(offer: I_Offer) {
        self.offer = offer
        offerSuggestionImage.image = offer.images[0]
        offerSuggestionName.text = offer.title
    }
}
