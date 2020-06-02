//
//  I_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftUI

class I_SearchViewController: UIViewController {
        
    @IBOutlet weak var messageTextField: UILabel!
    let searchBar = UISearchBar()
    @State private var rating = 0
        var userId: Int!
       var userEmail: String!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if let viewWithTag = self.view.viewWithTag(100) {
                print("Tag 100")
                viewWithTag.removeFromSuperview()
            } else {
                print("tag not found")
            }
            search(shouldShow: false)    }
    
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
        AF.request("http://168.63.65.106/user/search",
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
                      let userFound:userFound = Bundle.main.loadNibNamed("userFoundView", owner: self, options: nil)?.first as! userFound
                                             userFound.tag = 100
                                             userFound.userPseudoLabelField.text = response.object(forKey: "pseudo")! as? String
                                             userFound.setImage()
                                             self.userId = response.object(forKey: "id")! as? Int
                                             self.userEmail = response.object(forKey: "email")! as? String
                                             userFound.userImageView.image = imageData
                                             userFound.noteButton.addTarget(self, action: #selector(I_SearchViewController.noteButtonTapped(sender:)), for: .touchUpInside)
                                             userFound.contactButton.addTarget(self, action: #selector(I_SearchViewController.contactButtonTapped(sender:)), for: .touchUpInside)
                                             self.view.addSubview(userFound)

                        print("Successfull")
                        

                    case .failure(let error):
                        self.messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
                        print("Request failed with error: \(error)")
                    }
        }
    }
    @objc func noteButtonTapped (sender:UIButton) {
          let rateView = NotationUserView(userId: userId, rating: rating)
          
          let host = UIHostingController(rootView: rateView)
          navigationController?.pushViewController(host, animated: true)
      }
      
      @objc func contactButtonTapped (sender:UIButton) {
          let contactView = ContactUserView(emailUser: userEmail)
          
          let host = UIHostingController(rootView: contactView)
          navigationController?.pushViewController(host, animated: true)
      }
}
