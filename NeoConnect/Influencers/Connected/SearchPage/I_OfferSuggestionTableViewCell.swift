//
//  I_OfferSuggestionTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_OfferSuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    
    func setOfferSuggestion(offers: [I_Offer]) {
        //        offerTitleLabel.text = brand.title
        //        offerImageView.image = brand.images[0]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}