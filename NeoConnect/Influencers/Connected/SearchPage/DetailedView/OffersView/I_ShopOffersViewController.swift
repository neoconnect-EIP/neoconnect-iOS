//
//  I_OffersShopViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 20/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import SwiftUI

class I_ShopOffersViewController: UIViewController, I_OfferTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var noCommentField: UILabel!

    var brand: I_Brand!
    var offers: [I_Offer] = []

    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        loader.startAnimating()
        getDataFromAPI()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Retour - \(brand.pseudo)"
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
    }
    
    func getDataFromAPI() {
        APIInfManager.sharedInstance.getOffersByBrandId(brandId: brand.id, onSuccess: { offers in
            self.offers = self.getOfferArray(results: offers)
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
    
    func offerTapped(offer: I_Offer) {
        let rateView = DetailOffer2(selectedOffer: offer, date: "")
        let host = UIHostingController(rootView: rateView)
        
        navigationController?.pushViewController(host, animated: true)
    }
}

extension I_ShopOffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if offers.count == 0 {
            noCommentField.isHidden = true
        }
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = offers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "I_OfferTableViewCell") as! I_OfferTableViewCell
        
        cell.delegate = self
        cell.setOffer(offer: offer)
        
        return cell
    }
}
