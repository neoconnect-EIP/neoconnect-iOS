//
//  B_SearchViewController.swift
//  NeoConnect
//
//  Created by EIP on 10/09/2019.
//  Copyright © 2019 EIP. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftUI
import Cosmos

class B_SearchViewController: UIViewController {

    @IBOutlet weak var messageTextField: UILabel!
    
    @State private var rating = 0
    var userId: Int!
    var userEmail: String!
    private let searchController = UISearchController(searchResultsController: nil)
    
    var infImageView: UIImage!
    var infPseudoLabelField: String!
    var infSubjectLabelField: String!
    var infRatingStars: CosmosView!
    var infFollowed: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "Rechercher un influenceur"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "B_searchResult" {
            let searchResult: B_InfFoundViewController = segue.destination as! B_InfFoundViewController
            
            searchResult.userId = self.userId
            searchResult.userEmail = self.userEmail
            searchResult.imageView = self.infImageView
            searchResult.pseudo = self.infPseudoLabelField
            searchResult.subject = self.infSubjectLabelField
            searchResult.stars = self.infRatingStars
        }
    }
}

extension B_SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userPseudo = searchBar.text!
        self.searchController.searchBar.endEditing(true)
        APIBrandManager.sharedInstance.search_inf(userPseudo: userPseudo, onSuccess: { response in
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
            self.infPseudoLabelField = response["pseudo"] as? String
            self.infImageView = imageData
            self.infSubjectLabelField = response["theme"] as? String
//            self.infRatingStars.rating = (response["note"] as? Double)!
            self.performSegue(withIdentifier: "B_searchResult", sender: self)
        }, onFailure: {
            self.messageTextField.text = "Aucun utilisateur trouvé, veuillez réessayer."
        })
    }
}

