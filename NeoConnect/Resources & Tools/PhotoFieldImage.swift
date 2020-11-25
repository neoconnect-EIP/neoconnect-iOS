//
//  PhotoFieldImage.swift
//  NeoConnect
//
//  Created by EIP on 06/08/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

final class PhotoFieldImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setShadow()
        
        clipsToBounds = true
        self.tag == 0 ? (layer.cornerRadius = frame.height/2) : (layer.cornerRadius = 10)
    }
    
    private func setShadow() {
        layer.shadowOffset  = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
    }
}
