//
//  I_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class I_SearchViewController: UIViewController {
    
    @IBOutlet weak var userFoundView: userFound!
    @IBOutlet weak var messageTextField: UILabel!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFoundView.isHidden = true
        configureSearchBar()
    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func configureSearchBar() {
        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            searchBar.placeholder = "Veuillez entrer votre recherche ..."
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
            searchBar.text = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}

extension I_SearchViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        userFoundView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.messageTextField.text = "Rendez-vous à la prochaine mis à jour ! :)"

//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        
//        
//        let userToSearch: [String:Any] = [
//            "pseudo": "Bibinf",
//        ]
//        let URL = "http://168.63.65.106/user/search"
//        AF.request(urlComponents, method: .get, parameters: userToSearch, encoding: URLEncoding(destination: .queryString), headers: headers, interceptor: nil).responseJSON { response in
//
//                    switch response.result {
//                    case .success(let JSON):
//                                
//                        print(response.request)
//                        print(response.result)
//
//                            let response = JSON as! NSDictionary
//                            print(response)
////                            let imageArray = response.object(forKey: "userPicture")! as! [[String:Any]]
////                            var imageData = #imageLiteral(resourceName: "noImage")
////                            if imageArray.count > 0 {
////                                let imageUrl = URL(string: imageArray[0]["imageData"] as! String)!
////                                imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
////                            }
////                        let response = String(data: response.data!, encoding: String.Encoding.utf8)!
////                        let responseData = Data(response.utf8)
////                        let response = JSON as! NSDictionary
////                        let imageArray = response.object(forKey: "userPicture")! as! [[String:Any]]
////                        var imageData = #imageLiteral(resourceName: "noImage")
////                        if imageArray.count > 0 {
////                            let imageUrl = URL(string: imageArray[0]["imageData"] as! String)!
////                            imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
////                        }
////
////                        self.userFoundView.isHidden = false
////                        self.userFoundView.pseudoLabelField.text = response.object(forKey: "pseudo")! as? String
////                        self.userFoundView.userImageView.image = imageData
//
//                    case .failure(let error):
//                        debugPrint(error)
//                        self.messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
//                        print("Request failed with error: \(error)")
//                    }
//        }

    }
}
