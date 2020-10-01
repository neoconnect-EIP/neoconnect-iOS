//
//  B_CandidaciesViewController.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_CandidaciesViewController: UIViewController {
    
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
        AF.request("http://168.63.65.106:8080/offer/shop/\(id)",
            headers: headers).responseJSON { response in
                switch response.result {
                    
                    case .success(let JSON):
                        
                        print(JSON)
                        if JSON as? String != "No offer" {
                            let results = JSON as! Array<NSDictionary>
                            self.noOfferLabelText.isHidden = true
                            self.offers = self.createArray(results: results)
                        } else {
                            self.tableView.isHidden = true
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
        let VC = segue.destination as! B_CandidacyViewController
        
        VC.offer = offer
    }
}

extension B_CandidaciesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if offers.count == 0 {
            self.noOfferLabelText.isHidden = false
        }
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = offers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandidacyTableViewCell") as! B_CandidacyTableViewCell
        
        cell.setOffer(offer: offer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
