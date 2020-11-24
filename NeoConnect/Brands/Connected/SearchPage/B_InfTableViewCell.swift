//
//  B_InfTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class B_InfTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infImageView: UIImageView!
    @IBOutlet weak var infPseudoLabel: UILabel!
    
    func initCell(inf: Inf) {
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
