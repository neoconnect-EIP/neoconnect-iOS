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

class I_SearchViewController: UIViewController, I_BrandSuggestionTableViewCellDelegate, I_OfferSuggestionTableViewCellDelegate, FiltersViewControllerDelegate, I_OfferTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sc: UISegmentedControl!
    @IBOutlet weak var offerUnderline: UIImageView!
    @IBOutlet weak var brandUnderline: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterImageView: UIImageView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var brands: [I_Brand] = []
    var brandsSuggestion: [I_Brand] = []
    var offers: [I_Offer] = []
    var filteredOffers: [I_Offer] = []
    var offersSuggestion: [I_Offer] = []
    var rowToDisplay: [Any] = []
    var suggestionToDisplay: [Any] = []
    var filterSelected: String?
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configureSearchBar()
        loader.startAnimating()
        getBrandSuggestionsFromAPI()
        getBrandsFromAPI()
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "Rechercher une marque"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        if sc.selectedSegmentIndex == 0 {
            getBrandsFromAPI()
            getBrandSuggestionsFromAPI()
        } else {
            getOffersFromAPI()
            getOfferSuggestionsFromAPI()
        }
    }
    
    @IBAction func scAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.filterButton.isHidden = true
                self.filterImageView.isHidden = true
                self.searchController.searchBar.placeholder = "Rechercher une marque"
                self.brandUnderline.isHidden = false
                self.offerUnderline.isHidden = true
                self.rowToDisplay = self.brands
                self.suggestionToDisplay = self.brandsSuggestion
            default:
                self.filterButton.isHidden = false
                self.filterImageView.isHidden = false
                self.searchController.searchBar.placeholder = "Rechercher une offre"
                self.brandUnderline.isHidden = true
                self.offerUnderline.isHidden = false
                if self.offers.count == 0 {
                    self.loader.isHidden = false
                    self.loader.startAnimating()
                    self.getOfferSuggestionsFromAPI()
                    self.getOffersFromAPI()
                }
                self.suggestionToDisplay = self.offersSuggestion
                self.rowToDisplay = self.offers
        }
        tableView.reloadData()
    }
    
    func getOfferSuggestionsFromAPI() {
        APIInfManager.sharedInstance.getOfferSuggestionList(onSuccess: { JSON in
            if JSON as? String != "No Data" {
                let offers = JSON as! Array<NSDictionary>
                self.offersSuggestion = self.getOfferArray(results: offers)
                self.suggestionToDisplay = self.offersSuggestion
            }
            self.tableView.reloadData()
            self.loader.isHidden = true
        })
    }
    
    func getOffersFromAPI(param: String = "", filter: String = "") {
        APIInfManager.sharedInstance.getOfferList(param: param, filter: filter, onSuccess: { offers in
            self.offers = self.getOfferArray(results: offers)
            self.rowToDisplay = self.offers
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        })
    }
    
    func getBrandSuggestionsFromAPI() {
        APIInfManager.sharedInstance.getBrandSuggestionList(onSuccess: { JSON in
            if JSON as? String != "No Data" {
                let offers = JSON as! Array<NSDictionary>
                self.brandsSuggestion = self.getBrandArray(results: offers)
                self.suggestionToDisplay = self.brandsSuggestion
            }
            self.tableView.reloadData()
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

    func brandSuggestionTapped(brand: I_Brand) {
        performSegue(withIdentifier: "I_searchBrand", sender: brand)
    }

    func offerSuggestionTapped(offer: I_Offer) {
        let rateView = DetailOffer2(selectedOffer: offer, date: "")
        let host = UIHostingController(rootView: rateView)
        
        navigationController?.pushViewController(host, animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        let offersToDisplay: [I_Offer] = rowToDisplay as! Array<I_Offer>
        
        filteredOffers = offersToDisplay.filter { (offer: I_Offer) -> Bool in
            return offer.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func filterSelected(param: String, filter: String) {
        loader.isHidden = false
        loader.startAnimating()
        getOffersFromAPI(param: param, filter: filter)
    }

    func offerTapped(offer: I_Offer) {
        let rateView = DetailOffer2(selectedOffer: offer, date: "")
        let host = UIHostingController(rootView: rateView)
        
        navigationController?.pushViewController(host, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let shopVC: I_DetailedShopViewController = segue.destination as? I_DetailedShopViewController {
          if segue.identifier == "I_searchBrand" {
            shopVC.brand = sender as? I_Brand
        } else if segue.identifier == "I_brandResult" {
            let row = tableView.indexPathForSelectedRow?.row
            let brand = self.brands[row! - 1]
            
            shopVC.brand = brand
        }
       } else if segue.identifier == "getFilterSegue" {
            let filterVC: FiltersViewController = segue.destination as! FiltersViewController
            filterVC.delegate = self
        }
    }
}

extension I_SearchViewController: UITableViewDataSource, UITableViewDelegate {
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sc.selectedSegmentIndex == 0 {
            return indexPath.row == 0 ? 160 : 120
        }
        return indexPath.row == 0 ? 160 : 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
          return filteredOffers.count + 1
        }
        if suggestionToDisplay.count > 0 {
            return rowToDisplay.count + 1
        }
        return rowToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            if sc.selectedSegmentIndex == 0 {
                let brandSuggestionCell = tableView.dequeueReusableCell(withIdentifier: "I_BrandSuggestionTableViewCell") as! I_BrandSuggestionTableViewCell

                brandSuggestionCell.setBrandSuggestions(brands: suggestionToDisplay as! Array<I_Brand>)

                brandSuggestionCell.delegate = self
                cell = brandSuggestionCell
            } else {
                let offerSuggestionCell = tableView.dequeueReusableCell(withIdentifier: "I_OfferSuggestionTableViewCell") as! I_OfferSuggestionTableViewCell

                offerSuggestionCell.setOfferSuggestions(offers: suggestionToDisplay as! Array<I_Offer>)
                
                offerSuggestionCell.delegate = self
                cell = offerSuggestionCell
            }
        } else {
            var row = rowToDisplay[indexPath.row - 1]
            if sc.selectedSegmentIndex == 0 {
                let brandCell = tableView.dequeueReusableCell(withIdentifier: "I_BrandTableViewCell") as! I_BrandTableViewCell
                
                brandCell.setBrands(brand: row as! I_Brand)
                
                cell = brandCell
            } else {
                if isFiltering {
                    row = filteredOffers[indexPath.row - 1]
                }
                let offerCell = tableView.dequeueReusableCell(withIdentifier: "I_OfferTableViewCell") as! I_OfferTableViewCell
                
                offerCell.delegate = self
                offerCell.setOffer(offer: row as! I_Offer)
                
                cell = offerCell
            }
        }
        return cell
    }
}

extension I_SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if sc.selectedSegmentIndex != 0 {
            let searchBar = searchController.searchBar
            print(searchBar.text!)
            filterContentForSearchText(searchBar.text!)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar,
        selectedScopeButtonIndexDidChange selectedScope: Int) {
        if sc.selectedSegmentIndex != 0 {
            filterContentForSearchText(searchBar.text!)
        }
    }
    
    func searchBrand(_ textSearched: String) {
        APIInfManager.sharedInstance.search_brand(userPseudo: textSearched, onSuccess: { response in
            if let message = response["message"] as? String, message == "User can't be searched" {
                DispatchQueue.main.async {
                    let alertView = UIAlertController(title: "Erreur", message: "Aucun utilisateur trouvé, veuillez réessayer.", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                    self.present(alertView, animated: true, completion: nil)
                }
                return
            }
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
            let brand = I_Brand(id: brandId, pseudo: brandPseudo, nbOffers: String(brandNbOffers), nbFollowers: String(brandNbFollowers), image: brandImage, subject: brandSubject, rate: brandRate, description: brandDescription, followed: brandFollowed, comments: brandComments)
            self.performSegue(withIdentifier: "I_searchBrand", sender: brand)
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
        }
    }
}
