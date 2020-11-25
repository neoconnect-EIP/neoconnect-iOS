//
//  I_ShopStatsTableViewCell.swift
//  NeoConnect
//
//  Created by Yassine Toutouh on 20/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var infImageView: PhotoFieldImage!
    @IBOutlet weak var infPseudoField: UILabel!
    @IBOutlet weak var infNoteField: CosmosView!
    @IBOutlet weak var infCommentField: UILabel!
    
    func setComment(comment: Comment) {
        infPseudoField.text = comment.pseudo
        infImageView.image = comment.image
        infNoteField.rating = comment.note
        infCommentField.text = comment.comment
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
