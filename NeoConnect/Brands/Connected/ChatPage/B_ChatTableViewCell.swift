//
//  B_ChatTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 03/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class B_ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var infImageView: UIImageView!
    @IBOutlet weak var infPseudoLabel: UILabel!
    
    func setConversations(inf: Inf) {
        infImageView.image = inf.image
        infPseudoLabel.text = inf.pseudo
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
