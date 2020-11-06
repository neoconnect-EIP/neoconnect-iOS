//
//  API_Shop_Request.swift
//  NeoConnect
//
//  Created by EIP on 01/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import Alamofire

class APIBrandManager {
    
    let imageConverter = ImageConverter()
    let baseURL = "http://168.63.65.106:8080"
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    static let getRegisterShopEndpoint = "/shop/register"
    static let infoCurrentAccountEndpoint = "/shop/me"
    static let postOfferEndpoint = "/offer/insert"
    static let offerEndPoint = "/offer/"
    static let postSearchInfEndpoint = "/inf/search"
    
    static let sharedInstance = APIBrandManager()
    
    func register_Shop(pseudo: String, password: String, name: String, email: String, website: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, description: String, subject: String, facebook: String, snapchat: String, twitter: String, instagram: String,  onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.getRegisterShopEndpoint
        
        let Register: Parameters = [
            "pseudo": pseudo,
            "password": password,
            "full_name": name,
            "email": email,
            "website": website,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "userPicture": userPicture,
            "theme": subject,
            "facebook": facebook,
            "snapchat": snapchat,
            "twitter": twitter,
            "instagram": instagram,
        ]
        
        AF.request(url, method: .post, parameters: Register, encoding: URLEncoding.default, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    print("Successfull")
                    onSuccess()
                case .failure(_):
                    print("Error")
                    onFailure()
            }
        }
    }
    
    func editInfo(pseudo: String, fullname: String, email: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, description: String, subject: String, website: String, facebook: String, snapchat: String, twitter: String, instagram: String, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIBrandManager.infoCurrentAccountEndpoint
        let new_Info: Parameters = [
            "pseudo": pseudo,
            "full_name": fullname,
            "email": email,
            "website": website,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "userPicture": userPicture,
            "userDescription" : description,
            "theme": subject,
            "facebook": facebook,
            "snapchat": snapchat,
            "twitter": twitter,
            "instagram": instagram,
        ]
        
        AF.request(url, method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
    
    func editOffer(id: Int, name: String, imageData: String, sex: String, description: String, subject: String, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIBrandManager.offerEndPoint + "\(id)"
        let imageName = "Img_offer_\(String(id))"
        let offer: [String: Any] = [
            "productImg": [
                [
                    "imageName": imageName,
                    "imageData": imageData
                ]
            ],
            "productName": name,
            "productSex": sex,
            "productDesc": description,
            "productSubject": subject,
        ]
        
        AF.request(url, method: .put, parameters: offer, encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    // Offre modifiée
                    onSuccess()
                    
                case .failure(let error):
                    // Erreur de la modification de l'offre
                    onFailure(error)
            }
        }
    }
    
    func getInfo(onSuccess: @escaping([String:Any]) -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIBrandManager.infoCurrentAccountEndpoint
        
        AF.request(url, headers: APIBrandManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? [String:Any] else { return }
                    onSuccess(response)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
    
    func search_inf(userPseudo: String, onSuccess: @escaping([String:Any]) -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.postSearchInfEndpoint
        let user: Parameters = [
            "pseudo": userPseudo
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: user,
                   encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
                            guard let response = JSON as? [String:Any] else { return }
                            print(response)
                            onSuccess(response)
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                            onFailure()
                    }
                   }
    }
    
    func addOffer(name: String, description: String, theme: String, imageName: String, imageData: String, color: String, brand: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.postOfferEndpoint
        let offer: [String: Any] = [
            "productImg": [
                [
                    "imageName": imageName,
                    "imageData": imageData
                ]
            ],
            "productName": name,
            "productDesc": description,
            "productSubject": theme,
            "brand": brand,
            "color": color
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: offer,
                   encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).validate(statusCode: 200..<300).responseJSON { response in
                    
                    switch response.result {
                        case .success(let JSON):
                            guard let response = JSON as? [String:Any] else { return }
                            print(response)
                            onSuccess()
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                            onFailure()
                    }
                   }
    }
}
