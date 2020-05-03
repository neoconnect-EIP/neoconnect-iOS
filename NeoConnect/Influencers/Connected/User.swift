//
//  User.swift
//  NeoConnect
//
//  Created by EIP on 31/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject, NSCoding {
    
    var id: Int
    var pseudo: String
    var full_name: String
    var email: String
    var phone: String
    var postal: String
    var city: String
    var imageData: UIImage
    var theme: String
    var facebook: String
    var snapchat: String
    var twitter: String
    var instagram: String
    
    init(id: Int, pseudo: String, full_name: String, email: String, phone: String,
         postal: String, city: String, imageData: UIImage, theme: String, facebook: String,
         snapchat: String, twitter: String, instagram: String) {
        self.id = id
        self.pseudo = pseudo
        self.full_name = full_name
        self.email = email
        self.phone = phone
        self.postal = postal
        self.city = city
        self.imageData = imageData
        self.theme = theme
        self.facebook = facebook
        self.snapchat = snapchat
        self.twitter = twitter
        self.instagram = instagram
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
        let facebook = aDecoder.decodeObject(forKey: "facebook") as! String
        let snapchat = aDecoder.decodeObject(forKey: "snapchat") as! String
        let twitter = aDecoder.decodeObject(forKey: "twitter") as! String
        let instagram = aDecoder.decodeObject(forKey: "instagram") as! String

        self.init(id: id, pseudo: pseudo, full_name: full_name, email: email,
                  phone: phone, postal: postal, city: city, imageData: imageData, theme: theme,
                  facebook: facebook, snapchat: snapchat, twitter: twitter, instagram: instagram)
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
        aCoder.encode(facebook, forKey: "facebook")
        aCoder.encode(snapchat, forKey: "snapchat")
        aCoder.encode(twitter, forKey: "twitter")
        aCoder.encode(instagram, forKey: "instagram")
    }
}
