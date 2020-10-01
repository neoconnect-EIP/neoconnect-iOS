//
//  B_CandidacyViewController.swift
//  NeoConnect
//
//  Created by EIP on 08/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Alamofire

class B_CandidacyViewController: UIViewController {

    @IBOutlet weak var titleLabelField: UILabel!
    @IBOutlet weak var imageView: PhotoFieldImage!
    @IBOutlet weak var tableView: UITableView!
    
    var candidacies: [Candidacy] = []
    var offer: Offer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabelField.text = offer.title
        imageView.image = offer.image
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromAPI()
    }
    
    func getDataFromAPI() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "Token")!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        AF.request("http://168.63.65.106:8080/offer/apply/\(self.offer.id)",
            headers: headers).responseJSON { response in
                switch response.result {
                    
                    case .success(let JSON):
                        
                        let results = JSON as! Array<NSDictionary>
                        self.candidacies = self.createArray(results: results)
                           
                        self.tableView.reloadData()
                    
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                }
        }
    }
    
    func createArray(results: Array<NSDictionary>) -> [Candidacy] {
        var tempCandidacy: [Candidacy] = []
        
        for dictionary in results {
            let id = (dictionary["id"] as! NSNumber).intValue
            let pseudo = dictionary["pseudoUser"] as! String
            let idUser  = (dictionary["idUser"] as! NSNumber).intValue
            let status = dictionary["status"] as! String
            let average = dictionary["average"] as! Double
            let idOffer  = (dictionary["idOffer"] as! NSNumber).intValue
            let imageArray = dictionary["userPicture"] as? [[String:Any]]
            let imageUrl = URL(string: imageArray![0]["imageData"] as! String)!
            let imageData = try! UIImage(data: Data(contentsOf: imageUrl))!
            tempCandidacy.append(Candidacy(id: id, pseudo: pseudo, image: imageData, idUser: idUser, idOffer: idOffer, average: average, status: status))
        }
        return tempCandidacy
    }
}

extension B_CandidacyViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidacies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let candidacy = candidacies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfTableViewCell") as! B_DetailedCandidacyTableViewCell
        
        cell.setCandidacy(candidacy: candidacy)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
