//
//  I_ShopStatsViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 20/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class I_ShopStatsViewController: UIViewController {
    @IBOutlet weak var brandNameField: UILabel!
    @IBOutlet weak var brandNoteField: CosmosView!
    @IBOutlet weak var brandEvaluationsField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentField: UILabel!
    
    var brand: I_Brand!
    var commentsArray: [Comment] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        brandNameField.text = brand.pseudo
        brandNoteField.rating = brand.rate
        brand.comments.count > 0 ? (brandEvaluationsField.text = "sur \(brand.comments.count) évaluation(s)") : (brandEvaluationsField.text = "Aucune evalutation pour le moment")
        brandEvaluationsField.text = "sur \(brand.comments.count) évaluation(s)"
        commentsArray = createCommentArray(comments: brand.comments)
        tableView.reloadData()
        super.viewDidLoad()
    }

    func createCommentArray(comments: Array<NSDictionary>) -> [Comment] {
        var tempComments: [Comment] = []

        for comment in comments {
            var infImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = comment["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            infImage = image
                        }
                    }
                }
            }
            let infPseudo = comment["pseudo"] as? String ?? ""
            let infComment = comment["comment"] as? String ?? "Aucun commentaire"
            let infRate = comment["average"] as? Double ?? 0
            tempComments.append(Comment(pseudo: infPseudo, comment: infComment, image: infImage, note: infRate))
        }
        
        return tempComments
    }
}

extension I_ShopStatsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
