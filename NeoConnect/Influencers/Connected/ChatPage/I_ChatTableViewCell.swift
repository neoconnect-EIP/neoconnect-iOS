//
//  I_ChatTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 03/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopPseudoLabel: UILabel!
    
    func setConversations(shop: Shop) {
        shopImageView.image = shop.image
        shopPseudoLabel.text = shop.pseudo
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
