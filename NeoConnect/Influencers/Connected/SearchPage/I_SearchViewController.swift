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
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sc: UISegmentedControl!
    @IBOutlet weak var offerUnderline: UIImageView!
    @IBOutlet weak var brandUnderline: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var brands: [I_Brand] = []
    var brandsSuggestion: [I_Brand] = []
    var brand: I_Brand!
    var offers: [I_Offer] = []
    var offerssSuggestion: [I_Offer] = []
    var offer: I_Offer!
    
    var rowToDisplay: [Any] = []
    var suggestionToDisplay: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configureSearchBar()
        loader.startAnimating()
        getBrandsFromAPI()
    }
    
    @IBAction func scAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.searchController.searchBar.placeholder = "Rechercher une marque"
                self.brandUnderline.isHidden = false
                self.offerUnderline.isHidden = true
                self.rowToDisplay = self.brands
            default:
                self.searchController.searchBar.placeholder = "Rechercher une offre"
                self.brandUnderline.isHidden = true
                self.offerUnderline.isHidden = false
                if self.offers.count == 0 {
                    self.loader.isHidden = false
                    self.loader.startAnimating()
                    self.getOffersFromAPI()
                }
                self.rowToDisplay = self.offers
        }
        tableView.reloadData()
    }
    
    func getOffersFromAPI() {
        APIInfManager.sharedInstance.getOfferList(onSuccess: { offers in
            self.offers = self.getOfferArray(results: offers)
            self.rowToDisplay = self.offers
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        })
    }
    
    func getBrandsFromAPI() {
        APIInfManager.sharedInstance.getBrandList(onSuccess: { brands in
            self.brands = self.getBrandArray(results: brands)
            self.rowToDisplay = self.brands
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        })
    }
    
    func getOfferArray(results: Array<NSDictionary>) -> [I_Offer] {
        var tempOffers: [I_Offer] = []
        
        for dictionary in results {
            var offerImages: [UIImage] = []
            if let productImgs = dictionary["productImg"] as? [[String:Any]] {
                for productImage in productImgs {
                    if let imageUrl = URL(string: (productImage["imageData"] as? String)!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageUrl)) {
                            offerImages.append(image)
                        }
                    }
                }
            }
            if offerImages.count == 0 {
                offerImages.append(UIImage(named: "placeholder-image")!)
            }
            guard let offerId = dictionary["id"] as? Int else { return tempOffers }
            let offerName = dictionary["productName"] as? String ?? ""
            let offerSex = dictionary["productSex"] as? String ?? ""
            let offerBrand = dictionary["brand"] as? String ?? ""
            let offerStatus = dictionary["status"] as? String ?? ""
            let offerSubject = dictionary["productSubject"] as? String ?? ""
            let offerDescription = dictionary["productDesc"] as? String ?? ""
            tempOffers.append(I_Offer(id: offerId, title: offerName, images: offerImages, sex: offerSex, brand: offerBrand, description: offerDescription, subject: offerSubject, status: offerStatus))
        }
        return tempOffers
    }
    
    func getBrandArray(results: Array<NSDictionary>) -> [I_Brand] {
        var tempBrands: [I_Brand] = []
        
        for dictionary in results {
            var brandImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = dictionary["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            brandImage = image
                        }
                    }
                }
            }
            guard let brandId = dictionary["id"] as? Int else { return tempBrands }
            guard let brandPseudo = dictionary["pseudo"] as? String else { return tempBrands }
            let brandNbOffers = dictionary["nbOfferPosted"] as? Int ?? 0
            let brandNbFollowers = dictionary["nbFollows"] as? Int ?? 0
            let brandSubject = dictionary["theme"] as? String ?? "Non assigné"
            let brandDescription = dictionary["userDescription"] as? String ?? ""
            let brandRate = dictionary["average"] as? Double ?? 0
            var brandComments: Array<NSDictionary> = []
            if let commentArray = dictionary["comment"] as? Array<NSDictionary> {
                brandComments = commentArray
            }
            let brandFollowed = dictionary["follow"] as? Bool ?? false
            tempBrands.append(I_Brand(id: brandId, pseudo: brandPseudo, nbOffers: String(brandNbOffers), nbFollowers: String(brandNbFollowers), image: brandImage, subject: brandSubject, rate: brandRate, description: brandDescription, followed: brandFollowed, comments: brandComments))
        }
        return tempBrands
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "Rechercher une marque"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shopVC: I_DetailedShopViewController = segue.destination as! I_DetailedShopViewController
        if segue.identifier == "I_searchBrandResult" {
            shopVC.brand = brand
        } else if segue.identifier == "I_brandResult" {
            let row = tableView.indexPathForSelectedRow?.row
            let brand = self.brands[row!]
            
            shopVC.brand = brand
        }
    }
}

extension I_SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 120 : 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let row = rowToDisplay[indexPath.row]
        if indexPath.row == 0 {
            if sc.selectedSegmentIndex == 0 {
                let brandCell = tableView.dequeueReusableCell(withIdentifier: "I_BrandTableViewCell") as! I_BrandTableViewCell
                
                brandCell.setBrands(brand: row as! I_Brand)
                cell = brandCell
            } else {
                let offerCell = tableView.dequeueReusableCell(withIdentifier: "I_OfferTableViewCell") as! I_OfferTableViewCell
                
                offerCell.setOffer(offer: row as! I_Offer)
                cell = offerCell
            }
//            if sc.selectedSegmentIndex == 0 {
//                let brandSuggestionCell = tableView.dequeueReusableCell(withIdentifier: "I_BrandSuggestionTableViewCell") as! I_BrandSuggestionTableViewCell
//
//                brandSuggestionCell.setBrandSuggestion(brands: suggestionToDisplay as! Array<I_Brand>)
//
//                cell = brandSuggestionCell
//            } else {
//                let offerSuggestionCell = tableView.dequeueReusableCell(withIdentifier: "I_OfferSuggestionTableViewCell") as! I_OfferSuggestionTableViewCell
//
//                offerSuggestionCell.setOfferSuggestion(offers: suggestionToDisplay as! Array<I_Offer>)
//
//                cell = offerSuggestionCell
//            }
        } else {
            if sc.selectedSegmentIndex == 0 {
                let brandCell = tableView.dequeueReusableCell(withIdentifier: "I_BrandTableViewCell") as! I_BrandTableViewCell
                
                brandCell.setBrands(brand: row as! I_Brand)
                
                cell = brandCell
            } else {
                let offerCell = tableView.dequeueReusableCell(withIdentifier: "I_OfferTableViewCell") as! I_OfferTableViewCell
                
                offerCell.setOffer(offer: row as! I_Offer)
                
                cell = offerCell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension I_SearchViewController: UISearchBarDelegate {
    
    func searchOffer(_ textSearched: String) {
        
    }
    
    func searchBrand(_ textSearched: String) {
        APIInfManager.sharedInstance.search_brand(userPseudo: textSearched, onSuccess: { response in
            var brandImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = response["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            brandImage = image
                        }
                    }
                }
            }
            guard let brandId = response["id"] as? Int else { return }
            guard let brandPseudo = response["pseudo"] as? String else { return }
            let brandNbOffers = response["nbOfferPosted"] as? Int ?? 0
            let brandNbFollowers = response["nbFollows"] as? Int ?? 0
            let brandSubject = response["theme"] as? String ?? "Non assigné"
            let brandDescription = response["userDescription"] as? String ?? ""
            let brandRate = response["average"] as? Double ?? 0
            let brandFollowed = response["follow"] as? Bool ?? false
            var brandComments: Array<NSDictionary> = []
            if let commentArray = response["comment"] as? Array<NSDictionary> {
                brandComments = commentArray
            }
            self.brand = I_Brand(id: brandId, pseudo: brandPseudo, nbOffers: String(brandNbOffers), nbFollowers: String(brandNbFollowers), image: brandImage, subject: brandSubject, rate: brandRate, description: brandDescription, followed: brandFollowed, comments: brandComments)
            self.performSegue(withIdentifier: "I_searchBrandResult", sender: self)
        }, onFailure: {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Aucun utilisateur trouvé, veuillez réessayer.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let textSearched = searchBar.text ?? ""
        self.searchController.searchBar.endEditing(true)

        if sc.selectedSegmentIndex == 0 {
            searchBrand(textSearched)
        } else {
            searchOffer(textSearched)
        }
    }
}
