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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    private let searchController = UISearchController(searchResultsController: nil)
    
    var infs: [Inf] = []
    var inf: Inf!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureSearchBar()
        loader.startAnimating()
        getDataFromApi()
    }
    
    func getDataFromApi() {
        APIBrandManager.sharedInstance.getInfList(onSuccess: { infs in
            self.infs = self.createArray(results: infs)
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        })
    }
    
    func createArray(results: Array<NSDictionary>) -> [Inf] {
        var tempInf: [Inf] = []
        
        for dictionary in results {
            var infImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = dictionary["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            infImage = image
                        }
                    }
                }
            }
            guard let infId = dictionary["id"] as? Int else { return tempInf }
            guard let infPseudo = dictionary["pseudo"] as? String else { return tempInf }
            let infOffersApplied = dictionary["nbOfferApplied"] as? Int ?? 0
            let infSubject = dictionary["theme"] as? String ?? ""
            let infAverage = dictionary["average"] as? Double ?? 0
            let infDescription = dictionary["userDescription"] as? String ?? ""
            var infComments: Array<NSDictionary> = []
            if let commentArray = dictionary["comment"] as? Array<NSDictionary> {
                infComments = commentArray
            }
            tempInf.append(Inf(id: infId, pseudo: infPseudo, offersApplied: String(infOffersApplied), subject: infSubject, average: infAverage, image: infImage, description: infDescription, comments: infComments))
        }
        return tempInf
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "Rechercher un influenceur"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infVC: B_DetailedInfViewController = segue.destination as! B_DetailedInfViewController
        if segue.identifier == "B_searchResult" {
            infVC.inf = inf
        } else {
            let row = tableView.indexPathForSelectedRow?.row
            let inf = self.infs[row!]
            
            infVC.inf = inf
        }
    }
}

extension B_SearchViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inf = infs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "B_InfTableViewCell") as! B_InfTableViewCell
        
        cell.initCell(inf: inf)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension B_SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userPseudo = searchBar.text!
        self.searchController.searchBar.endEditing(true)
        APIBrandManager.sharedInstance.search_inf(userPseudo: userPseudo, onSuccess: { response in
            var infImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = response["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            infImage = image
                        }
                    }
                }
            }
            guard let infId = response["id"] as? Int else { return }
            guard let infPseudo = response["pseudo"] as? String else { return }
            let infOffersApplied = response["nbOfferApplied"] as? Int ?? 0
            let infSubject = response["theme"] as? String ?? ""
            let infAverage = response["average"] as? Double ?? 0
            let infDescription = response["userDescription"] as? String ?? ""
            var infComments: Array<NSDictionary> = []
            if let commentArray = response["comment"] as? Array<NSDictionary> {
                infComments = commentArray
            }
            self.inf = Inf(id: infId, pseudo: infPseudo, offersApplied: String(infOffersApplied), subject: infSubject, average: infAverage, image: infImage, description: infDescription, comments: infComments)
            self.performSegue(withIdentifier: "B_searchResult", sender: self)
        }, onFailure: {
            DispatchQueue.main.async {
                let alertView = UIAlertController(title: "Erreur", message: "Aucun utilisateur trouvé, veuillez réessayer.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in })
                self.present(alertView, animated: true, completion: nil)
            }
        })
    }
}

