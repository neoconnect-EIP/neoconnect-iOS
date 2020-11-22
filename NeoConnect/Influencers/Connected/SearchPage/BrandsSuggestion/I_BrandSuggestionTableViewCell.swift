//
//  I_BrandSuggestionTableViewCell.swift
//  NeoConnect
//
//  Created by EIP on 14/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit

protocol I_BrandSuggestionTableViewCellDelegate {
    func brandSuggestionTapped(brand: I_Brand)
}

class I_BrandSuggestionTableViewCell: UITableViewCell, I_BrandSuggestionCollectionViewCellDelegate {

    @IBOutlet weak var collectionBrandSuggestionView: UICollectionView!
    
    var delegate: I_BrandSuggestionTableViewCellDelegate?
    var brandSuggestions: [I_Brand] = []
    
    func setBrandSuggestions(brands: [I_Brand]) {
        brandSuggestions = brands
        collectionBrandSuggestionView.reloadData()
    }

    func brandSuggestionTapped(brand: I_Brand) {
        delegate?.brandSuggestionTapped(brand: brand)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionBrandSuggestionView.delegate = self
        collectionBrandSuggestionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension I_BrandSuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandSuggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier : "I_BrandSuggestionCollectionViewCell", for: indexPath) as! I_BrandSuggestionCollectionViewCell
        
        cell.delegate = self
        cell.setBrandSuggestion(brand: brandSuggestions[indexPath.row])
        return cell
    }
}
