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
    
//    let baseURL = "http://146.59.156.45:8080"
    let baseURL = "http://168.63.65.106:8080"
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    static let getRegisterInfEndpoint = "/inf/register"
    static let postSearchBrandEndpoint = "/shop/search"
    static let infoCurrentAccountEndpoint = "/inf/me"
    static let getBrandList = "/inf/listShop"
    static let getBrandSuggestionList = "/user/suggestion"
    static let getOfferList = "/offer/list"
    static let getOfferSuggestionList = "/offer/suggestion"
    static let getOffersByBrandId = "/offer/shop"
    static let putFollowBrand = "/shop/follow"
    static let putUnFollowBrand = "/shop/unfollow"
    static let postSponsorshipCode = "/insertParrainage"
    
    static let sharedInstance = APIInfManager()
    
    func register_Inf(pseudo: String, password: String, sex: String, name: String, email: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, description: String, subject: String, facebook: String, twitter: String, instagram: String, snapchat: String, youtube: String, twitch: String, pinterest: String, tiktok: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
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
            "UserDescription": description,
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
    
    func editInfo(fullname: String, phoneNumber: String, zipCode: String, city: String, userPicture: String, userDescription: String, subject: String, facebook: String, snapchat: String, twitter: String, instagram: String, youtube: String, twitch: String, pinterest: String, tiktok: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.infoCurrentAccountEndpoint
        let new_Info: Parameters = [
            "full_name": fullname,
            "phone": phoneNumber,
            "postal": zipCode,
            "city": city,
            "userPicture": userPicture,
            "userDescription": userDescription,
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
                case .success(let JSON):
                    print(JSON)
                    onSuccess()
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure()
            }
        }
    }

    func getOfferList(param: String = "", filter: String = "", onSuccess: @escaping(Array<NSDictionary>) -> Void) {
        var url : String = baseURL + APIInfManager.getOfferList
        if filter.count > 0 {
            let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
            let encodedFilter = filter.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
            url += "?\(param)=\(encodedFilter!)"
        }
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? Array<NSDictionary> else { return }
                    if filter.count > 0 {
                        print(response)
                    }
                    onSuccess(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getOfferSuggestionList(onSuccess: @escaping(Any) -> Void) {
        let url : String = baseURL + APIInfManager.getOfferSuggestionList
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    onSuccess(JSON)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getOffersByBrandId(brandId: Int, onSuccess: @escaping(Array<NSDictionary>) -> Void) {
        let url : String = baseURL + APIInfManager.getOffersByBrandId + "/\(brandId)"
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? Array<NSDictionary> else { return }
                    onSuccess(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func putFollowBrand(brandId: String, onSuccess: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.putFollowBrand + "/\(brandId)"

        AF.request(url, method: .put, headers: APIInfManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    print(response)
                    onSuccess()
                case .failure(let error):
                    print("Request failed withs error: \(error)")
            }
        }
    }
    
    func putUnFollowBrand(brandId: String, onSuccess: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.putUnFollowBrand + "/\(brandId)"

        AF.request(url, method: .put, headers: APIInfManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(_):
                    print(response)
                    onSuccess()
                case .failure(let error):
                    print("Request failed withs error: \(error)")
            }
        }
    }
    
    func getBrandList(onSuccess: @escaping(Array<NSDictionary>) -> Void) {
        let url : String = baseURL + APIInfManager.getBrandList
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? Array<NSDictionary> else { return }
                    onSuccess(response)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
func getBrandSuggestionList(onSuccess: @escaping(Any) -> Void) {
        let url : String = baseURL + APIInfManager.getBrandSuggestionList
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    onSuccess(JSON)
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getInfo(onSuccess: @escaping([String:Any]) -> Void) {
        let url : String = baseURL + APIInfManager.infoCurrentAccountEndpoint
        
        AF.request(url, headers: APIInfManager.headers).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    let response = JSON as? [String:Any]
                    onSuccess(response!)
                case .failure(let error):
                    print("Request failed with error: \(error)")
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
                   encoding: URLEncoding.default, headers: APIInfManager.headers, interceptor: nil).responseJSON { response in
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
    
    func postSponsorshipCode(code: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIInfManager.postSponsorshipCode
        let code: Parameters = [
            "codeParrainage": code
        ]
        
        AF.request(url, method: .post, parameters: code, encoding: URLEncoding.default, headers: APIInfManager.headers, interceptor: nil).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure()
            }
        }
    }
}
