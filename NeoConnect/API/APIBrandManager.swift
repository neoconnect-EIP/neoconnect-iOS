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
    
    let baseURL = "http://168.63.65.106:8080"
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    static let getRegisterShopEndpoint = "/shop/register"
    static let infoCurrentAccountEndpoint = "/shop/me"
    static let postOfferEndpoint = "/offer/insert"
    static let offerEndPoint = "/offer"
    static let postSearchInfEndpoint = "/inf/search"
    static let getListInf = "/shop/listInf"
    
    static let sharedInstance = APIBrandManager()
    
    func register_Shop(pseudo: String, password: String, name: String, email: String, website: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, description: String, subject: String, facebook: String, snapchat: String, twitter: String, instagram: String,  onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.getRegisterShopEndpoint
        
        let user: Parameters = [
            "pseudo": pseudo,
            "password": password,
            "full_name": name,
            "email": email,
            "website": website,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "UserDescription": description,
            "userPicture": userPicture,
            "theme": subject,
            "facebook": facebook,
            "snapchat": snapchat,
            "twitter": twitter,
            "instagram": instagram,
        ]
        
        AF.request(url, method: .post, parameters: user, encoding: URLEncoding.default, interceptor: nil).responseJSON { response in
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
    
    func editInfo(fullname: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, description: String, subject: String, website: String, facebook: String, snapchat: String, twitter: String, instagram: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.infoCurrentAccountEndpoint
        let new_Info: Parameters = [
            "full_name": fullname,
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
                case .success(let JSON):
                    print(JSON)
                    onSuccess()
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure()
            }
        }
    }
    
    func getInfo(onSuccess: @escaping([String:Any]) -> Void) {
        let url : String = baseURL + APIBrandManager.infoCurrentAccountEndpoint
        
        AF.request(url, headers: APIBrandManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? [String:Any] else { return }
                    onSuccess(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getInfList(onSuccess: @escaping(Array<NSDictionary>) -> Void) {
        let url : String = baseURL + APIBrandManager.getListInf
        
        AF.request(url, headers: APIBrandManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? Array<NSDictionary> else { return }
                    onSuccess(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
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
                   encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
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
    
    func deleteOffer(id: String, onSuccess: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.offerEndPoint + String(id)
        
        AF.request(url, method: .delete, encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    // Offre modifiée
                onSuccess()
                case .failure(let error):
                    // Erreur de la modification de l'offre
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func addOffer(name: String, description: String, subject: String, sex: String, imageArray: Array<String>, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIBrandManager.postOfferEndpoint
        guard let brand = UserDefaults.standard.string(forKey: "pseudo") else { return }
        let offer: [String:Any] = [
            "productImg":
            [
                [
                    "imageData": imageArray[0],
                    "imageName": ""
                ]
            ],
            "productSex": sex == "Sexe" ? "" : sex,
            "productName": name,
            "productDesc": description,
            "productSubject": subject,
            "brand": brand,
        ]
        AF.request(url,
                   method: .post,
                   parameters: offer,
                   encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
                            print(JSON)
                            onSuccess()
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                            onFailure()
                    }
                   }
    }
    
    func editOffer(id: Int, name: String, description: String, subject: String, sex: String, imageArray: Array<String>, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIBrandManager.offerEndPoint + "/\(id)"
        var imageDict: Array<Dictionary<String, String>> = []
        for image in imageArray {
            imageDict.append([
                "imageName": "",
                "imageData": image
            ])
        }
        let offer: Parameters = [
            "productImg": [
                "imageName": "",
                "imageData": imageDict
            ],
            "productSex": sex == "Sexe" ? "" : sex,
            "productName": name,
            "productDesc": description,
            "productSubject": subject,
        ]
        
        AF.request(url, method: .put, parameters: offer, encoding: URLEncoding.default, headers: APIBrandManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
}
