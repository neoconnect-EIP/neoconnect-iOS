//
//  I_BrandSuggestionCollectionViewCell.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 22/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol I_BrandSuggestionCollectionViewCellDelegate {
    func brandSuggestionTapped(brand: I_Brand)
}

class I_BrandSuggestionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandSuggestionImage: PhotoFieldImage!
    @IBOutlet weak var brandSuggestionName: UILabel!

    var delegate: I_BrandSuggestionCollectionViewCellDelegate?
    var brand: I_Brand!
    
    @IBAction func brandSuggestionTapped(_ sender: Any) {
        let brand = self.brand!
        delegate?.brandSuggestionTapped(brand: brand)
    }
    
    func setBrandSuggestion(brand: I_Brand) {
        self.brand = brand
        brandSuggestionImage.image = brand.image
        brandSuggestionName.text = brand.pseudo
    }
}
