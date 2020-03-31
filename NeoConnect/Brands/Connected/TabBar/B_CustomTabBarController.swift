//
//  B_CustomTabBarViewController.swift
//  NeoConnect
//
//  Created by EIP on 31/01/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106/shop/me",
                   headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                        
                            self.showSpinner(onView: self.view)
                            
                            let response = JSON as! NSDictionary
                            print(response)
                            let imageConvert = ImageConverter()
                            let id : Int = UserDefaults.standard.integer(forKey: "id")
                            let imageArray = response.object(forKey: "userPicture")! as! [[String:Any]]
                            var imageData = #imageLiteral(resourceName: "noImage")
                            if (imageArray.count > 0) {
                                imageData = imageConvert.base64ToImage(imageArray[0]["imageData"] as! String)!
                            }
                            let shop = Shop(id: id, pseudo: response.object(forKey: "pseudo")! as! String, full_name: response.object(forKey: "full_name")! as! String, email: response.object(forKey: "email")! as! String, phone: response.object(forKey: "phone")! as! String, postal: response.object(forKey: "postal")! as! String, city: response.object(forKey: "city")! as! String, imageData: imageData, theme: response.object(forKey: "theme")! as! String, society: response.object(forKey: "society")! as! String, function: response.object(forKey: "function")! as! String)
                            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: shop)
                            
                            UserDefaults.standard.set(encodedData, forKey: "Shop")
                            UserDefaults.standard.synchronize()

                            self.removeSpinner()
                        case .failure(let error):
                                print("Request failed with error: \(error)")
                    }
        }
        super.viewDidLoad()
    }
}
