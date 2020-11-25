//
//  I_MarksViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class I_UserMarksAndComments: UIViewController {
    
    @IBOutlet weak var userRatingField: CosmosView!
    @IBOutlet weak var userEvaluationsField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentField: UILabel!
    
    var commentsArray: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        getDataFromAPI()
        super.viewDidLoad()
    }
    
    func getDataFromAPI() {
        APIInfManager.sharedInstance.getInfo(onSuccess: { response in
            self.commentsArray = self.createCommentArray(response: response)
            self.tableView.reloadData()
        })
    }
    
    func createCommentArray(response: [String:Any]) -> [Comment] {
        var tempComments: [Comment] = []

        self.userRatingField.rating = response["average"] as? Double ?? 0
        guard let comments = response["comment"] as? Array<NSDictionary> else { return tempComments }
        for comment in comments {
            let pseudo = comment["pseudo"] as? String ?? ""
            let comment = comment["comment"] as? String ?? "Aucun commentaire"
            tempComments.append(Comment(pseudo: pseudo, comment: comment, image: #imageLiteral(resourceName: "avatar-placeholder"), note: 0))
        }
        comments.count > 0 ? (self.userEvaluationsField.text = "sur \(comments.count) évaluation(s)") : (self.userEvaluationsField.text = "Aucune evalutation pour le moment")
        return tempComments
    }
}

extension I_UserMarksAndComments: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentsArray.count > 0 {
            noCommentField.isHidden = true
        }
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = commentsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell") as! StatsTableViewCell
        
        cell.setComment(comment: comment)
        
        return cell
    }
}
