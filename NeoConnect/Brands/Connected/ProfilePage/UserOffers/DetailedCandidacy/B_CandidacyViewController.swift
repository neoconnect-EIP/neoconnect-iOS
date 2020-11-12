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
        imageView.image = offer.images[0]
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        candidacies = createArray(results: offer.apply)
        tableView.reloadData()
    }
    
    func createArray(results: Array<NSDictionary>) -> [Candidacy] {
        var tempCandidacy: [Candidacy] = []
        
        for dictionary in results {
            guard let id = (dictionary["id"] as? NSNumber)?.intValue else { return tempCandidacy }
            guard let pseudo = dictionary["pseudo"] as? String else { return tempCandidacy }
            guard let idUser  = (dictionary["idUser"] as? NSNumber)?.intValue else { return tempCandidacy }
            guard let status = dictionary["status"] as? String else { return tempCandidacy }
            let average = dictionary["average"] as? Double ?? 0
            guard let idOffer  = (dictionary["idOffer"] as? NSNumber)?.intValue else { return tempCandidacy }
            guard let userPicture = dictionary["userPicture"] as? [[String:Any]] else { return tempCandidacy }
            guard let imageData = URL(string: (userPicture[0]["imageData"] as? String)!) else { return tempCandidacy }
            guard let imageUser = try! UIImage(data: Data(contentsOf: imageData)) else { return tempCandidacy }
            
            tempCandidacy.append(Candidacy(id: id, pseudo: pseudo, image: imageUser, idUser: idUser, idOffer: idOffer, average: average, status: status))
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
