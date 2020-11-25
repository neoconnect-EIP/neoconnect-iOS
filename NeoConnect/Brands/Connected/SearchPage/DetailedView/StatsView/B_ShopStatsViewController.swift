//
//  I_ShopStatsViewController.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 20/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class B_ShopStatsViewController: UIViewController {
    
    @IBOutlet weak var infPseudoField: UILabel!
    @IBOutlet weak var infNoteField: CosmosView!
    @IBOutlet weak var infEvaluationsField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noCommentField: UILabel!
    
    var inf: Inf!
    var commentsArray: [Comment] = []
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        infPseudoField.text = inf.pseudo
        infNoteField.rating = inf.average
        inf.comments.count > 0 ? (infEvaluationsField.text = "sur \(inf.comments.count) évaluation(s)") : (infEvaluationsField.text = "Aucune evalutation pour le moment")
        infEvaluationsField.text = "sur \(inf.comments.count) évaluation(s)"
        commentsArray = createCommentArray(comments: inf.comments)
        tableView.reloadData()
        super.viewDidLoad()
    }

    func createCommentArray(comments: Array<NSDictionary>) -> [Comment] {
        var tempComments: [Comment] = []

        for comment in comments {
            var brandImage: UIImage = #imageLiteral(resourceName: "avatar-placeholder")
            if let userPicture = comment["userPicture"] as? [[String:String]] {
                if userPicture.count > 0 {
                    if let imageData = URL(string: (userPicture[0]["imageData"])!) {
                        if let image = try! UIImage(data: Data(contentsOf: imageData)) {
                            brandImage = image
                        }
                    }
                }
            }
            let brandPseudo = comment["pseudo"] as? String ?? ""
            let brandComment = comment["comment"] as? String ?? "Aucun commentaire"
            let brandRate = comment["average"] as? Double ?? 0
            tempComments.append(Comment(pseudo: brandPseudo, comment: brandComment, image: brandImage, note: brandRate))
        }
        
        return tempComments
    }
}

extension B_ShopStatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentsArray.count > 0 {
            noCommentField.isHidden = true
        }
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = commentsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "I_ShopStatsCell") as! StatsTableViewCell
        
        cell.setComment(comment: comment)
        
        return cell
    }
}
