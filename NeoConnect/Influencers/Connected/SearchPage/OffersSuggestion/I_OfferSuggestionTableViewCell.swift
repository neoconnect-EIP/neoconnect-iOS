//
//  I_OfferSuggestionTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol I_OfferSuggestionTableViewCellDelegate {
    func offerSuggestionTapped(offer: I_Offer)
}

class I_OfferSuggestionTableViewCell: UITableViewCell, I_OfferSuggestionCollectionViewCellDelegate {

    @IBOutlet weak var collectionOfferSuggestionView: UICollectionView!
    
    var delegate: I_OfferSuggestionTableViewCellDelegate?
    var offerSuggestions: [I_Offer] = []
    
    func setOfferSuggestions(offers: [I_Offer]) {
        offerSuggestions = offers
        collectionOfferSuggestionView.reloadData()
    }

    func offerSuggestionTapped(offer: I_Offer) {
        delegate?.offerSuggestionTapped(offer: offer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionOfferSuggestionView.delegate = self
        collectionOfferSuggestionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension I_OfferSuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerSuggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier : "I_OfferSuggestionCollectionViewCell", for: indexPath) as! I_OfferSuggestionCollectionViewCell
        
        cell.delegate = self
        cell.setOfferSuggestion(offer: offerSuggestions[indexPath.row])
        return cell
    }
}
