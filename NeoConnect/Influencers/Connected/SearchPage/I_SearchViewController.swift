//
//  I_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 30/10/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftUI
import Cosmos

class I_SearchViewController: UIViewController {
        
    @IBOutlet weak var messageTextField: UILabel!
    
    @State private var rating = 0
    var selectedScope = "Marques"
    var userId: Int!
    var userEmail: String!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var shopImageView: UIImage!
    var shopPseudoLabelField: String!
    var shopSubjectLabelField: String!
    var shopRatingStars: CosmosView!
    var shopFollowed: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "Rechercher une marque"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["Marques", "Offres"]
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchBar.scopeButtonTitles = ["Marques", "Offres"]
        if selectedScope == 1 {
            self.selectedScope = "Offres"
            searchBar.placeholder = "Rechercher une offre"
            self.messageTextField.text = "Rendez-vous à la prochaine mis à jour :)"
        } else {
            self.selectedScope = "Marques"
            searchBar.placeholder = "Rechercher une marque"
            self.messageTextField.text = "Veuillez entrer votre recherche"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "I_searchBrandResult" {
            let searchResult: I_ShopFoundViewController = segue.destination as! I_ShopFoundViewController
            
            searchResult.userId = self.userId
            searchResult.userEmail = self.userEmail
            searchResult.imageView = self.shopImageView
            searchResult.pseudo = self.shopPseudoLabelField
            searchResult.subject = self.shopSubjectLabelField
            searchResult.stars = self.shopRatingStars
            searchResult.followed = self.shopFollowed
        }
    }
}

extension I_SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if self.selectedScope == "Marques" {
            let userPseudo = searchBar.text!
            self.searchController.searchBar.endEditing(true)
            APIInfManager.sharedInstance.search_brand(userPseudo: userPseudo, onSuccess: { response in
                let imageArray = response["userPicture"] as? [[String:Any]]
                let imageUrl = URL(string: imageArray![0]["imageData"] as! String)!
                var imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
                DispatchQueue.main.async {
                    AF.request(imageUrl).responseImage { response in
                        if case .success(let image) = response.result {
                            print("Image downloaded: \(image)")
                            imageData = image
                        } else if case .failure(let error) = response.result {
                            print("Image Request Error : \(error)")
                        }
                    }
                }
                self.userId = response["id"] as? Int
                self.userEmail = response["email"] as? String
                self.shopPseudoLabelField = response["pseudo"] as? String
                self.shopImageView = imageData
                self.shopSubjectLabelField = response["theme"] as? String
                self.shopFollowed = response["follow"] as? Bool
                // userFound.shopRatingStars.rating = (response["note"] as? Double)!
                self.performSegue(withIdentifier: "I_searchBrandResult", sender: self)
            }, onFailure: {
                self.messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
            })
        } else if selectedScope == "Offres" {
            self.messageTextField.text = "Rendez-vous à la prochaine mis à jour :)"
        }
    }
}
