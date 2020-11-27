//
//  B_OffersViewController.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire
import StatusAlert

class B_OffersViewController: UIViewController {

    @IBOutlet weak var noOfferLabelText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var offers: [B_Offer] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        loader.startAnimating()
        getDataFromAPI()
    }
        
    func getDataFromAPI() {
        let id = UserDefaults.standard.string(forKey: "id")!

        APIManager.sharedInstance.getOffersByShopId(id: id, onSuccess: { JSON in
            if JSON as? String != "No offer" {
                let results = JSON as! Array<NSDictionary>
                self.offers = self.createArray(results: results)
            } else {
                self.noOfferLabelText.isHidden = false
            }
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        })
    }
    
    func createArray(results: Array<NSDictionary>) -> [B_Offer] {
        var tempOffer: [B_Offer] = []
        
        for dictionary in results {
            guard let id = (dictionary["id"] as? NSNumber)?.intValue else { return tempOffer }
            guard let desc = dictionary["productDesc"] as? String else { return tempOffer }
            guard let name = dictionary["productName"] as? String else { return tempOffer }
            guard let subject = dictionary["productSubject"] as? String else { return tempOffer }
            let sex = dictionary["productSex"] as? String ?? "Sexe"
            guard let applyDict = dictionary["apply"] as? Array<NSDictionary> else { return tempOffer }
            var imageArray: [UIImage] = []
            if let productImgs = dictionary["productImg"] as? [[String:Any]] {
                for productImage in productImgs {
                    if let imageUrl = URL(string: (productImage["imageData"] as? String)!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageUrl)) {
                            imageArray.append(image)
                        }
                    }
                }
            }
            tempOffer.append(B_Offer(id: id, images: imageArray, title: name, sex: sex, description: desc, subject: subject, apply: applyDict))
        }
        return tempOffer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        let offer = self.offers[row!]
        let VC = segue.destination as! B_OfferViewController
        
        VC.offer = offer
    }
}

extension B_OffersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = offers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell") as! B_OffersTableViewCell
    
        cell.setOffers(offer: offer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let offer = offers[indexPath.row]
            
            let title = "Delete \(offer.title)?"
            let message = "Are you sure you want to delete this offer?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                APIBrandManager.sharedInstance.deleteOffer(id: String(offer.id), onSuccess: {
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Great !", message: "Your offer has been deleted successfully!", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                        self.present(alertView, animated: true, completion: nil)
                    }
                    self.offers.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                })
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
}
