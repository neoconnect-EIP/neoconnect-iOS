//
//  API_request.swift
//  NeoConnect
//
//  Created by EIP on 12/06/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import Foundation
import Alamofire

class APIInfManager {
    
    let baseURL = "http://168.63.65.106:8080"
    
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    static let getRegisterInfEndpoint = "/inf/register"
    static let postSearchBrandEndpoint = "/shop/search"
    static let infoCurrentAccountEndpoint = "/inf/me"
    
    static let sharedInstance = APIInfManager()
    
    func register_Inf(pseudo: String, password: String, sex: String, name: String, email: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, subject: String, facebook: String, twitter: String, instagram: String, snapchat: String, youtube: String, twitch: String, pinterest: String, tiktok: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.getRegisterInfEndpoint

        let Register: Parameters = [
            "pseudo": pseudo,
            "password": password,
            "sexe": sex,
            "full_name": name,
            "email": email,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "userPicture": userPicture,
            "theme": subject,
            "facebook": facebook,
            "twitter": twitter,
            "instagram": instagram,
            "snapchat": snapchat,
            "youtube": youtube,
            "twitch": twitch,
            "pinterest": pinterest,
            "tiktok": tiktok
        ]
        
        AF.request(url, method: .post, parameters: Register, encoding: URLEncoding.default, interceptor: nil).responseJSON { response in

                    switch response.result {
                    case .success(_):
                        // Inscription réussie
                        print("Successfull")
                        onSuccess()
                    case .failure(_):
                        // /!\ Inscription ratée
                        print("Error")
                        onFailure()
                    }
        }
    }
    
    func editInfo(pseudo: String, fullname: String, email: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, subject: String, facebook: String, snapchat: String, twitter: String, instagram: String, youtube: String, twitch: String, pinterest: String, tiktok: String, onSuccess: @escaping() -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIInfManager.infoCurrentAccountEndpoint
        let new_Info: Parameters = [
            "pseudo": pseudo,
            "full_name": fullname,
            "email": email,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "userPicture": userPicture,
            "theme": subject,
            "facebook": facebook,
            "snapchat": snapchat,
            "twitter": twitter,
            "instagram": instagram,
            "youtube": youtube,
            "twitch": twitch,
            "pinterest": pinterest,
            "tiktok": tiktok
        ]

        AF.request(url, method: .put, parameters: new_Info, encoding: URLEncoding.default, headers: APIInfManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    onFailure(error)
            }
        }
    }

    func getInfo(onSuccess: @escaping([String:Any]) -> Void, onFailure: @escaping(Error) -> Void) {
        let url : String = baseURL + APIInfManager.infoCurrentAccountEndpoint
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                
                case .success(let JSON):
                    guard let response = JSON as? [String:Any] else { return }
                    print(response)
                    onSuccess(response)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
    
    func search_brand(userPseudo: String, onSuccess: @escaping([String:Any]) -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.postSearchBrandEndpoint
        let user: Parameters = [
            "pseudo": userPseudo
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: user,
                   encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).validate(statusCode: 200..<300).responseJSON { response in
                    
                    switch response.result {
                        case .success(let JSON):
                            let response = JSON as! [String:Any]
                            print(response)
                            onSuccess(response)
                        
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                            onFailure()
                    }
        }
    }
}
