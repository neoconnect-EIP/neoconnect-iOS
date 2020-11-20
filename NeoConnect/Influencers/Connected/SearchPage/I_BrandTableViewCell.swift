//
//  I_BrandTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

class I_BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var brandTitleLabel: UILabel!
    
    func setBrands(brand: I_Brand) {
        brandTitleLabel.text = brand.pseudo
        brandImageView.image = brand.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
