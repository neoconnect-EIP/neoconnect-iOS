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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        getDataFromAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
        
    func getDataFromAPI() {
                
        let id = UserDefaults.standard.string(forKey: "id")!

        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106/offer/shop/\(id)",
                   headers: headers).responseJSON { response in
                    switch response.result {
                        
                    case .success(let JSON):
                        
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
                            
                        case .failure(let error):
                                print("Request failed with error: \(error)")
                    }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        let offer = self.offers[row!]
        let VC = segue.destination as! B_OfferViewController
        
        print(offer.title)
        VC.offer = offer
    }
}
//
//extension UIImage {
//
//    convenience init?(withContentsOfUrl url: URL) throws {
//        let imageData = try Data(contentsOf: url)
//
//        self.init(data: imageData)
//    }
//}

extension B_OffersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let offer = offers[indexPath.row]
            
            let title = "Delete \(offer.title)?"
            let message = "Are you sure you want to delete this book?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
                    "Content-Type": "application/x-www-form-urlencoded"
                ]

                let URL = "http://168.63.65.106/offer/" + String(offer.id)

                AF.request(URL, method: .delete, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { response in
                    switch response.result {
                            case .success(_):
                                // Offre modifiée

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
                self.offers.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if offers.count == 0 {
            self.noOfferView.isHidden = false
            self.noOfferLabelText.isHidden = false
        }
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
}
