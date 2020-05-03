//
//  Shop.swift
//  NeoConnect
//
//  Created by EIP on 31/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class Shop: NSObject, NSCoding {
    
    var id: Int
    var pseudo: String
    var full_name: String
    var email: String
    var phone: String
    var postal: String
    var city: String
    var imageData: UIImage
    var theme: String
    var society: String
    var function: String
    
    init(id: Int, pseudo: String, full_name: String, email: String, phone: String,
         postal: String, city: String, imageData: UIImage, theme: String, society: String,
         function: String) {
        self.id = id
        self.pseudo = pseudo
        self.full_name = full_name
        self.email = email
        self.phone = phone
        self.postal = postal
        self.city = city
        self.imageData = imageData
        self.theme = theme
        self.society = society
        self.function = function
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let pseudo = aDecoder.decodeObject(forKey: "pseudo") as! String
        let full_name = aDecoder.decodeObject(forKey: "full_name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let postal = aDecoder.decodeObject(forKey: "postal") as! String
        let city = aDecoder.decodeObject(forKey: "city") as! String
        let imageData = aDecoder.decodeObject(forKey: "imageData") as! UIImage
        let theme = aDecoder.decodeObject(forKey: "theme") as! String
        let society = aDecoder.decodeObject(forKey: "society") as! String
        let function = aDecoder.decodeObject(forKey: "function") as! String

        self.init(id: id, pseudo: pseudo, full_name: full_name, email: email,
                  phone: phone, postal: postal, city: city, imageData: imageData, theme: theme,
                  society: society, function: function)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(pseudo, forKey: "pseudo")
        aCoder.encode(full_name, forKey: "full_name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(postal, forKey: "postal")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(imageData, forKey: "imageData")
        aCoder.encode(theme, forKey: "theme")
        aCoder.encode(society, forKey: "society")
        aCoder.encode(function, forKey: "function")
    }
}
