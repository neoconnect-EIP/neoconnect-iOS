//
//  I_MarksViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/06/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import Cosmos

class I_MarksViewController: UIViewController {
    
    @IBOutlet weak var ratingStartView: CosmosView!
    @IBOutlet weak var numberOfMarksLabelField: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIInfManager.sharedInstance.getInfo(onSuccess: { response in
            if (response["average"] as? Double == nil) {
                self.ratingStartView.rating = 0
                self.numberOfMarksLabelField.text = "sur 0 évaluation"
            } else {
                self.ratingStartView.rating = response["average"]! as! Double
            }
        }, onFailure: { error in
            print("Request failed with error: \(error)")
        })
    }
}
