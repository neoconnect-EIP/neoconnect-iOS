//
//  B_OffersViewController.swift
//  NeoConnect
//
//  Created by EIP on 27/02/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_OffersViewController: UIViewController {

    @IBOutlet weak var noOfferView: UIView!
    @IBOutlet weak var noOfferLabelText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var offers: [Offer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let decoded = UserDefaults.standard.data(forKey: "Shop")
        let shop = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! Shop
        var results : Array<NSDictionary> = []

        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106/offer/shop/\(shop.id)",
                   headers: headers).responseJSON { response in
                    switch response.result {
                    case .success(let JSON):
                        
                            self.showSpinner(onView: self.view)
                            print(JSON)
                            if JSON as? String != "No offer" {
                                let results = JSON as! Array<NSDictionary>
                                self.noOfferView.isHidden = true
                                self.noOfferLabelText.isHidden = true
                                self.offers = self.createArray(results: results)
                            } else {
                                self.noOfferView.isHidden = false
                                self.noOfferLabelText.isHidden = false
                            }
                            self.tableView.reloadData()
                            print(response)
                            

                            self.removeSpinner()
                        case .failure(let error):
                                print("Request failed with error: \(error)")
                    }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    func createArray(results: Array<NSDictionary>) -> [Offer] {
        var tempOffer: [Offer] = []
        
        for dictionary in results {
            let id = (dictionary["id"] as! NSNumber).intValue
            let desc = dictionary["productDesc"] as! String
            let name = dictionary["productName"] as! String
            let productImg = dictionary["productImg"] as? NSArray
            let sex = dictionary["productSex"] as! String
            let subject = dictionary["productSubject"] as! String
            let imageDict = productImg![0] as! NSDictionary
            let imageUrl = URL(string: imageDict["imageData"] as! String)!
            let image = try! UIImage(data: Data(contentsOf: imageUrl))!
            tempOffer.append(Offer(id: id, image: image, title: name, sex: sex, description: desc, subject: subject))
        }
        return tempOffer
    }
}

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}

extension B_OffersViewController : B_OffersTableViewCellDelegate {
    func deleteButtonTapped(offer: Offer) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let URL = "http://168.63.65.106/offer/" + String(offer.id)
        
        AF.request(URL, method: .delete, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
            switch response.result {
                    case .success(_):
                        // Offre modifiée
                        self.viewDidLoad()

                        print("\(String(describing: response.result))")
                        DispatchQueue.main.async {
                            let alertView = UIAlertController(title: "Great !", message: "Your offer has been deleted successfully!", preferredStyle: .alert)
                            alertView.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
                            self.present(alertView, animated: true, completion: nil)
                        }

                    case .failure(let error):
                        // Erreur de la modification de l'offre

                        print("Request failed with error: \(error)")

                    }
        }
    }
    
    func nextPageButtonTapped(id: Int, title: String, image: UIImage, sex: String, desc: String, subject: String) {
        // directly use the youtuber saved in the cell
        // show alert
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "OfferViewController") as? B_OfferViewController
        
        VC?.offerImage = image
        VC?.offerTitle = title
        VC?.offerSex = sex
        VC?.offerId = id
        VC?.offerDescription = desc
        VC?.offerSubject = subject
        
        self.show(VC!, sender: nil)
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
        cell.delegate = self
        
        return cell
    }
}
