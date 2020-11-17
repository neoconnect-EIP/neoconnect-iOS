//
//  APIManager.swift
//  NeoConnect
//
//  Created by EIP on 02/07/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class APIManager {
    
    struct ForgotPassword_s: Encodable {
        let email: String
    }
    
    struct Login_s: Encodable {
        let pseudo: String
        let password: String
    }
    
    let baseURL = "http://168.63.65.106:8080"
    static let headers: HTTPHeaders = [
        "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
        "Content-Type": "application/x-www-form-urlencoded"
    ]
    static let getLoginEndpoint = "/login"
    static let deleteUserEndpoint = "/user/delete"
    static let forgotPasswordEndpoint = "/forgotPassword"
    static let updatePasswordEndpoint = "/updatePassword"
    static let messagesEndpoint = "/message"
    static let getImageEndpoint = "/image/User_"
    static let getOffersByShopId = "/offer/shop"
    
    static let sharedInstance = APIManager()
    
    func login(userPseudo: String, userPassword: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIManager.getLoginEndpoint
        let login = Login_s(pseudo: userPseudo, password: userPassword)
        
        AF.request(url,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
                            let response = JSON as! [String:Any]
                            guard let token = response["token"] else { return }
                            guard let id = response["userId"] else { return }
                            guard let userType = response["userType"] else { return }
                            guard let theme = response["theme"] else { return }
                            UserDefaults.standard.set(token, forKey: "Token")
                            UserDefaults.standard.set(id, forKey: "id")
                            UserDefaults.standard.set(theme, forKey: "theme")
                            UserDefaults.standard.set(userPseudo, forKey: "pseudo")
                            UserDefaults.standard.set(userType, forKey: "userType")
                            UserDefaults.standard.set(Date(), forKey:"LogInTime")
                            UserDefaults.standard.synchronize()
                            onSuccess()
                        case .failure(_):
                            onFailure()
                    }
        }
    }
    
    func getUserImage(onSuccess: @escaping(UIImage) -> Void) {
        guard let id = UserDefaults.standard.string(forKey: "id") else { return }
        guard let pseudo = UserDefaults.standard.string(forKey: "pseudo") else { return }
        let url : String = baseURL + APIManager.getImageEndpoint + "\(id)_\(id)_\(pseudo).png"

        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                onSuccess(image)
            } else if case .failure(let error) = response.result {
                print("Image Request Error : \(error)")
            }
        }
    }
    
    func delete() {
        let url : String = baseURL + APIManager.deleteUserEndpoint
        
        AF.request(url,
                   method: .delete,
                   encoding: URLEncoding.default, headers: APIManager.headers).response { response in
                    debugPrint(response)
        }
    }
    
    func forgotPassword(userEmail: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIManager.forgotPasswordEndpoint
        let forgotPassword = ForgotPassword_s(email: userEmail)
        
        AF.request(url,
                   method: .post,
                   parameters: forgotPassword,
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                        case .success(_):
                            onSuccess()
                        case .failure(_):
                            onFailure()
                    }
        }
    }
    
    func updatePassword(email: String, tempCode: String, userPassword: String, onSuccess: @escaping() -> Void, onFailure: @escaping() -> Void) {
        let url : String = baseURL + APIManager.forgotPasswordEndpoint
        let new_Pwd: Parameters = [
            "email": email,
            "resetPasswordtoken": tempCode,
            "password": userPassword
        ]

        AF.request(url, method: .put, parameters: new_Pwd, encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).responseString { response in
            switch response.result {
                case .success(_):
                    onSuccess()
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure()
            }
        }
    }
    
    func getConversations(onSuccess: @escaping(Array<NSDictionary>) -> Void) {
        let url : String = baseURL + APIManager.messagesEndpoint
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    let results = JSON as! Array<NSDictionary>
                    onSuccess(results)
                
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getMessages(id: Int, onSuccess: @escaping([String:Any]) -> Void) {
        let url : String = baseURL + APIManager.messagesEndpoint + "/\(String(id))"
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    guard let response = JSON as? [String:Any] else { return }
                    onSuccess(response)
                
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func postMessage(id: String, message: String, onSuccess: @escaping() -> Void) {
        let url : String = baseURL + APIManager.messagesEndpoint
        
        let param: Parameters = [
            "message": message,
            "userId": id
        ]
        
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: APIManager.headers, interceptor: nil).responseJSON { response in
            switch response.result {
                case .success(let JSON):
                    print(JSON)
                    onSuccess()
                
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
    }
    
    func getOffersByShopId(id: String,onSuccess: @escaping(Any) -> Void) {
        let url : String = baseURL + APIManager.getOffersByShopId + "/\(id)"
        
        AF.request(url,
                   headers: APIManager.headers).responseJSON { response in
                    switch response.result {
                        case .success(let JSON):
                            onSuccess(JSON)
                        case .failure(let error):
                            print("Request failed with error: \(error)")
                    }
                   }

    }

}
