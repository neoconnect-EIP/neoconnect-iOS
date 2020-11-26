//
//  UIImage+Base64.swift
//  NeoConnect
//
//  Created by EIP on 17/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func toBase64() -> String? {
        return self.jpegData(compressionQuality: 0.1)?.base64EncodedString() ?? ""
    }
    
}
