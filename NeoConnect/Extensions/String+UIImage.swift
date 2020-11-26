//
//  String+UIImage.swift
//  NeoConnect
//
//  Created by EIP on 17/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func toImage() -> UIImage? {
        let imageData = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
}
