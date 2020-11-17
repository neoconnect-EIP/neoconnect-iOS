//
//  I_BrandSuggestionTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_BrandSuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandTitleLabel: UILabel!
    
    func setBrandSuggestion(brands: [I_Brand]) {
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
