//
//  B_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit

class B_SearchViewController: UIViewController {

        @IBOutlet weak var shopFoundView: shopFound!
        @IBOutlet weak var messageTextField: UILabel!
        let searchBar = UISearchBar()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            shopFoundView.isHidden = true
            configureSearchBar()
        }
        
        @objc func handleShowSearchBar() {
            search(shouldShow: true)
            searchBar.becomeFirstResponder()
        }
        search(shouldShow: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userPseudo = searchBar.text!
        self.searchBar.endEditing(true)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let user: Parameters = [
            "pseudo": userPseudo
        ]
        print(userPseudo)
        AF.request("http://168.63.65.106:8080/user/search",
        method: .post,
        parameters: user,
        encoding: URLEncoding.default, headers: headers, interceptor: nil).validate(statusCode: 200..<300).responseJSON { response in

                    switch response.result {
                    case .success(let JSON):
                        let response = JSON as! NSDictionary
                        print(response)
                        let imageArray = response.object(forKey: "userPicture")! as! [[String:Any]]
                        var imageData = #imageLiteral(resourceName: "noImage")
                        if imageArray.count > 0 {
                            let imageUrl = URL(string: imageArray[0]["imageData"] as! String)!
                            imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
                        }
                        let shopFound:shopFound = Bundle.main.loadNibNamed("shopFoundView", owner: self, options: nil)?.first as! shopFound
                        shopFound.tag = 100
                        shopFound.shopPseudoLabelField.text = response.object(forKey: "pseudo")! as? String
                        shopFound.setImage()
                        self.userId = response.object(forKey: "id")! as? Int
                        self.userEmail = response.object(forKey: "email")! as? String
                        shopFound.shopImageView.image = imageData
                        shopFound.noteButton.addTarget(self, action: #selector(B_SearchViewController.noteButtonTapped(sender:)), for: .touchUpInside)
                        shopFound.contactButton.addTarget(self, action: #selector(B_SearchViewController.contactButtonTapped(sender:)), for: .touchUpInside)
                        self.view.addSubview(shopFound)
                        print("Successfull")
                        

                    case .failure(let error):
                        self.messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
                        print("Request failed with error: \(error)")
                    }
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

    extension B_SearchViewController : UISearchBarDelegate {
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            search(shouldShow: false)
            shopFoundView.isHidden = true
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if (searchBar.text == "Bibi") {
                shopFoundView.isHidden = false
                shopFoundView.pseudoTextField.text = "Nike"
                shopFoundView.emailTextField.text = "Nike Email"
                shopFoundView.fullnameTextField.text = "Nike full name"
                shopFoundView.postalTextField.text = "12345"
                shopFoundView.cityTextField.text = "New York"
                shopFoundView.phoneTextField.text = "0612345678"
                shopFoundView.societyTextField.text = "Nike"
                shopFoundView.functionTextField.text = "function"
                shopFoundView.themeTextField.text = "theme"
                messageTextField.text = "Veuillez entrer votre recherche"
            } else {
                messageTextField.text = "Aucune marque trouvées, veuillez réessayer."
            }
        }
    }
