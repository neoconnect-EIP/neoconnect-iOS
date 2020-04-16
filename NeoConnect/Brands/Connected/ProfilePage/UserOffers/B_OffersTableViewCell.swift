//
//  B_OffersTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol B_OffersTableViewCellDelegate: AnyObject {
    
    func nextPageButtonTapped(id: Int, title: String, image: UIImage, sex: String, desc: String, subject: String)
    func deleteButtonTapped(offer: Offer)
}

class B_OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var detailedPageButton: UIButton!
    
    var offerItem : Offer!
    weak var delegate : B_OffersTableViewCellDelegate?

    
    func setOffers(offer: Offer) {
        offerItem = offer
        offerTitleLabel.text = offer.title
        offerImageView.image = offer.image
    }
    
    override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      // Add action to perform when the button is tapped
      self.detailedPageButton.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
      self.detailedPageButton.addTarget(self, action: #selector(deleteOffer(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
    }

    @IBAction func deleteOffer(_ sender: Any) {
        delegate?.deleteButtonTapped(offer: offerItem)
    }
    @IBAction func nextPage(_ sender: Any) {
        delegate?.nextPageButtonTapped(id: offerItem.id, title: offerItem.title, image : offerItem.image, sex: offerItem.sex, desc: offerItem.description, subject: offerItem.subject)
    }
}
