//
//  ImageConverter.swift
//  NeoConnect
//
//  Created by EIP on 03/03/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class ImageConverter {

    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }

    func imageToBase64(_ image: UIImage) -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.2)?.base64EncodedString() else { return nil }
        return imageData
    }

}
